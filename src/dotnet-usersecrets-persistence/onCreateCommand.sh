#!/bin/sh
set -e

FEATURE_SCRIPTS_DIR="/usr/local/share/daniellindemann-devcontainer-features/dotnet-usersecrets-persistence/scripts"
LOG_FILE="$FEATURE_SCRIPTS_DIR/log-$(date +%Y%m%d).txt"

if command -v sudo > /dev/null; then
    sudo chown -R "$(id -u):$(id -g)" "$FEATURE_SCRIPTS_DIR"
else
    chown -R "$(id -u):$(id -g)" "$FEATURE_SCRIPTS_DIR"
fi

log() {
    echo "$1"
    echo "$1" >> "$LOG_FILE"
}

fix_permissions() {
    local dir="${1}"

    # Create directory if it doesn't exist
    if [ ! -d "${dir}" ]; then
        log "Creating directory '${dir}'..."
        mkdir -p "${dir}" 2>/dev/null || {
            if command -v sudo >/dev/null 2>&1; then
                sudo mkdir -p "${dir}"
            else
                log "ERROR: Cannot create directory '${dir}' and sudo not available"
                return 1
            fi
        }
    fi

    # Check if we already own the directory and have write access
    if [ -O "${dir}" ] && [ -w "${dir}" ]; then
        log "Permissions of '${dir}' are OK!"
        return 0
    fi

    log "Fixing permissions of '${dir}'..."

    # Try without sudo first
    if chown "$(id -u):$(id -g)" "${dir}" 2>/dev/null && chmod 755 "${dir}" 2>/dev/null; then
        log "Fixed permissions successfully"
    elif command -v sudo >/dev/null 2>&1; then
        # Fall back to sudo
        sudo chown "$(id -u):$(id -g)" "${dir}" && sudo chmod 755 "${dir}"
        log "Fixed permissions with sudo"
    else
        log "ERROR: Cannot fix permissions and sudo not available"
        return 1
    fi

    # Verify the fix worked
    if [ -w "${dir}" ]; then
        log "Permission fix verified"
        return 0
    else
        log "ERROR: Permission fix failed"
        return 1
    fi
}

log "In OnCreate script"

log "Activating feature 'dotnet-usersecrets-persistence'"
log "User: $(id -un)"
log "User home: $HOME"

fix_permissions "${HOME}/.microsoft/usersecrets"
