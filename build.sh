#!/bin/bash

set -e
set -x

# Wanting to build a static tmux binary that works on Centos 5

export VERSION=1.9a
export LDFLAGS="-L/usr/lib64:/tmux/lib -static -static-libgcc"
export LIBS="-ltinfo"
export INCLUDES="-I/tmux/include"

# Help configure find libevent info
export PKG_CONFIG_PATH=/tmux/lib/pkgconfig

# Only needed on Ubuntu 10.04 and earler as libncurses still probvides libtinfo at this point in history
ln -s /usr/lib/libncurses.a /usr/lib/libtinfo.a
# We are building on multiarch, 64bit is in another path
ln -s /usr/lib64/libncurses.a /usr/lib64/libtinfo.a

## libevent is only needed on ubuntu 10.04
# curl is needed for github, it's got funky
wget http://sourceforge.net/projects/levent/files/libevent/libevent-2.0/libevent-2.0.21-stable.tar.gz/download
tar xvfz libevent-2.0.21-stable.tar.gz

cd  libevent-2.0.21-stable
./configure --enable-static --prefix=/tmux
make install
cd ..

# Part of me wants a git build
wget -O tmux-$VERSION.tar.gz http://sourceforge.net/projects/tmux/files/tmux/tmux-1.9/tmux-$VERSION.tar.gz/download
tar xzvf tmux-$VERSION.tar.gz
# TMUX 1.9a isn't in the tmux-1.9a folder... manually changing
cd tmux-$VERSION
./configure --enable-static
make
cp tmux ..
