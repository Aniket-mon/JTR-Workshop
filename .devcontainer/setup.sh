#!/bin/bash
set -e

echo "[*] Installing dependencies..."
apt-get update
apt-get install -y \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    yasm \
    pkg-config \
    libgmp-dev \
    libpcap-dev \
    libbz2-dev \
    git \
    cmake

echo "[*] Cloning John the Ripper Jumbo source..."
cd /opt
git clone https://github.com/openwall/john.git jumbo-john
cd jumbo-john/src

echo "[*] Building only john and rar2john..."
./configure && make -s clean
make -sj$(nproc) john rar2john

echo "[*] Linking john and rar2john globally..."
ln -sf /opt/jumbo-john/run/john /usr/local/bin/john
ln -sf /opt/jumbo-john/run/rar2john /usr/local/bin/rar2john

echo "[*] Setup complete. Test using 'john' or 'rar2john' anywhere."
