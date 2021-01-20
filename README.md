# MatlabProjectTemplate

[![Travis Build Status](https://travis-ci.com/janklab/MatlabProjectTemplate.svg?branch=main)](https://travis-ci.com/github/janklab/MatlabProjectTemplate)  [![CircleCI Build Status](https://circleci.com/gh/janklab/MatlabProjectTemplate.svg?style=shield)](https://circleci.com/gh/janklab/MatlabProjectTemplate) [![Azure Build Status](https://dev.azure.com/janklab/MatlabProjectTemplate/_apis/build/status/janklab.MatlabProjectTemplate?branchName=main)](https://dev.azure.com/janklab/MatlabProjectTemplate/_build/latest?definitionId=1&branchName=main) [![View MatlabProjectTemplate on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/85840-matlabprojecttemplate)

This is a template repo for creating Matlab library and application projects. It defines a "standard" project structure that should be suitable for many projects, including those intended for redistribution / open source.

It is suitable for both libraries and applications, and includes coding and organizational conventions that make it safe to use this project's code in a Matlab environment that uses code from other projects, too.

## Features

MatlabProjectTemplate supports the following features. You don't _have_ to use any of them; you can just ignore the ones you don't care about. But they're there if you need them!

* Collaboration between multiple developers
* Building [Matlab Toolboxes](https://www.mathworks.com/help/matlab/matlab_prog/create-and-share-custom-matlab-toolboxes.html)
* Matlab [Continuous Integration](https://www.mathworks.com/solutions/continuous-integration.html) and unit tests
* Distribution as both plain zip files and Matlab Toolbox `.mltbx` files
* Using ("vendoring") third-party Java JAR and Matlab libraries
* Custom Java code
* Library initialization
* _Automatic_ library initialization
* Logging, in an [SLF4M](https://github.com/janklab/SLF4M)/SLF4J/Log4j-compatible manner

## Requirements

Some features, including project initialization, only work on Mac and Linux. But don't worry! If you're on Windows, just install [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/install-win10) and use that.

## Usage

To create a new project from this template, go on GitHub, create a new repo, and select this repo as its template.

Then:

* Add a license file!
* Edit the variables `project_settings.sh`.
* Run `init_project_from_template.sh`.
* Edit `.editorconfig` to reflect your preferred code style.
* Edit `<myproject>.prj.in` and put in all your contact and descriptive info and other stuff.

And then:

* Put your main Matlab source code in `Mcode/`.
* Put your example scripts in `examples/`.
* Edit the files in `doc-project` to reflect your plans.
* Hack away!

When you're developing code for your project, you should add the `dev-kit/` directory to your Matlab path.

See `MatlabProjectTemplate/README.md` and other documents in the `MatlabProjectTemplate/` directory for more information and details.

## Unit tests

You should write unit tests for your project! Use the [Matlab Unit Test Framework](https://www.mathworks.com/help/matlab/matlab-unit-test-framework.html) and put your tests in `Mcode/+<myproject>/+test`. Run them with `make test` in the shell or with `dev-kit/launchtests.m` in Matlab.

## License

MatlabProjectTemplate is multi-licensed under all of: MIT License, BSD 2-Clause License, Apache License, and GPLv3. You can use it in any project with a license compatible with any of those licenses. This includes commercial and proprietary software.

If you have a licensing scenario which is not covered by the above (and jeez, what are you doing that would require _that_?), just contact me, and I'll probably add support for it. My intention is that _everybody_ can use MatlabProjectTemplate.

## About MatlabProjectTemplate

MatlabProjectTemplate was written by [Andrew Janke](https://apjanke.net). The project home page is <https://github.com/janklab/MatlabProjectTemplate>. You can get support, or even contribute to the project, there.

See the [FAQ](https://github.com/janklab/MatlabProjectTemplate/blob/main/MatlabProjectTemplate/doc/FAQ.md) or the stuff in the `MatlabProjectTemplate/doc` directory for more info.
