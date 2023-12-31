cmake_minimum_required(VERSION 3.12)
include(ExternalProject)

# set(CMAKE_COMPILE_WARNING_AS_ERROR OFF) # needed for Ogre3d ext build

project(yuck VERSION 1.0)

find_package(Vulkan REQUIRED)
find_package(glfw3 REQUIRED)

file(GLOB yuck_SOURCES "${CMAKE_SOURCE_DIR}/src/*.cpp" "${CMAKE_SOURCE_DIR}/src/*.c")
file(GLOB LUA_SOURCES "${CMAKE_SOURCE_DIR}/src/*.lua")
file(GLOB yuck_RESOURCES "${CMAKE_SOURCE_DIR}/resources")

file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/scripts)
file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/jit)

# target for copying yuck resource files
add_custom_target(copy-resources
    COMMAND ${CMAKE_COMMAND} -E copy_directory ${yuck_RESOURCES} ${CMAKE_BINARY_DIR})

# target for copying yuck lua files
add_custom_target(copy-lua-sources
    COMMAND ${CMAKE_COMMAND} -E copy ${LUA_SOURCES} ${CMAKE_BINARY_DIR}/scripts)

# target for building luajit
add_custom_target(luajit
    COMMAND make -j24
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/ext/LuaJIT)

# target for copying luajit jit dir
add_custom_target(copy-luajit-jit-dir
    COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_SOURCE_DIR}/ext/LuaJIT/src/jit ${CMAKE_BINARY_DIR}/jit)

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
add_library(yuck SHARED ${yuck_SOURCES})

# yuck needs the files i guess
add_dependencies(yuck copy-files)

#target_include_directories(yuck PRIVATE "${CMAKE_SOURCE_DIR}/ext/LuaJIT/src")

# this also sets the includes and pulls third party dependencies
target_link_libraries(yuck PRIVATE vulkan glfw) 