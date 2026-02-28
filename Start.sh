#!/bin/bash

set -e


INSTALL_MARKER=.modpack_installed

./CheckEula.sh



if [ -n "$SERVER_PACK_URL" ] && [ ! -f "$INSTALL_MARKER" ]; then

    curl $SERVER_PACK_URL -o server.zip && \
    unzip -q server.zip && \
    rm server.zip

    echo "$SERVER_PACK_URL" > "$INSTALL_MARKER"

elif [ ! -n "$SERVER_PACK_URL" ]  && [ ! -f "$INSTALL_MARKER" ]; then

    echo "Server not installed already. Please provide server pack URL"
    exit 1

fi

chmod +x start.sh

./start.sh