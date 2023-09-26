cmake_minimum_required(VERSION 3.12)

project(Test VERSION 1.0)

# The COMPONENTS part checks that OGRE was built the way we need it
# The CONFIG flag makes sure we get OGRE instead of OGRE-next
find_package(OGRE REQUIRED COMPONENTS Bites CONFIG)
 
file(GLOB SOURCES "src/*.cpp")

# add the source files as usual
add_executable(Test ${SOURCES})
 
# this also sets the includes and pulls third party dependencies
target_link_libraries(Test OgreBites)