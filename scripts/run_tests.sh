#!/usr/bin/env bash
set -euo pipefail

# Runner script for combolite tests
PRESET="${1:-core-both-debug}"

echo "==> Running Combolite tests with preset: ${PRESET}"
ctest --preset "${PRESET}" --output-on-failure
