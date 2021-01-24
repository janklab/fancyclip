
[![Travis Build Status](https://travis-ci.com/janklab/fancyclip.svg?branch=main)](https://travis-ci.com/github/janklab/fancyclip)

Enhanced clipboard copy and paste for Matlab

## About

Enhanced clipboard copy and paste for Matlab. Supports copying as HTML or JSON, pasting to Excel as tabular data, and more.

## Installation

To install fancyclip, download it from the [Releases page](https://github.com/janklab/fancyclip/releases) or clone the [repo](https://github.com/janklab/fancyclip) to get it on your disk. Then add its `Mcode/` folder to your Matlab path.

## Usage

### Examples

```matlab
% Load library
addpath Mcode

% Copy stuff to clipboard

x = magic(4) + rand(4);
fancyclip.copy(x, "text/html");

s = struct('foo', 42, 'bar', [1 2 3], 'baz', "Hello, world!", 'qux', struct('x', magic(3), 'y', 'Some data', 'z', 1:3));
fancyclip.copy(s, "text/html");

% Paste from clipboard in various formats

html = fancyclip.paste('text/html')

% See what's available on the clipboard

fancyclip.availableDataFlavors
```

## Author

fancyclip is written and maintained by [Andrew Janke](https://your-website.com). The project home page is <https://github.com/janklab/fancyclip>.

## Acknowledgments

This project was created with [MatlabProjectTemplate](https://github.com/apjanke/MatlabProjectTemplate) by [Andrew Janke](https://apjanke.net).
