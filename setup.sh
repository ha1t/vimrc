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

makelink_dir $basedir/vim $HOME/.vim

if [ ! -f $HOME/.vimrc ]; then
  ln -s $basedir/vimrc $HOME/.vimrc
fi

if [ ! -d $HOME/.vimbackup ]; then
  mkdir $HOME/.vimbackup
fi
