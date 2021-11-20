#!/bin/sh

export project_name=$1

touch README.md
wget https://raw.githubusercontent.com/snhobbs/CMakeGitignore/main/.gitignore
# curl default top level cmake

mkdir board
mkdir board/include
mkdir board/source

mkdir project
mkdir project/source
# curl default project cmake
# default main.cpp?

mkdir tests
touch tests/README.md
mkdir tests/source
# curl default test cmake

# Setup Toolchain
mkdir toolchains
cd toolchains
export toolchain=gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2
if test ! -f "$toolchain" ; then
  wget https://developer.arm.com/-/media/Files/downloads/gnu-rm/10.3-2021.10/$toolchain
fi
tar -xf $toolchain
cd ../ # top

mkdir emulator

mkdir documents
touch documents/design.md

mkdir libs
# get gtest & gmock, link into tests
# get default main.cpp for testing
cd libs
if test ! -f "googletest" ; then
  git clone git@github.com:google/googletest.git
fi

cd googletest
cmake ./
make -j4
cd ../ # libs

if test ! -f "CMakeTools" ; then
  git clone git@github.com:snhobbs/CMakeTools.git
fi
cd ../ # top

mkdir releases
mkdir build

# curl default linker scripts
