cmake_minimum_required(VERSION 3.18)
project(HelloWorld VERSION "0.1")
set(CMAKE_CXX_STANDARD 20)
Include(FetchContent)

FetchContent_Declare(
  Catch2
  GIT_REPOSITORY https://github.com/catchorg/Catch2.git
  GIT_TAG v3.2.0
)

FetchContent_MakeAvailable(Catch2)
include(CTest)
include(Catch)

add_subdirectory(temperature)

add_executable(HelloWorld)
target_sources(HelloWorld PRIVATE main.cpp)

install(TARGETS HelloWorld)
