#!/bin/bash

# This script automates the complete post-creation setup for the JTR Challenge Environment.
# It installs the full "Jumbo" version of John the Ripper from source and configures
# the environment so that all tools are simple to use for beginners.

echo "--- Starting Full JTR Environment Setup ---"

# Step 1: Install build dependencies.
echo "--> [1/7] Installing build dependencies..."
sudo apt-get update
sudo apt-get install -y git build-essential libssl-dev pkg-config python3 wget libbz2-dev

# Step 2: Clone the John the Ripper "bleeding-jumbo" repository.
echo "--> [2/7] Cloning John the Ripper (Jumbo) repository..."
sudo git clone https://github.com/openwall/john -b bleeding-jumbo /opt/john

# Step 3: Compile the John the Ripper source code.
echo "--> [3/7] Compiling John the Ripper... (This may take a few minutes)"
cd /opt/john/src
sudo ./configure
sudo make -s clean && sudo make -sj4
cd - > /dev/null 

# This allows John to create its .log and .pot files without permission errors.
echo "--> [4/7] Fixing directory permissions..."
sudo chown -R $(whoami) /opt/john

# This allows users to type 'john' instead of '/opt/john/run/john'.
echo "--> [5/7] Adding JTR to system PATH..."
echo 'export PATH="/opt/john/run:$PATH"' | sudo tee /etc/profile.d/jtr.sh

# Step 6: Set up user-specific scripts from the workspace.
echo "--> [6/7] Setting up user scripts..."
if [ -f "./getlist" ]; then
    echo "    -> Making './getlist' script executable..."
    chmod +x ./getlist
else
    echo "    -> WARNING: './getlist' file not found. Skipping chmod."
fi



echo "--- Post-Setup Complete! All JTR tools are ready for easy use. ---"
