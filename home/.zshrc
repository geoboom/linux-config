# If you come from bash you might have to change your $PATH.
export PATH=$HOME/scripts:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/geoboom/.oh-my-zsh"
ZSH_THEME="bureau"
plugins=(git)
source $ZSH/oh-my-zsh.sh
# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='nvim'
    export EDITOR='nvim'
else
    export EDITOR='nvim'
    export EDITOR='nvim'
fi

alias python='python2.7'
alias python2='python2.7'
alias vvpn='connect-labs-vpn.sh'
alias vim='nvim'
alias vims='nvim -S session.vim'
alias v='nvim'
alias ..='cd ..'
alias rr='ranger'
alias ssource='source ~/.zshrc'
alias sss='source ~/.zshrc'
alias cs='xclip -selection clipboard' # to simplify copying
alias cpwd='pwd | cs'
alias cdcp='cd `xsel --clipboard`'
alias dora='pcmanfm . &'
alias venv='. venv/bin/activate'
alias datee='date "+%a %d %b"'
alias editi3='vim ~/.config/i3/config'
alias editdns='sudo vim /etc/resolv.conf'
alias cptemplate='cp ../template.cpp solve.cpp'
alias cptemplatee='cp ../template.cpp solve.cpp && vim -p solve.cpp 1.in'
alias batinfo="upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E 'state|energy|percentage|time to empty'"
alias cdwork='cd ~/WorkStuff/'

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


ide_full() {
    tmux rename-window "fe-dev"
    cd ~/Projects
    tmux new-window
    tmux rename-window "fe-etc"
    tmux new-window
    tmux rename-window "server"
    tmux new-window
    tmux rename-window "be-dev"
    tmux new-window
    tmux rename-window "be-etc"
    tmux next-window
}

ide_lite() {
    tmux rename-window "frontend"
    cd ~/Projects
    tmux new-window
    tmux rename-window "server"
    tmux new-window
    tmux rename-window "backend"
}

ide_dev() {
    tmux rename-window "dev-1"
    tmux new-window
    tmux rename-window "dev-2"
    tmux new-window
    tmux rename-window "dev-3"
}

ide1() {
    tmux split-window -h -p 50
    tmux split-window -v
}

ide2() {
    tmux split-window -v -p 30
    tmux split-window -h -p 66
    tmux split-window -h -p 50
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
