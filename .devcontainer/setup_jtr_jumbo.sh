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
    curl \
    unzip \
    cmake \
    libnss3-dev \
    libkrb5-dev \
    libmagic-dev \
    libopenmpi-dev \
    openmpi-bin \
    python3 \
    python3-pip

echo "[*] Cloning John the Ripper Jumbo source..."
cd /opt
git clone https://github.com/openwall/john.git jumbo-john
cd jumbo-john/src

echo "[*] Building John the Ripper Jumbo..."
./configure && make -s clean && make -sj$(nproc)

echo "[*] Adding John to PATH..."
ln -sf /opt/jumbo-john/run/john /usr/local/bin/john
