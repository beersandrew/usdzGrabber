#!/bin/bash

# Check if the user provided a name
if [ -z "$1" ]; then
    echo "Usage: ./script.sh <TargetFolderName>"
    exit 1
fi

# Use the provided name to set the target folder
TARGET_FOLDER=/Users/andrewbeers/Desktop/Projects/"$1"
WATCH_FOLDER=~/Downloads

# Create the target and previous folders if they don't exist
mkdir -p "$TARGET_FOLDER"

fswatch -0 "$WATCH_FOLDER" | while read -d "" event
do
    if [[ "$event" == *.usdz ]]; then
        FILENAME=$(basename "$event")
        echo "Detected USDZ file: $FILENAME"

        # Move current contents of the target folder to the "previous" folder
        rm -rf "$TARGET_FOLDER/*"

        # Move the new file to the target folder
        mv "$event" "$TARGET_FOLDER/test.usdz"

        # Unzip the file directly in the target folder
        cd "$TARGET_FOLDER"
        unzip -o "test.usdz"
        echo "Unzipped test.usdz"
    fi
done