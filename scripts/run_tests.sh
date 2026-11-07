#!/usr/bin/env bash
set -euo pipefail

# Runner script for combolite tests
# Supports running by preset and optional submodule filter:
#   ./scripts/run_tests.sh [preset] [submodule]
#
# Examples:
#   ./scripts/run_tests.sh core-both-debug
#   ./scripts/run_tests.sh core-both-debug combolite-core
#   ./scripts/run_tests.sh core-both-debug combolite-accelerator

PRESET="${1:-core-both-debug}"
SUBMODULE="${2:-}"

echo "==> Running Combolite tests with preset: ${PRESET}"
if [[ -n "${SUBMODULE}" ]]; then
  echo "==> Filtering for submodule: ${SUBMODULE}"
  ctest --preset "${PRESET}" -L "${SUBMODULE}" --output-on-failure
else
  ctest --preset "${PRESET}" --output-on-failure
fi
