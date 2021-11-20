# EmbeddedProjectSetup

## Structure
  + __README.md__: description of project, supported hardware, etc.
  + __toolchains/__ : location of toolchains, gcc, clang, etc.
  + __libs/__ : all libraries used by project, tests, etc. These are soft linked into each build directory that needs them.
    + library 1
    + library 2
    + ...
  + __tests/__
    + CMakeLists.txt
    + source
  + __project/__ : 
    - CMakeLists.txt
    - linker_script.ld : All of the linker scripts are stored at the project level
    - source
  - __documents/__
    - design.md: high level design doc
    - other documents: all design documents, calculations, etc
  - __scripts/__ : code generation source, setup scripts
  - __build/__ : location for building source for all code bases. Ignored by git.
  - __emulator/__ : Optional construction of an emulation interface, can be local or an actual emulator, whichever is needed.
    - README.md: description of the system
    - CMakeLists.txt
    - source
  - __Releases/__ : location of official build binaries. These are stored and carried in the git repo as they are small an ocassionally essential.

## Setting Up
- Pull script: wget https://raw.githubusercontent.com/snhobbs/EmbeddedProjectSetup/master/setup_embedded.sh
- Run in project directory: sh setup_embedded.sh
