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

if [ ! -d $HOME/.config ]; then
  echo "created: .config"
  mkdir $HOME/.config
fi

if [ ! -d $HOME/.vim/backup ]; then
  echo "created: .vim/backup"
  mkdir $HOME/.vim/backup
fi

makelink_dir $basedir/vim $HOME/.vim
makelink_dir $basedir/vim $HOME/.config/nvim

if [ ! -f $HOME/.vimrc ]; then
  ln -s $basedir/vimrc $HOME/.vimrc
fi

if [ ! -f $HOME/.config/nvim/init.vim ]; then
  ln -s $basedir/vimrc $HOME/.config/nvim/init.vim
fi

