#!/bin/sh

export project_name=$1

if test ! -f "README.md" ; then
  touch README.md
  echo "Project: $project_name" >> README.md
fi

if test ! -f "CMakeLists.txt" ; then
  https://raw.githubusercontent.com/snhobbs/EmbeddedProjectSetup/master/CMakeLists.txt
fi

if test ! -f ".gitignore" ; then
  wget https://raw.githubusercontent.com/snhobbs/CMakeGitignore/main/.gitignore
fi

mkdir -p board/{include/source}

mkdir -p project/source
# curl default project cmake
# default main.cpp?

mkdir -p tests/source
touch tests/README.md
cd tests
if test ! -f "CMakeLists.txt" ; then
  wget https://raw.githubusercontent.com/snhobbs/EmbeddedProjectSetup/master/tests/CMakeLists.txt
fi

cd source

if test ! -f "main.cpp" ; then
  wget https://raw.githubusercontent.com/snhobbs/EmbeddedProjectSetup/master/tests/source/main.cpp
fi

cd ../.. # top

# Setup Toolchain
mkdir toolchains
cd toolchains
export toolchain=gcc-arm-none-eabi-10.3-2021.10
echo "https://developer.arm.com/-/media/Files/downloads/gnu-rm/10.3-2021.10/$toolchain-x86_64-linux.tar.bz2"
if test ! -d "$toolchain" ; then
  wget "https://developer.arm.com/-/media/Files/downloads/gnu-rm/10.3-2021.10/$toolchain-x86_64-linux.tar.bz2"
  tar -xf "$toolchain"-x86_64-linux.tar.bz2
fi
cd ../ # top

mkdir emulator

mkdir documents
touch documents/design.md

mkdir libs
cd libs
# get gtest & gmock, link into tests
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
