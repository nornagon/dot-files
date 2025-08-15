#!/usr/bin/env bash

pkg.install() {
  # ~/.gitconfig sometimes has secrets/other local info in it, so all our
  # aliases/etc. go in a file that gets included.
  git.add_include '~/.gitinclude'

  # Install vim-plug.
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  mkdir -p ~/.local/share/nvim/site/autoload
  cp ~/.vim/autoload/plug.vim ~/.local/share/nvim/site/autoload/plug.vim
}

pkg.init() {
  for module in ./**/*.zsh; do
    source $module
  done
}

pkg.link() {
  fs.link_files .
  fs.link_file ./.nvim 
  mkdir -p $HOME/.config
  fs.link_file ./.nvim $HOME/.config/nvim
}
