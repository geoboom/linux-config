# If you come from bash you might have to change your $PATH.
export PATH=/usr/local/bin/:$HOME/scripts:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git docker docker-compose)
source $ZSH/oh-my-zsh.sh
# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='nvim'
    export EDITOR='nvim'
else
    export EDITOR='nvim'
    export EDITOR='nvim'
fi

alias vvpn='connect-garena-vpn'
alias vim='nvim'
alias vims='nvim -S session.vim'
alias v='nvim'
alias ..='cd ..'
alias rr='ranger'
alias ssource='source ~/.zshrc'
alias sss='source ~/.zshrc'
# alias cs='xclip -selection clipboard' # to simplify copying
alias cs='pbcopy' # to simplify copying
alias cpwd='pwd | cs'
alias cdcp='cd `pbpaste --clipboard`'
alias dora='pcmanfm . &'
alias venv='. venv/bin/activate'
alias datee='date "+%a %d %b"'
alias editz='vim $HOME/.zshrc'
alias editi3='vim $HOME/.skhdrc'
alias editdns='sudo vim /etc/resolv.conf'
alias cptemplate='cp /home/geoboom/Projects/_algorithms/template.cpp solve.cpp'
alias cptemplatee='cp /home/geoboom/Projects/_algorithms/template.cpp solve.cpp && vim -p solve.cpp 1.in'
alias cdwork='cd ~/Projects/_work/sea-2021'
alias cdalgo='cd ~/Projects/_algorithms/'
alias cdcpp='cd /home/geoboom/Dropbox/_projects/cpp'
alias cdnotes='cd /home/geoboom/Dropbox/notes'
alias cdnotes2='cd /home/geoboom/Projects/sharednotes'
alias spe="echo georgie.lee@squarepoint-capital.com | cs"
alias spp="echo ')rAdfS0kz8' | cs"
alias gp3='cd /Users/geoboom/Projects/ccc-2'

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
bindkey \^U backward-kill-line

export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
export PATH=$HOME/homebrew/bin:$PATH

