function fancyclip_make(target)
% Build tool for fancyclip

%#ok<*STRNU>

arguments
  target (1,1) string
end

if target == "build"
  fancyclip_build;
elseif target == "buildmex"
  fancyclip_build_all_mex;
elseif target == "doc-src"
  make_package_docs --src
elseif target == "doc"
  make_package_docs;
elseif target == "doc-preview"
  preview_docs;
elseif target == "m-doc"
  fancyclip_make doc;
  make_mdoc;
elseif target == "toolbox"
  fancyclip_make m-doc;
  fancyclip_package_toolbox;
elseif target == "clean"
  make_clean
elseif target == "test"
  fancyclip_launchtests
elseif target == "dist"
  fancyclip_make build
  fancyclip_make m-doc
  make_dist
elseif target == "simplify"
  make_simplify
else
  error("Undefined target: %s", target);
end

end

function make_mdoc
  rmrf('build/M-doc')
  mkdir2('build/M-doc')
  copyfile2('doc/*', 'build/M-doc')
  if isfile('build/M-doc/feed.xml')
    delete('build/M-doc/feed.xml')
  end
end

function preview_docs
import fancyclip.internal.util.*;
RAII.cd = withcd('docs');
make_doc --preview
end

function make_dist
  program = "fancyclip";
  distName = program + "-" + fancyclip.globals.version;
  verDistDir = fullfile("dist", distName);
  distfiles = ["build/Mcode" "doc" "lib" "examples" "README.md" "LICENSE" "CHANGES.txt"];
  rmrf([verDistDir, distName+".tar.gz", distName+".zip"])
  if ~isfolder('dist')
    mkdir2('dist')
  end
  mkdir2(verDistDir)
  copyfile2(distfiles, verDistDir)
  RAII.cd = withcd('dist');
  tar(distName+".tar.gz", distName)
  zip(distName+".zip", distName)
end

function make_clean
rmrf(strsplit("dist/* build docs/site docs/_site M-doc test-output", " "));
end

function make_simplify
rmrf(strsplit(".circleci .travis.yml azure-pipelines.yml src lib/java/MyCoolProject-java", " "));
end

function make_package_docs(varargin)
doOnlySrc = ismember('--src', varargin);
build_docs;
if ~doOnlySrc
  build_doc;
end
end

function build_docs
% Build the generated parts of the doc sources
RAII.cd = withcd(reporoot); 
docsDir = fullfile(reporoot, 'docs');
% Copy over examples
docsExsDir = fullfile(docsDir, 'examples');
if isfolder(docsExsDir)
  rmdir2(docsExsDir, 's');
end
copyfile('examples', fullfile('docs', 'examples'));
% TODO: Generate API Reference
end

function build_doc
% Build the final doc files
RAII.cd = withcd(fullfile(reporoot, 'docs'));
make_doc;
delete('../doc/make_doc*');
end
