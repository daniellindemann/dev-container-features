#!/bin/bash

# This test file will be executed against one of the scenarios devcontainer.json test that
# includes the 'color' feature with "greeting": "hello" option.

set -e

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# prep test
dotnet new console --name dotnet-console
pushd ./dotnet-console
dotnet user-secrets init
dotnet user-secrets set "testkey" "testvalue"
popd

# Feature-specific tests
# The 'check' command comes from the dev-container-features-test-lib.
check "test secret file creation" bash -c "find $HOME/.microsoft/usersecrets -mindepth 1 -maxdepth 1 -type d | grep -E '[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}'"

# Report results
# If any of the checks above exited with a non-zero exit code, the test will fail.
reportResults
