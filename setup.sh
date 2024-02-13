#!/bin/bash

echo "Creating a new CPP Raylib project"

PROJECT_NAME="project_name" # default project name if not provided as argument

if [ -z "$1" ]; then
    echo "No project name provided, using default project name"
else
    PROJECT_NAME=$1
fi

if test -d .git; then
    echo "Removing .git directory"
    rm -rf .git
fi

echo "Creating directories"
mkdir -p build
mkdir -p vendor
# mkdir -p resources # optional directory for resources
echo "Initializing git"
git init .

if test -e .gitignore; then
    echo ".gitignore already exists"
else
    echo "Creating .gitignore"
    echo "build" > .gitignore
fi

if test -d vendor/raylib; then
    echo "Raylib submodule already exists"
else
    echo "Add submodules"
    echo "Adding raylib submodule to vendor/raylib"
    git submodule add https://github.com/raysan5/raylib.git vendor/raylib
fi

cmakefile="CMakeLists.txt"

if test -e $cmakefile; then
    rm $cmakefile    
fi

if [ ! -e "$cmakefile" ]; then
    echo "Creating CMakeLists.txt"
    cat <<EOL > CMakeLists.txt
cmake_minimum_required(VERSION 3.27)

# set project name
project($PROJECT_NAME)

set(CMAKE_CXX_STANDARD 23)

set(SOURCE_DIR src)
set(VENDOR_DIR vendor)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

add_subdirectory("\${VENDOR_DIR}/raylib")

file(GLOB_RECURSE SOURCE_FILES 
    "\${SOURCE_DIR}/**.cpp" 
    "\${SOURCE_DIR}/**.h" 
)

set(INCLUDE_DIRECTORIES
    "\${SOURCE_DIR}"
    "\${VENDOR_DIR}/raylib/src"
)

add_executable($PROJECT_NAME "\${SOURCE_FILES}")

target_include_directories($PROJECT_NAME PUBLIC \${INCLUDE_DIRECTORIES})

target_link_libraries($PROJECT_NAME PUBLIC raylib)

# file(COPY "resources" DESTINATION "\${CMAKE_BINARY_DIR}")
EOL
fi

echo "Finished setting up project"