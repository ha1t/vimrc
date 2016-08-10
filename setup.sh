#!/bin/bash

set -u

# TODO:強制的にresetする仕組みを作る

basedir=$HOME/src/vimrc
targetdir=$HOME

function makelink_dir () {
  if [ ! -d $2 ]; then
    echo "created: $2"
    ln -s $1 $2
  fi
}

if [ ! -d $HOME/bin ]; then
  echo "created: $HOME/bin"
  mkdir $HOME/bin
fi

makelink_dir $basedir/vim $HOME/.vim

if [ ! -d $basedir/vim/vundle ]; then
  git submodule init
  git submodule update
fi

if [ ! -f $HOME/bin/vimparse.php ]; then
  ln $basedir/bin/vimparse.php $HOME/bin/vimparse.php
fi

if [ ! -f $HOME/.vimrc ]; then
  ln -s $basedir/vimrc $HOME/.vimrc
fi

if [ ! -d $HOME/.vimbackup ]; then
  mkdir $HOME/.vimbackup
fi
