classdef DisplayableHandle < handle
  % A mix-in class for custom display with dispstr() and dispstrs(), for handles
  %
  % To use this, inherit from it, and define a custom dispstrs() method. It
  % will be picked up and used by dispstr() and disp(), which will also make
  % display() respect it.
  %
  % Examples:
  %
  % classdef Birthday < dispstrlib.DisplayableHandle
  %
  %     properties
  %         Month
  %         Day
  %     end
  %
  %     methods
  %         function this = Birthday(month, day)
  %             this.Month = month;
  %             this.Day = day;
  %         end
  %     end
  %
  %     methods (Access = protected)
  %         function out = dispstr_scalar(this)
  %             out = datestr(datenum(1, this.Month, this.Day), 'mmm dd');
  %         end
  %     end
  %
  % end
  %
  % See also:
  % dispstrlib.Displayable
  
  methods
    
    function disp(this)
      % Custom display
      if isscalar(this)
        disp(dispstr_scalar(this));
      else
        strs = dispstrs(this);
        fancyclip.internal.DispstrHelper.disparray(strs);
      end
    end
    
    function out = dispstr(this)
      % Custom display string for this array as a whole.
      if isscalar(this)
        out = dispstr_scalar(this);
      else
        % Default to doing an opaque display, because we don't know if the
        % object is going to spam whatever context it's in.
        out = sprintf('<%s %s>', size2str(size(this)), class(this));
      end
    end
    
    function out = dispstrs(this)
      % Element-wise custom display strings
      %
      % Gets the custom display strings for each element of this array, as
      % opposed to a custom display string
      % Returns a string array the same size size as this.
      out = repmat(string(missing), size(this));
      for i = 1:numel(this)
        out(i) = dispstr_scalar(subsref(this, ...
          struct('type','()', 'subs',{{i}})));
      end
    end
    
  end
  % Now here are some overrides that let you pass Displayables as arguments to
  % Matlab's own error(), warning(), and related functions, and they'll
  % auto-convert into strings that the %s conversion specifier can handle.
  
  methods
    
    function error(varargin)
      args = convertDisplayablesToString(varargin);
      err = MException(args{:});
      throwAsCaller(err);
    end
    
    function warning(varargin)
      args = convertDisplayablesToString(varargin);
      warning(args{:});
    end
    
    function out = sprintf(varargin)
      args = convertDisplayablesToString(varargin);
      out = sprintf(args{:});
    end
    
    function out = fprintf(varargin)
      args = convertDisplayablesToString(varargin);
      out = sprintf(args{:});
    end
    
  end
  
  
  methods (Access = protected)
    function out = dispstr_scalar(this) %#ok<STOUT>
      error('jl:Unimplemented', ['Subclasses of DisplayableHandle must override ' ...
        'dispstr_scalar; %s does not'], ...
        class(this));
    end
  end
  
end

function out = convertDisplayablesToString(c)
assert(iscell(c));
out = c;
for i = 1:numel(c)
  if isa(c{i}, 'dispstrlib.DisplayableHandle')
    out{i} = dispstr(c{i});
  end
end
end