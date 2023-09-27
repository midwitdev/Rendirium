cmake_minimum_required(VERSION 3.12)
include(ExternalProject)

project(Krogre VERSION 1.0)

# The COMPONENTS part checks that OGRE was built the way we need it
# The CONFIG flag makes sure we get OGRE instead of OGRE-next
find_package(OGRE REQUIRED COMPONENTS Bites CONFIG)
find_package(assimp REQUIRED)

file(GLOB SOURCES "src/*.cpp")
file(GLOB LUA_SOURCES "src/*.lua")

file(COPY "./resources" DESTINATION "${CMAKE_BINARY_DIR}")
file(COPY ${LUA_SOURCES} DESTINATION "${CMAKE_BINARY_DIR}")

# add the source files as usual
add_library(Krogre SHARED ${SOURCES})

target_include_directories(Krogre PRIVATE "${CMAKE_SOURCE_DIR}/ext/LuaJIT/src")
# this also sets the includes and pulls third party dependencies
target_link_libraries(Krogre PRIVATE OgreBites assimp::assimp "${CMAKE_SOURCE_DIR}/ext/LuaJIT/src/libluajit.a")