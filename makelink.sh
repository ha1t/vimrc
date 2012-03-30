#!/bin/sh

basedir=$HOME/src/vimrc
targetdir=$HOME

if [ ! -d $HOME/.vim ]; then
  ln -s $basedir/vim/ $HOME/.vim
fi

if [ ! -f $HOME/.vimrc ]; then
  ln -s $basedir/vimrc $HOME/.vimrc
fi

if [ ! -d $HOME/.vimbackup ]; then
  mkdir $HOME/.vimbackup
fi
