cmake_minimum_required(VERSION 3.16)
project(combolite_tests LANGUAGES C)

# Unity testing framework (submodule)
if(NOT TARGET unity)
  if(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/third-party/unity/src/unity.c)
    add_library(unity STATIC ${CMAKE_CURRENT_SOURCE_DIR}/third-party/unity/src/unity.c)
    target_include_directories(unity PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/third-party/unity/src)
    target_compile_definitions(unity PUBLIC UNITY_INCLUDE_DOUBLE UNITY_SUPPORT_64)
    if(CDB_SANITIZE)
      target_compile_options(unity PRIVATE ${CDB_SANITIZER_FLAGS})
    endif()
  else()
    message(WARNING "Unity submodule is not initialized; run: git submodule update --init --recursive")
  endif()
endif()

add_library(combolite_testing_framework INTERFACE)
target_include_directories(combolite_testing_framework INTERFACE
  ${CMAKE_CURRENT_SOURCE_DIR}/cmake
  ${CMAKE_CURRENT_SOURCE_DIR}/third-party/unity/src)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
include(ComboliteTesting)
