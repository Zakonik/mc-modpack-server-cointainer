#!/bin/bash
eula_path=eula.txt
if [ -e "$eula_path" ] && grep -qi true "$eula_path" 2> /dev/null; then
	echo "EULA already accepted!"
elif echo "$EULA" | grep -qi true; then
	echo "# EULA accepted on $(date)" >"$eula_path"
	echo "eula=$EULA" >>"$eula_path"
else
	echo ""
	echo "Please accept the Minecraft EULA hosted at"
	echo "  https://account.mojang.com/documents/minecraft_eula"
	echo ""
	exit 1
fi
