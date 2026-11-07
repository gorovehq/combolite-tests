# Combolite Testing Framework
# Unified test definitions, labels, and CTest integration

# Test labels:
#   core   - Core C99 engine unit tests, sweeps, and fault devices
#   accel  - CUDA, Vulkan, and device acceleration tests
#   studio - Combolite Studio Python unittests
#   demo   - GutenFree Diet demo smoke tests

function(cdb_add_test name)
  cmake_parse_arguments(PARSE_ARGV 1 ARG "" "LABEL" "SOURCES;LIBS;DEFINITIONS;PROPERTIES")
  if(NOT ARG_SOURCES)
    set(ARG_SOURCES ${name}.c)
  endif()
  if(NOT ARG_LABEL)
    set(ARG_LABEL "core")
  endif()

  add_executable(${name} ${ARG_SOURCES})
  target_link_libraries(${name} PRIVATE ${ARG_LIBS} unity)
  target_compile_definitions(${name} PRIVATE CDB_TEST_TMPDIR="${CMAKE_CURRENT_BINARY_DIR}" ${ARG_DEFINITIONS})
  if(CDB_WARNINGS)
    target_compile_options(${name} PRIVATE ${CDB_WARNINGS})
  endif()

  add_test(NAME ${name} COMMAND ${name})
  set_tests_properties(${name} PROPERTIES LABELS "${ARG_LABEL}" ${ARG_PROPERTIES})
endfunction()

function(cdb_add_bench name)
  cmake_parse_arguments(PARSE_ARGV 1 ARG "" "" "SOURCES;LIBS")
  if(NOT ARG_SOURCES)
    set(ARG_SOURCES ${name}.c)
  endif()

  add_executable(${name} ${ARG_SOURCES})
  target_link_libraries(${name} PRIVATE ${ARG_LIBS})
  if(CDB_WARNINGS)
    target_compile_options(${name} PRIVATE ${CDB_WARNINGS})
  endif()
endfunction()
