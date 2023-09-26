cmake_minimum_required(VERSION 3.12)
include(ExternalProject)

project(Krogre VERSION 1.0)

# The COMPONENTS part checks that OGRE was built the way we need it
# The CONFIG flag makes sure we get OGRE instead of OGRE-next
find_package(OGRE REQUIRED COMPONENTS Bites CONFIG)
find_package(assimp REQUIRED)

set(MAKE_DIRECTORY ${CMAKE_SOURCE_DIR}/ext/LuaJIT)

execute_process(
    COMMAND make
    WORKING_DIRECTORY ${MAKE_DIRECTORY}
    RESULT_VARIABLE MAKE_RESULT
)

if(MAKE_RESULT EQUAL 0)
    message(STATUS "Successfully ran 'make' in ${MAKE_DIRECTORY}")
else()
    message(FATAL_ERROR "Error running 'make' in ${MAKE_DIRECTORY}")
endif()


file(GLOB SOURCES "src/*.cpp")

file(COPY "./resources" DESTINATION "${CMAKE_BINARY_DIR}")

# add the source files as usual
add_executable(Krogre ${SOURCES})
 
# this also sets the includes and pulls third party dependencies
add_library(luajit OBJECT "./ext/LuaJIT/src/libluajit.a")
target_link_libraries(Krogre OgreBites assimp::assimp luajit)