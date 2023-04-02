#!/bin/bash

# Installing BCC (https://github.com/iovisor/bcc) for debian distribution. 
# You can find more info here: https://github.com/iovisor/bcc/blob/master/INSTALL.md

# Run the code below (Dependencies). It is recommended to install from the source due some issues (warnings) you can receive:
VER=trusty
echo "deb http://llvm.org/apt/$VER/ llvm-toolchain-$VER-3.7 main
deb-src http://llvm.org/apt/$VER/ llvm-toolchain-$VER-3.7 main" | \
  sudo tee /etc/apt/sources.list.d/llvm.list

wget -O - http://llvm.org/apt/llvm-snapshot.gpg.key | sudo apt-key add -
sudo apt-get update

# For Jammy (22.04)
sudo apt install -y bison build-essential cmake flex git libedit-dev \
libllvm14 llvm-14-dev libclang-14-dev python3 zlib1g-dev libelf-dev libfl-dev python3-setuptools

# Installing from source (in this case the code is comment because I prefer to install it by myself):

# git clone https://github.com/iovisor/bcc.git
# mkdir bcc/build; cd bcc/build
# cmake ..
# make
# sudo make install
# cmake -DPYTHON_CMD=python3 .. # build python3 binding
# pushd src/python/
# make
# sudo make install
# popd
