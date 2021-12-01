#!/bin/sh
export project_name=$1
REPO_NAME="https://raw.githubusercontent.com/snhobbs/embedded_project_structure/master/"

if test ! -d ".git" ; then
  git init .
fi

if test ! -f "README.md" ; then
  touch README.md
  echo "#Project: $project_name" >> README.md
fi

if test ! -f "CMakeLists.txt" ; then
  wget $REPO_NAME"CMakeLists.txt"
fi

if test ! -f ".gitignore" ; then
  wget $REPO_NAME"embedded_project.gitignore" .gitignore
fi

mkdir -p board/include
mkdir -p board/source

mkdir -p project/source
# curl default project cmake
# default main.cpp?
cd project
if test ! -f "CMakeLists.txt" ; then
  wget $REPO_NAME"project/CMakeLists.txt"
fi

cd source
if test ! -f "main.cpp" ; then
  wget $REPO_NAME"project/source/main.cpp"
fi
cd ../.. #Top

mkdir -p tests/source
touch tests/README.md
cd tests
if test ! -f "CMakeLists.txt" ; then
  wget $REPO_NAME"tests/CMakeLists.txt"
fi

ln -s ../libs/googletest ./

cd source

if test ! -f "main.cpp" ; then
  wget $REPO_NAME"tests/source/main.cpp"
fi

cd ../.. # top

# Setup Toolchain
mkdir toolchains
cd toolchains
export TOOLCHAIN="10.3-2021.10"
export TOOLCHAIN_DIR="gcc-arm-none-eabi-"$TOOLCHAIN
export TOOLCHAIN_TARBALL=$TOOLCHAIN_DIR"-x86_64-linux.tar.bz2"
export TOOLCHAIN_URL="https://developer.arm.com/-/media/Files/downloads/gnu-rm/"$TOOLCHAIN"/"$TOOLCHAIN_TARBALL
echo $TOOLCHAIN_URL
echo $TOOLCHAIN_DIR

if test ! -d "$TOOLCHAIN_DIR" ; then
  wget $TOOLCHAIN_URL
  tar -xf $TOOLCHAIN_TARBALL
fi
cd ../ # top

mkdir documents
touch documents/design.md

mkdir libs
cd libs
# get gtest & gmock, link into tests
if test ! -f "googletest" ; then
  git submodule add git@github.com:google/googletest.git
fi

cd googletest
cmake ./ -B build
make -j4 --directory=build
cd ../ # libs
cd ../ # top

mkdir releases
mkdir build

cmake -B build -DProjectName=$project_name
make --directory=build
make test --directory=build
