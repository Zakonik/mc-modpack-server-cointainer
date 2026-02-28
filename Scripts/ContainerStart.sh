#!/bin/bash

set -euo pipefail

INSTALL_MARKER=.modpack_installed
START_SCRIPT=start.sh
./CheckEula.sh

if [ -n "$SERVER_PACK_URL" ] && [ ! -f "$INSTALL_MARKER" ]; then

    curl --fail "$SERVER_PACK_URL" -o server.zip &&
        unzip -q server.zip &&
        rm server.zip

    echo "$SERVER_PACK_URL" >"$INSTALL_MARKER"

elif [ -z "$SERVER_PACK_URL" ] && [ ! -f "$INSTALL_MARKER" ]; then

    echo "Server not installed already. Please provide server pack URL"
    exit 1

fi

if [ ! -f "$START_SCRIPT" ]; then
    echo "ERROR: Start script '$START_SCRIPT' not found in server pack."
    exit 1
fi
chmod +x "$START_SCRIPT"
exec "./$START_SCRIPT"
