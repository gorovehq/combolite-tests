# combolite-tests

Unified test framework for the **combolite** database engine and companion submodules.

## Scope

`combolite-tests` contains the test framework, test orchestration macros, and runner scripts. It holds **no engine test logic** or engine-internal fault mocks, which remain in their respective component repositories:
- `combolite-core`
- `combolite-accelerator`
- `combolite-studio`
- `combolite-demo`

## Components

- **Unity**: vendored as a git submodule in `third-party/unity/`
- **`ComboliteTesting.cmake`**: CMake helper module providing `cdb_add_test()`, `cdb_add_test_variant()`, and `cdb_add_bench()`.
- **Submodule Test Labels and Prefixes**:
  - `combolite-core`: C99 engine unit tests, crash/kill sweeps, fault dev/env
  - `combolite-accelerator`: CUDA, Vulkan, and device accelerator tests
  - `combolite-studio`: Python unittests for Combolite Studio
  - `combolite-demo`: GutenFree Diet demo smoke tests
- **`scripts/run_tests.sh`**: top-level runner supporting preset and submodule filtering

## Running Tests

From the parent repository root:

```sh
# Run all tests
ctest --preset core-both-debug -j4

# Run only core engine tests
ctest --preset core-both-debug -L combolite-core

# Run only accelerator tests
ctest --preset core-both-debug -L combolite-accelerator

# Using the runner script
./combolite-tests/scripts/run_tests.sh core-both-debug combolite-core
```

## Standalone Usage

Components built outside the umbrella repository can fetch this framework via CMake `FetchContent`:

```cmake
include(FetchContent)
FetchContent_Declare(
  combolite_tests
  GIT_REPOSITORY https://github.com/gorovehq/combolite-tests.git
  GIT_TAG        main
)
FetchContent_MakeAvailable(combolite_tests)
```
