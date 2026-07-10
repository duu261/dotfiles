# auto re-source zshrc/local env in every open pane when file changes on disk
_autoreload_files=(~/.zshrc ~/.zshrc.local ~/.secrets)
typeset -gA _autoreload_mtimes

_autoreload_check() {
  local f mtime
  for f in $_autoreload_files; do
    [[ -f $f ]] || continue
    mtime=$(zstat +mtime "$f" 2>/dev/null)
    if [[ -n ${_autoreload_mtimes[$f]} && ${_autoreload_mtimes[$f]} != "$mtime" ]]; then
      source "$f"
      echo "reloaded: $f"
    fi
    _autoreload_mtimes[$f]=$mtime
  done
}

zmodload zsh/stat 2>/dev/null
autoload -Uz add-zsh-hook
add-zsh-hook precmd _autoreload_check
