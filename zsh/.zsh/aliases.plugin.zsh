alias ls='ls --group-directories-first --color=auto'
alias ll='ls -lh'
alias la='ll -A'
alias lt='ll -tr'
alias lu='lt -u'

alias fpacman="pacman -Slq | fzf -m --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
alias p='sudo pacman'
alias sc='systemctl'

# whitespace at the end causes the next command word after sudo to
# also be checked for alias expansion
alias sudo='sudo '

## lvm
alias lvs='sudo lvs'
alias vgs='sudo vgs'
alias pvs='sudo pvs'
alias lvdisplay='sudo lvdisplay'
alias pvdisplay='sudo pvdisplay'
alias vgdisplay='sudo vgdisplay'



## yay python smtpd
alias smtpd="python -m smtpd -n -c DebuggingServer localhost:1025"


## global aliases
alias -g L='| less'
alias -g N='2> /dev/null'
alias -g G='| rg'
alias -g J='| jless'
alias -g H='| head'
alias -g T='| tail'
alias -g F='| fzf'
alias -g X='| xargs'
alias -g V='| v -'
if [ -n "$SSH_TTY" ] && hash tty-copy 2> /dev/null; then
  alias -g C='| tty-copy -n'
else
  alias -g C='| wl-copy -n'
fi


## misc
alias s='ssh'
alias c="date -R && echo -e && khal calendar --notstarted"
alias :q="exit"
alias eject='sudo eject'
alias rcp='rsync --progress'
alias lsblk='lsblk -o +MODEL -o +LABEL'
alias drop_caches='echo 3 | sudo tee /proc/sys/vm/drop_caches'

# useful defaults
alias rsync="ionice -c 3 rsync"
alias iostat="iostat -mtx"
alias rdesktop="rdesktop -k de -K -z"
alias ip="ip --color"

alias benice="renice -n 19 -p $$ && ionice -c3 -p $$ && ionice -p $$"
alias berude="sudo renice -n -19 -p $$ && sudo ionice -c1 -p $$ && ionice -p $$"

alias tablet="scrcpy --v4l2-sink=/dev/video7 --no-display"
####################


alias tvim="NVIM_APPNAME=testvim nvim"
alias v="nvim"
alias sal="nvim ~/.zsh/aliases.plugin.zsh"
alias so="source ~/.zshrc"
alias xsc="xclip -selection clipboard"
alias rm="rm -i"
alias ls="eza --git --color=always --icons=always --long --no-filesize --no-permissions --no-time --no-user --grid --ignore-glob='tmux*.log'"
alias ls2="ls --tree --level=2"
alias cd="z"
alias ff="fastfetch"

alias spS="sudo pacman -S"
alias spSyu="sudo pacman -Syu"

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

