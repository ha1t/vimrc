#!/bin/bash

set -u

basedir=$HOME/src/vimrc
targetdir=$HOME

function makelink_dir () {
  if [ ! -d $2 ]; then
    echo "created: $2"
    ln -s $1 $2
  fi
}

if [ ! -d $HOME/.config ]; then
  echo "created: .config"
  mkdir $HOME/.config
fi

makelink_dir $basedir/nvim $HOME/.config/nvim

