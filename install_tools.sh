#!/bin/bash

# install true type
sudo apt-get install -y ttf-mscorefonts-installer

# install expect interactive tools
sudo apt-get install -y expect

# install ninja
sudo apt install -y ninja-build

# install dependent package for qemu
sudo apt-get install -y libglib2.0-dev
sudo apt-get install -y libpixman-1-dev
