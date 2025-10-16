#!/bin/sh
set -e

# FEATURE_SCRIPTS_DIR="/usr/local/share/daniellindemann-devcontainer-features/dotnet-usersecrets-persistence/scripts"

# if command -v sudo > /dev/null; then
#     sudo chown -R "$(id -u):$(id -g)" "$FEATURE_SCRIPTS_DIR"
# else
#     chown -R "$(id -u):$(id -g)" "$FEATURE_SCRIPTS_DIR"
# fi

echo "In OnCreate script"

echo "Activating feature 'dotnet-usersecrets-persistence'"
echo "User: $(id -un)"
echo "User home: $HOME"

# own the mounted volume
if command -v sudo > /dev/null; then
    sudo chown -R "$(id -u):$(id -g)" /dc/dotnet-usersecrets
else
    chown -R "$(id -u):$(id -g)" /dc/dotnet-usersecrets
fi

# ensure the .microsoft directory exists
mkdir -p "${HOME}/.microsoft"

# create symbolic link for user secrets storage
ln -s /dc/dotnet-usersecrets "${HOME}/.microsoft/usersecrets"
