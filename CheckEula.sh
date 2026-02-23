#!/bin/bash
eula_path=$SERVER_PATH/eula.txt
if [ -a "$SERVER_PATH" ] && grep -qi true "$eula_path" 2> /dev/null && echo "$EULA" | grep -qi true; then
	echo "EULA already accepted!"
elif echo "$EULA" | grep -qi true; then
	echo "# EULA accepted on $(date)" >"$eula_path"
	echo "eula=$EULA" >>"$eula_path"
else
	echo ""
	echo "Please accept the Minecraft EULA hosted at"
	echo "  https://account.mojang.com/documents/minecraft_eula"
	echo ""
	>"$eula_path"
	exit 1
fi
