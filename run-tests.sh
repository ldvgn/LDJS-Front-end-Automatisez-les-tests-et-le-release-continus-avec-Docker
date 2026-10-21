#!/usr/bin/env bash
# Runs Jest unit tests and writes a JUnit report to test-results/junit.xml.
# Usage: bash run-tests.sh (from project root). Exit code: 0 = success, other = failure.

# Check that dependencies are installed
if [ ! -d node_modules ]; then
  echo "Error: node_modules missing. Run 'npm ci' first"
  exit 1
fi

# Remove previous reports
rm -rf test-results/

# "--" forwards the options to jest instead of npm
JEST_JUNIT_OUTPUT_DIR=test-results npm test -- --ci --reporters=default --reporters=jest-junit

# Save exit code immediately: $? is overwritten by the next command
RESULTAT=$?

if [ "$RESULTAT" -eq 0 ]; then
  echo "All tests passed."
else
  echo "At least one test failed."
fi

# Forward jest's exit code so the CI knows if it failed
exit $RESULTAT