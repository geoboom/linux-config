# If you come from bash you might have to change your $PATH.
export PATH=$HOME/scripts:$HOME/.local/bin:$PATH
export PATH=$PATH:/usr/local/go/bin

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git docker docker-compose)
source $ZSH/oh-my-zsh.sh

export EDITOR='nvim'

if command -v exa > /dev/null; then
    alias ls="exa"
    alias l="exa -al"
    alias ll="exa -l"
else
    alias ls="ls"
    alias l="ls -alh"
    alias ll="ls -lh"
fi

alias vvpn='connect-garena-vpn'
alias vim='nvim'
alias vims='nvim -S session.vim'
alias v='nvim'
alias ..='cd ..'
alias rr='ranger'

alias ssource='source ~/.zshrc'
alias sss='source ~/.zshrc'

alias cs='xclip -selection clipboard' # to simplify copying
alias cpwd='pwd | cs'
alias cdcp='cd "$(xsel --clipboard)"'
alias dora='pcmanfm . &'
alias venv='. venv/bin/activate'

alias datee='date "+%a %d %b"'

alias editi3='vim ~/.config/i3/config'
alias editdns='sudo vim /etc/resolv.conf'

alias cptemplate="cp $HOME/Projects/_algorithms/template.cpp solve.cpp"
alias cptemplatee="cp $HOME/Projects/_algorithms/template.cpp solve.cpp && vim -p solve.cpp 1.in"

# alias cmake_db="rm -f ./compile_commands.json && cmake -H. -BDebug -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=YES && ln -s Debug/compile_commands.json ."
# "cmake -H. -BDebug -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=YES \
alias cmake_db="( \
    echo 'Running cmake_db' \
    && cmake -H. -BDebug -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=YES \
    && [ ! -e ./compile_commands.json ] \
    && (echo 'Compilation DB link does not exist, proceeding to link' \
    && ln -s Debug/compile_commands.json .) \
    || echo 'Compilation DB link already exists, not going to link' \
    )"

alias vnotes="vim $HOME/Dropbox/notes/"
alias vnotescpp="vim $HOME/Dropbox/notes/cpp1.md"
alias vnoteslc="vim $HOME/Dropbox/notes/lc2.md"
alias ez="vim $HOME/.zshrc"
alias editz="vim $HOME/.zshrc"

# jumps
# alias gwork="cd $HOME/Projects/_work/sea-2021"
# alias galgo="cd $HOME/Dropbox/_algorithms/"
# alias gcpp="cd $HOME/Dropbox/_projects/cpp"
alias gnotes="cd $HOME/Dropbox/notes"
alias gnotes2="cd $HOME/Projects/sharednotes"
alias gdropboxcfg="cd $HOME/Dropbox/config_sync"
alias gs="cd $HOME/school"
alias gp="cd $HOME/Projects; ll"
alias gpr1="cd $HOME/Projects/rust-learning; ll"
alias gpc1="cd $HOME/Projects/cpp-learning; ll"
alias gm1="cd $HOME/school/als1010"
alias gm2="cd $HOME/school/cs3211"
alias gm2a3="cd $HOME/school/cs3211/Assignments/a3"
alias gm3="cd $HOME/school/cs2105"

# export DROPBOX_CONFIG_DIR="$HOME/Dropbox/_config_sync"
# function cpcfg {
#     mkdir -p $DROPBOX_CONFIG_DIR
#     cp -r $HOME/.config/rofi $DROPBOX_CONFIG_DIR/
#     cp -r $HOME/.config/nvim $DROPBOX_CONFIG_DIR/
#     cp $HOME/.config/i3/config $DROPBOX_CONFIG_DIR/i3config
#     cp $HOME/.zshrc $DROPBOX_CONFIG_DIR/

#     inputrc_contents='$include /etc/inputrc\n'
#     inputrc_contents+='"\C-p":history-search-backward\n'
#     inputrc_contents+='"\C-n":history-search-forward\n'
#     inputrc_contents+='set colored-stats On\n'
#     inputrc_contents+='set completion-ignore-case On\n'
#     inputrc_contents+='set completion-prefix-display-length 3\n'
#     inputrc_contents+='set mark-symlinked-directories On\n'
#     inputrc_contents+='set show-all-if-ambiguous On\n'
#     inputrc_contents+='set show-all-if-unmodified On\n'
#     inputrc_contents+='set visible-stats On\n'
#     inputrc_contents+='bind TAB:menu-complete'
#     echo $inputrc_contents > $DROPBOX_CONFIG_DIR/.inputrc
# }

function set_g502_sens {
    g502_id=`xinput --list | grep '.*G502.*pointer.*' | sed 's/.*G502.*id=\([[:digit:]]\+\).*pointer.*/\1/'`
    xinput --set-prop $g502_id 'libinput Accel Profile Enabled' 0, 1
}

function today {
    date_str="./$(date +%Y-%m-%d)"
    if [ ! -d "$date_str" ]; then
        echo "Created $date_str."
        mkdir "$date_str"
    fi
    cd "$date_str"
}

function tablmap {
    tablgrep='HUION .* Pen Pen'
    tablid=`xinput --list | grep -i $tablgrep | sed -n -e 's/^.*id=\(\w\+\).*$/\1/p'`
    if [ "$1" = "right" ]; then
        echo "tablet ($tablid) mapped to right monitor (HDMI-0)"
        xinput map-to-output $tablid HDMI-0
    else
        echo "tablet ($tablid) mapped to main monitor (DP-4)"
        xinput map-to-output $tablid DP-4
    fi
}

# from https://github.com/ecnerwala/dotfiles/blob/master/zsh/.zshrc
function mkcd {
    if [ ! -n "$1" ]; then
        echo "Enter a directory name"
    elif [ -d $1 ]; then
        echo "\`$1' already exists"
        cd $1
    else
        md $1 && cd $1
    fi
}

function comp {
    g++ -Wall -DLOCAL_DEFINE $1.cpp -o $1 && ./$1
}


gitcm() {
    git add . && git commit -m "$1" && git push
}

cpss() {
    if [ ! -n "$1" ]; then
        cp `ls -drt /tmp/* | grep screenshot | tail -n 1` .
    else
        cp `ls -drt /tmp/* | grep screenshot | tail -n 1` $1
    fi
}

PROJECT_DIR="/home/geoboom/Projects/_work/sea-2021"

ide_work_win() {
    cd $PROJECT_DIR/sams/client
    tmux new-window
    cd $PROJECT_DIR/itsupport_ticket/server
    tmux new-window
    cd $PROJECT_DIR/itsupport_ticket/client
    tmux new-window
    cd $PROJECT_DIR/sams/server
}

ide_work_split() {
    cd $PROJECT_DIR/itsupport_ticket
    tmux split-window
    cd $PROJECT_DIR/sams/client
    tmux split-window
    cd $PROJECT_DIR/itsupport_ticket/client
    tmux split-window
    cd $PROJECT_DIR/sams
}

export FZF_DEFAULT_COMMAND='rg --files --hidden'

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/geoboom/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/geoboom/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/geoboom/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/geoboom/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f "/home/geoboom/.ghcup/env" ] && source "/home/geoboom/.ghcup/env" # ghcup-env
[ -f ~/.extra_shit.zsh ] && source ~/.extra_shit.zsh
bindkey \^U backward-kill-line

LFCD="$GOPATH/src/github.com/gokcehan/lf/etc/lfcd.sh"  # source
LFCD="/home/geoboom/.config/lf/lfcd.sh"                # pre-built binary, make sure to use absolute path
if [ -f "$LFCD" ]; then
    source "$LFCD"
fi

