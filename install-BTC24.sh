#!/bin/bash

# Discover the processor architecture and operating system
os=""
arch=""
if [ "$(uname)" == "Darwin" ]; then
    os="apple-darwin"
    arch=$(sysctl -n hw.optional.arm64)
    if [ $arch == 1 ]; then
        arch="arm64"
    else
        arch="x86_64"
    fi
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    os="linux-gnu"
    arch=$(uname -m)
    if [ "$arch" == "x86_64" ]; then
        arch="x86_64"
    elif [ "$arch" == "aarch64" ]; then
        arch="aarch64"
    else
        arch="unknown"
    fi
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ] || [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
    os="win"
    arch="win64"
else
    echo "Unsupported operating system."
    echo "install a better one, preferably a linux."
    exit 1
fi

# Choose the appropriate file to download
file="bitcoin-24.0.1-${arch}-${os}"
url="https://bitcoincore.org/bin/bitcoin-core-24.0.1/${file}"

# Add the appropriate file extension
if [ "$os" == "apple-darwin" ]; then
    url="${url}.dmg"
elif [ "$os" == "linux-gnu" ]; then
    url="${url}.tar.gz"
elif [ "$os" == "win" ]; then
    if [ "$arch" == "win64" ]; then
        url="${url}.zip"
    else
        url="${url}-setup.exe"
    fi
else
    echo "Unsupported architecture and operating system combination."
    echo "install a better one, preferably a linux."
    exit 1
fi

# Download the correct file
echo "Downloading: $url"
wget "$url"

# If on Linux, extract the .tar.gz file
if [ "$os" == "linux-gnu" ]; then
    echo "Extracting file: ${file}.tar.gz"
    tar -xzf "${file}.tar.gz"
fi

# Download the SHA256SUMS and SHA256SUMS.asc files
wget https://bitcoincore.org/bin/bitcoin-core-24.0.1/SHA256SUMS
wget https://bitcoincore.org/bin/bitcoin-core-24.0.1/SHA256SUMS.asc

# Import the Bitcoin Core public key, if necessary
gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys 01EA5486DE18A882D4C2684590C8019E36C2E964

# Verify the signature of the SHA256SUMS file
gpg --verify SHA256SUMS.asc SHA256SUMS

# Verify the downloaded file's hash value
shasum -c --ignore-missing SHA256SUMS 2>&1 | grep "${file}"

# Add the extracted Bitcoin Core binary directory to the PATH
export PATH=$PATH:$(pwd)/bitcoin-24.0.1/bin

# Start the Bitcoin Core daemon (bitcoind) in the background
bitcoind -daemon

# Retrieve and display blockchain information using the bitcoin-cli command
bitcoin-cli getblockchaininfo
# Wait for 5 seconds to allow the Bitcoin Core daemon to start up before running the bitcoin-cli command
sleep 5
# Retrieve and display blockchain information using the bitcoin-cli command
bitcoin-cli getblockchaininfo
# Wait for 5 seconds to allow the Bitcoin Core daemon to start up before running the bitcoin-cli command
sleep 5
# Retrieve and display blockchain information using the bitcoin-cli command
bitcoin-cli getblockchaininfo
# Wait for 5 seconds to allow the Bitcoin Core daemon to start up before running the bitcoin-cli command
sleep 5
# Retrieve and display blockchain information using the bitcoin-cli command
bitcoin-cli getblockchaininfo

# Instale as dependências
sudo apt-get install -y \
  autoconf automake build-essential git libtool libgmp-dev \
  libsqlite3-dev python3 python3-mako net-tools zlib1g-dev libsodium-dev \
  gettext

# Clone o repositório c-lightning
cd ~
git clone https://github.com/ElementsProject/lightning.git
cd lightning

# Compile e instale o c-lightning
./configure
make
sudo make install
