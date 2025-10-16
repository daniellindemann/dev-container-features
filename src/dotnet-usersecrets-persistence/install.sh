#!/bin/sh
set -e

FEATURE_SCRIPTS_DIR="/usr/local/share/daniellindemann-devcontainer-features/dotnet-usersecrets-persistence/scripts"

echo "Activating feature 'dotnet-usersecrets-persistence'"


# The 'install.sh' entrypoint script is always executed as the root user.
#
# These following environment variables are passed in by the dev container CLI.
# These may be useful in instances where the context of the final
# remoteUser or containerUser is useful.
# For more details, see https://containers.dev/implementors/features#user-env-var
echo "The effective dev container remoteUser is '$_REMOTE_USER'"
echo "The effective dev container remoteUser's home directory is '$_REMOTE_USER_HOME'"

echo "The effective dev container containerUser is '$_CONTAINER_USER'"
echo "The effective dev container containerUser's home directory is '$_CONTAINER_USER_HOME'"

# install scripts
# check if onCreateCommand.sh exists
if [ -f "onCreateCommand.sh" ]; then
    mkdir -p "${FEATURE_SCRIPTS_DIR}"
    cp ./onCreateCommand.sh "${FEATURE_SCRIPTS_DIR}/onCreateCommand.sh"
    chmod +x "${FEATURE_SCRIPTS_DIR}/onCreateCommand.sh"
fi
