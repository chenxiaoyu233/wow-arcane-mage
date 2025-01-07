#!/bin/bash

echo "Read the file list from remote"

filename=$( 
    curl "http://downloads.simulationcraft.org/nightly/?C=M;O=D" \
    | grep -Eo 'href="simc[^"]*\.dmg"' \
    | head -n 1 \
    | sed 's/href="\(.*\)"/\1/'
)

echo "Update SIMC if needed"

curl -z simc.dmg "http://downloads.simulationcraft.org/nightly/$filename" --output simc.dmg

echo "Extracting files"

# Path to the .dmg file
dmg_file="./simc.dmg"

# Mount the DMG file
hdiutil attach "$dmg_file"

# Wait a moment to ensure it's mounted
sleep 2

# Get the name of the mounted volume (assuming it's the first one)
mounted_volume=$(ls /Volumes | grep "Simulationcraft")

# Copy the contents to the destination folder
destination_folder="./SIMC"
#cp -R "/Volumes/$mounted_volume/" "$destination_folder"
rsync -r --progress "/Volumes/$volume_name/" "$destination_folder"

# Unmount the DMG file
hdiutil detach "/Volumes/$mounted_volume"

echo "DMG file extracted to $destination_folder"
