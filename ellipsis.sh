#!/usr/bin/env bash

pkg.install() {
  # ~/.gitconfig sometimes has secrets/other local info in it, so all our
  # aliases/etc. go in a file that gets included.
  git.add_include '~/.gitinclude'

  # Install vim-plug.
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

pkg.init() {
  for module in ./**/*.zsh; do
    source $module
  done
}
