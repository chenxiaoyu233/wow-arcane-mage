#!/bin/bash

echo "fetching file lists"

# platform = win
if [[ $# -ne 0 && $1 = "win" ]]; then 
    filename=$( 
        curl "http://downloads.simulationcraft.org/nightly/?C=M;O=D" \
        | grep -Eo 'href="simc[^"]*win64\.7z"' \
        | head -n 1 \
        | sed 's/href="\(.*\)"/\1/'
    )
# platform = mac
else 
    filename=$( 
        curl "http://downloads.simulationcraft.org/nightly/?C=M;O=D" \
        | grep -Eo 'href="simc[^"]*\.dmg"' \
        | head -n 1 \
        | sed 's/href="\(.*\)"/\1/'
    )
fi

echo "downloading $filename"

curl -z simc "http://downloads.simulationcraft.org/nightly/$filename" --output simc_bin

echo "Extracting files"

function extractDMG {
    # Path to the .dmg file
    dmg_file="./simc_bin"

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
}

if [[ $# -ne 0 ]]; then
    7z e ./simc_bin -oSIMC
else
    extractDMG
fi
