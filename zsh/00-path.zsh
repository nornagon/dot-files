# prepend something to $PATH if it's not there already.
path_prepend() {
  if [[ ! -d "$1" ]]; then return; fi
  if [[ -n "$1" ]] {
    path=($1 $path)
  }
}

path_append() {
  if [[ ! -d "$1" ]]; then return; fi
  if [[ -n "$1" ]] {
    path=($path $1)
  }
}
 
path_prepend "/usr/local/bin"
path_prepend "/usr/local/sbin"
path_prepend "/usr/games"
path_prepend "$HOME/bin"
path_prepend "$HOME/local/bin"
path_prepend "$HOME/work/arcanist/arcanist/bin"
path_prepend "/usr/local/heroku/bin"
path_prepend "/Applications/MacVim.app/Contents/bin"
path_prepend "$HOME/.cargo/bin"
path_prepend "/opt/homebrew/bin"

# brew installed git
path_prepend "/usr/local/share/git-core/contrib/diff-highlight"
path_prepend "/opt/homebrew/share/git-core/contrib/diff-highlight"
# git on ubuntu
path_prepend "/usr/share/doc/git/contrib/diff-highlight"

path_append "$HOME/work/depot_tools"
path_append "$HOME/Source/depot_tools"

export DENO_INSTALL="/Users/nornagon/.deno"
path_prepend "$DENO_INSTALL/bin"

export WASMTIME_HOME="$HOME/.wasmtime"
path_prepend "$WASMTIME_HOME/bin"

export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
