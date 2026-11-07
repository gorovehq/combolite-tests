# combolite-tests

Unified test framework for the **db-combolite** database engine and companion projects.

## Scope

`combolite-tests` contains only the test framework, test orchestration macros, and runner scripts. It holds **no engine test logic** or engine-internal fault mocks, which remain in their respective component repositories (`combolite-core`, `combolite-accelerator`, `combolite-studio`, and `combolite-demo`).

## Components

- **Unity**: vendored as a git submodule in `third-party/unity/`
- **`ComboliteTesting.cmake`**: CMake helper module providing `cdb_add_test()`, `cdb_add_bench()`, and standard test labels:
  - `core`: C99 engine unit tests, sweeps, fault dev/env
  - `accel`: CUDA, Vulkan, and device accelerator tests
  - `studio`: Python unittests for Combolite Studio
  - `demo`: GutenFree Diet demo smoke tests
- **`scripts/run_tests.sh`**: top-level standalone runner

## Standalone Usage

Components outside the parent repository may fetch this framework using CMake `FetchContent`:

```cmake
include(FetchContent)
FetchContent_Declare(
  combolite_tests
  GIT_REPOSITORY https://github.com/gorovehq/combolite-tests.git
  GIT_TAG        main
)
FetchContent_MakeAvailable(combolite_tests)
```
