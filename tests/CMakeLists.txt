cmake_minimum_required(VERSION 3.10.0)

if(${CMAKE_SOURCE_DIR} STREQUAL ${CMAKE_CURRENT_SOURCE_DIR})
project(Testing)
set(ProjectDirectory "${CMAKE_CURRENT_SOURCE_DIR}/..")
set(LibraryDirectory ${ProjectDirectory}/libs)
endif()

message("\n\nProject directory ${ProjectDirectory}\n\n")

set(TargetName "testing")
add_executable(${TargetName})

message("\n\nTest include directory ${LibraryDirectory}\n\n")
set(GTEST_DIR "googletest/googletest")
target_include_directories(${TargetName} PUBLIC "${GTEST_DIR}/include")

set(ProjectSource ${ProjectDirectory}/project/source)
set(BoardDirectory ${ProjectDirectory}/board)
set(TestSources ${CMAKE_CURRENT_SOURCE_DIR}/source)
message("proj source ${ProjectSource}")

target_sources(${TargetName} PRIVATE
  source/main.cpp
)


# Add Data directory
#target_compile_definitions(
#  ${TargetName}
#  PUBLIC
#  -D__DIR__="${CMAKE_CURRENT_SOURCE_DIR}/data"
#)

# Compile definitions
#target_compile_definitions(
#    ${TargetName}
#    PUBLIC
#    -DMODBUS
#)

target_compile_options(
${TargetName}
PRIVATE
    -fsanitize=address
    -fno-omit-frame-pointer
    -fsanitize=undefined)
target_compile_options(
${TargetName}
PRIVATE
    -Wall
    -Wextra
    -pedantic
    -Wpedantic
    -g3
    #-pedantic-errors
    #-Werror=pedantic

    -Wconversion
    $<$<COMPILE_LANGUAGE:C>:-Wimplicit>
    $<$<COMPILE_LANGUAGE:C>:-Wunused>

    #$<$<COMPILE_LANGUAGE:CXX>:-fno-exceptions>
    #$<$<COMPILE_LANGUAGE:CXX>:-Wabi>
    $<$<CXX_COMPILER_ID:GNU>:-Wsuggest-final-types>
    $<$<CXX_COMPILER_ID:GNU>:-Wmaybe-uninitialized>
    $<$<CXX_COMPILER_ID:GNU>:-Wdouble-promotion>
    #$<$<CXX_COMPILER_ID:GNU>:-Wnull-dereference>
    -Winit-self

    #$<$<CXX_COMPILER_ID:GNU>:-Wduplicated-cond>
    #$<$<CXX_COMPILER_ID:GNU>:-Wduplicated-branches>
    #$<$<CXX_COMPILER_ID:GNU>:-Wlogical-op>
    #$<$<CXX_COMPILER_ID:GNU>:-Wrestrict>
    $<$<C_COMPILER_ID:GNU>:$<$<COMPILE_LANGUAGE:C>:-Wjump-misses-init>>
    $<$<COMPILE_LANGUAGE:CXX>:-Wold-style-cast>
    -Wshadow
)

set_property(TARGET ${TargetName} PROPERTY CXX_STANDARD 17)
target_compile_features(${TargetName} PUBLIC cxx_std_17)
target_compile_definitions(${TargetName} PRIVATE TESTING)
target_compile_definitions(${TargetName} PRIVATE UNITTESTING)
target_compile_definitions(${TargetName} PRIVATE LINUX)
target_compile_definitions(${TargetName} PRIVATE DEBUG)
#target_compile_options(${TargetName} PRIVATE -fpermissive)
#target_compile_options(-fprofile-arcs -ftest-coverage)

#SET(GCC_COVERAGE_LINK_FLAGS    "-coverage -lgcov")
#set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${GCC_COVERAGE_LINK_FLAGS}")

SET(CMAKE_VERBOSE_MAKEFILE ON)

target_link_libraries( ${TargetName} asan)
#target_link_libraries( ${TargetName} tsan)
target_link_libraries( ${TargetName} ubsan)
#target_link_libraries( ${TargetName} msan)

#----------------------------------------------------------------------
# GTEST
#----------------------------------------------------------------------
target_include_directories(${TargetName} PUBLIC "${GTEST_DIR}/include")
target_link_directories(${TargetName} PUBLIC ${GTEST_DIR}/../build/lib)
target_link_libraries(${TargetName} gtest)
target_link_libraries(${TargetName} pthread)
#----------------------------------------------------------------------

#list(APPEND CMAKE_SYSTEM_INCLUDE_PATH "/usr/include")
target_include_directories(${TargetName} PUBLIC ${ProjectSource})
target_include_directories(${TargetName} PUBLIC ${ProjectSource}/../libs)
target_include_directories(${TargetName} PUBLIC ${BoardDirectory}/include )
target_include_directories(${TargetName} PUBLIC ${TestSources} )


message(STATUS "Sources: ${DIR_SRCS}")
message("System Path" ${CMAKE_SYSTEM_INCLUDE_PATH})

add_test(NAME tests COMMAND ${TargetName})
