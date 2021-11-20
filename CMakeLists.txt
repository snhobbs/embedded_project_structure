cmake_minimum_required(VERSION 3.10)

if (POLICY CMP0048)
  cmake_policy(SET CMP0048 NEW)
endif (POLICY CMP0048)

project(${ProjectName})

enable_testing()

set(ProjectDirectory "${CMAKE_CURRENT_SOURCE_DIR}")
add_subdirectory(project)
add_subdirectory(tests)
