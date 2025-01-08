addToPath() {
    if [[ "$PATH" != *"$1"* ]]; then
        export PATH=$PATH:$1
    fi
}

addToPathFront() {
    if [[ "$PATH" != *"$1"* ]]; then
        export PATH=$1:$PATH
    fi
}

export XDG_CONFIG_HOME=$HOME/.config
VIM="nvim"
export LS_COLORS="$(vivid generate catppuccin-macchiato)"
# PATH=$PATH:/home/$USER/bin
# PATH=$PATH:/home/$USER/.local/bin/
# PATH=$PATH:/home/$USER/.cargo/bin/
# PATH=$PATH:$HOME/.local/share/npm/bin
# PATH=$PATH:$HOME/.luarocks/bin:
# PATH=$PATH:$HOME/.ghcup/bin:
# PATH=$PATH/.
#
addToPathFront $HOME/.local/scripts
addToPathFront $HOME/.local/bin

export JDK8="/usr/lib/jvm/java-8-openjdk/"
export JDK17="$HOME/.m2/jdks/jdk-17.0.10+7/"
export JDK21="$HOME/.m2/jdks/jdk-21.0.2+13/"
export JDK22="$HOME/.m2/jdks/jdk-22.0.2+9/"
export JDK23="$HOME/.m2/jdks/jdk-23+37/"
export JAVA_HOME="$JDK8"
export GRAALVM_HOME="$HOME/.m2/jdks/graalvm-community-openjdk-23+37.1/"
export _JAVA_AWT_WM_NONREPARENTING=1
#
export GIT_EDITOR=$VIM
export EDITOR=$VIM
export VISUAL=$VIM

bindkey -s ^f "tmux-sessionizer\n"
