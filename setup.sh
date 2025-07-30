#!/bin/bash


echo "--- Starting Post-Setup ---"

# Step 1: Update package lists from repositories.
echo "--> [1/4] Updating package lists..."
sudo apt-get update

# Step 2: Install required packages: John the Ripper, Python 3, and wget.
echo "--> [2/4] Installing John the Ripper, Python 3, and wget"
sudo apt-get install -y john python3 wget

# Step 3: Make the 'getlist' script executable.
if [ -f "./getlist" ]; then
    echo "--> [3/4] Making './getlist' script executable..."
    chmod +x ./getlist
else
    echo "--> [3/4] WARNING: './getlist' file not found. Skipping chmod."
fi


echo "--- Post-Setup Complete! Lets go!!!!---"

