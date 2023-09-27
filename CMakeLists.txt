cmake_minimum_required(VERSION 3.12)
include(ExternalProject)

set(CMAKE_COMPILE_WARNING_AS_ERROR OFF)

project(Krogre VERSION 1.0)

find_package(Vulkan REQUIRED)
find_package(glfw3 REQUIRED)

file(GLOB KROGRE_SOURCES "${CMAKE_SOURCE_DIR}/src/*.cpp")
file(GLOB LUA_SOURCES "${CMAKE_SOURCE_DIR}/src/*.lua")
file(GLOB KROGRE_RESOURCES "${CMAKE_SOURCE_DIR}/resources")

# target for copying krogre resource files
add_custom_target(copy-resources
    COMMAND ${CMAKE_COMMAND} -E copy_directory ${KROGRE_RESOURCES} ${CMAKE_BINARY_DIR})

# target for copying krogre lua files
add_custom_target(copy-lua-sources
    COMMAND ${CMAKE_COMMAND} -E copy ${LUA_SOURCES} ${CMAKE_BINARY_DIR})

# target for building luajit
add_custom_target(luajit
    COMMAND make -j24
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/ext/LuaJIT)

# target for copying luajit jit dir
add_custom_target(copy-luajit-jit-dir
    COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_SOURCE_DIR}/ext/LuaJIT/src/jit ${CMAKE_BINARY_DIR})

# target for copying luajit
add_custom_target(copy-luajit
    COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/ext/LuaJIT/src/luajit ${CMAKE_BINARY_DIR}
    DEPENDS copy-luajit-jit-dir
    DEPENDS luajit)

# target for copying all build files
add_custom_target(copy-files
    DEPENDS copy-resources
    DEPENDS copy-lua-sources
    DEPENDS copy-luajit)

# add the source files as usual
add_library(Krogre SHARED ${KROGRE_SOURCES})

# krogre needs the files i guess
add_dependencies(Krogre copy-files)

#target_include_directories(Krogre PRIVATE "${CMAKE_SOURCE_DIR}/ext/LuaJIT/src")

# this also sets the includes and pulls third party dependencies
target_link_libraries(Krogre PRIVATE Vulkan glfw3) 