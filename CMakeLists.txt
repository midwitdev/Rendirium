cmake_minimum_required(VERSION 3.12)
include(ExternalProject)

project(Krogre VERSION 1.0)

# The COMPONENTS part checks that OGRE was built the way we need it
# The CONFIG flag makes sure we get OGRE instead of OGRE-next
add_subdirectory(ext/ogre3d)

find_package(assimp REQUIRED)

file(GLOB SOURCES "${CMAKE_SOURCE_DIR}/src/*.cpp")
file(GLOB LUA_SOURCES "${CMAKE_SOURCE_DIR}/src/*.lua")
file(GLOB RESOURCES "${CMAKE_SOURCE_DIR}/resources")

add_custom_target(copy-resources ALL
    COMMAND ${CMAKE_COMMAND} -E copy_directory ${RESOURCES} ${CMAKE_BINARY_DIR})

add_custom_target(copy-lua-sources ALL
    COMMAND ${CMAKE_COMMAND} -E copy ${LUA_SOURCES} ${CMAKE_BINARY_DIR})

add_custom_target(copy-files ALL
    DEPENDS copy-resources
    DEPENDS copy-lua-sources)

# add the source files as usual
add_library(Krogre SHARED ${SOURCES})

target_include_directories(Krogre PRIVATE "${CMAKE_SOURCE_DIR}/ext/LuaJIT/src" DEPENDS copy-files)
# this also sets the includes and pulls third party dependencies
target_link_libraries(Krogre PRIVATE OgreBites assimp::assimp "${CMAKE_SOURCE_DIR}/ext/LuaJIT/src/libluajit.a")