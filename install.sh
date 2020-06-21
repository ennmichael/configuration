#!/usr/bin/env bash

mkdir -p ~/bin
mkdir -p ~/.config
mkdir -p ~/.vim/

# Install some of the programs
sudo apt-add-repository universe
sudo apt install -y git feh mupdf kitty zsh wget build-essential cmake ninja-build g++ cmake ninja-build libx11-dev libxcursor-dev libxi-dev libgl1-mesa-dev libfontconfig1-dev

# Install neovim
wget https://github.com/neovim/neovim/releases/download/v0.4.3/nvim-linux64.tar.gz
tar -xf nvim-linux64.tar.gz
cp nvim-linux64/bin/nvim ~/bin

# Install neovim/vim configuration and Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cp -r nvim ~/.config/nvim
cp .vimrc ~/.vimrc
cp -r .vim/colors ~/.vim/

# Install oh-my-zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install zsh configuration
cp .zshrc ~/

# Install kitty themes
git clone --depth 1 git@github.com:dexpota/kitty-themes.git ~/.config/kitty/kitty-themes

# Install the kitty configuration
cp kitty.conf ~/.config/kitty/

# Install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install dwm
wget https://dl.suckless.org/dwm/dwm-6.2.tar.gz
tar -xf dwm-6.2.tar.gz
cp dwm-config.h dwm-6.2/config.h
cd dwm-6.2
make
sudo make install

# Install aseprite
ORIGINAL_DIR=$(pwd)
git clone --recursive https://github.com/aseprite/aseprite/
cd aseprite
wget https://github.com/aseprite/skia/releases/download/m81-b607b32047/Skia-Linux-Release-x64.zip
unzip Skia-Linux-Release-x64.zip -d skia
mkdir build
cd build
cmake \
  -DCMAKE_BUILD_TYPE=Release \
  -DLAF_BACKEND=skia \
  -DSKIA_DIR=$ORIGINAL_DIR/aseprite/skia \
  -DSKIA_LIBRARY_DIR=$ORIGINAL_DIR/aseprite/skia/out/Release-x64 \
  -G Ninja \
  ..
cd $ORIGINAL_DIR
cp -r aseprite ~/bin/aseprite.d
cp aseprite.start ~/bin/aseprite
