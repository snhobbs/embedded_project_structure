# embedded_project_structure 
An explanation of this structure is available [here](https://gist.github.com/snhobbs/e763280e3f9253df3cf50f1481c26ead).
The example is setup with [this script](https://github.com/snhobbs/embedded_project_structure/blob/master/setup_embedded.sh).

## Setting Up
```sh
cd <PROJECT_NAME>
wget https://raw.githubusercontent.com/snhobbs/embedded_project_structure/master/setup_embedded.sh # Pull script
sh setup_embedded.sh # Run in project directory
```

## Structure
This is a simplified structure with the basic components 

+ __\<PROJECT_NAME\>/__
  + README.md
  + [CMakeLists.txt](https://github.com/snhobbs/embedded_project_structure/blob/master/CMakeLists.txt)
  + [.gitignore](https://github.com/snhobbs/embedded_project_structure/blob/master/embedded_project.gitignore)
  + __board/__ : No board library is actually imported, the SDK from a particular vendor is added here.
    + __source/__
    + __include/__
  + __toolchains/__
    + [gcc-arm-none-eabi-10.3-2021.10](https://developer.arm.com/-/media/Files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2)
  + __libs/__ 
    + [googletest](git@github.com:google/googletest.git)
  + __tests/__
    + [CMakeLists.txt](https://github.com/snhobbs/embedded_project_structure/blob/master/tests/CMakeLists.txt)
    + __source/__
    + googletest: softlink to ../libs/googletest
  + __project/__
    + CMakeLists.txt
    + __source/__
      + main.cpp: Hello world program for the compiling system. This is supposed to be replaced with the project build.
  + __documents/__
    + design.md: High level design doc
  + __scripts/__
  + __build/__
  + __Releases/__
