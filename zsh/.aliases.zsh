alias sal="nvim ~/.aliases.zsh"
alias soz="source ~/.zshrc"
alias xsc="xclip -selection clipboard"
alias rm="rm -i"
alias ls="eza --git --color=always --icons=always --long --no-filesize --no-permissions --no-time --no-user --grid --ignore-glob='tmux*.log'"
alias ls2="ls --tree --level=2"
alias cd="z"

alias spS="sudo pacman -S"
alias spSyu="sudo pacman -Syu"

alias cl="clear"
alias my_ip="ip address | grep -o \"inet 192.*/\" | awk '{ print \$2 }' | tr / ' ' | xargs"


alias vim="$VIM"
alias vims="NVIM_LISTEN_ADDRESS=/tmp/nvim $VIM"

##!/usr/bin/env bash
#alias asdf="setxkbmap real-prog-dvorak"
#alias aoeu="setxkbmap us"
#alias lkj="setxkbmap real-prog-dvorak"
#alias snth="setxkbmap us"

#
##!/usr/bin/env bash
#alias esc="$HOME/.config/sway/config"
#alias kill_netflix="pkill -9 GIBBON_MAIN"
#alias work="cd ~/work"
#
#alias python="python3"
#alias cbp="cat $DOTFILES/zsh/.config/.zsh_profile"
#alias ebp="$VIM $DOTFILES/.zsh_profile"
#alias etc="$VIM $DOTFILES/awesome-streamerrc/ThePrimeagen/.tmux.conf"
#alias bp="dotFileInstall && source ~/.zshrc"
#alias evrc="$VIM $DOTFILES/awesome-streamerrc/ThePrimeagen/.vimrc"
#alias enrc="nvim $DOTFILES/awesome-streamerrc/ThePrimeagen/init.vim --cmd \"cd $DOTFILES/awesome-streamerrc/ThePrimeagen/init.vim\""
#alias yolo="git push origin master --force --no-verify"
#alias eirc="nvim $XDG_CONFIG_HOME/i3/i3config"
#alias cvrc="cat $DOTFILES/vimrc/.vimrc"
#alias dotFileInstall="$DOTFILES/install"
#
#alias pjson="python -mjson.tool"
#alias killBT="rfkill block bluetooth"
#alias unKillBT="rfkill unblock bluetooth"
#alias cclip="xclip -selection clipboard"
#alias pclip="xclip -selection clipboard"
#alias timeplus="~/dotfiles/apps/time_plus_30"
#alias echotime="~/dotfiles/apps/echo_time"
#alias livestream_screenkey="screenkey -s large --scr 2 -p bottom --geometry 1210x300+712+810";
#alias yt_screenkey="screenkey -s large --scr 1 -p bottom --geometry 510x300+1412+850";
