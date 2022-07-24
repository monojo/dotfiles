#!/usr/bin/env bash

[ -f $HOME/.Xresources ] && rm -f $HOME/.Xresources

ln -s $PWD/Xresources $HOME/.Xresources
