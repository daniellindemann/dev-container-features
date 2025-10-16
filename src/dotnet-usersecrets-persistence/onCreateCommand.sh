#!/bin/sh
set -e

echo "Activating feature 'dotnet-usersecrets-persistence'"
# echo "User: $(id -un)"
# echo "User home: $HOME"


echo "Fixing user permissions"
# own the mounted volume
if command -v sudo > /dev/null; then
    sudo chown -R "$(id -u):$(id -g)" /dc/dotnet-usersecrets
else
    chown -R "$(id -u):$(id -g)" /dc/dotnet-usersecrets
fi

echo "Setting up user secrets persistence"
# ensure the .microsoft directory exists
mkdir -p "${HOME}/.microsoft"

# create symbolic link for user secrets storage
ln -s /dc/dotnet-usersecrets "${HOME}/.microsoft/usersecrets"

echo "Feature 'dotnet-usersecrets-persistence' activated"
