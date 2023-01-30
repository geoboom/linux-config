# autostart X at login
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
    exec startx
fi

# to avoid annoying popup and autorestart services
export DEBIAN_FRONTEND=noninteractive
export NEEDRESTART_MODE=a

# add some paths
export PATH=$HOME/scripts:$PATH
export PATH=$HOME/.local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh

export EDITOR="$HOME/.local/bin/nvim"
alias l="ls -alh"
alias ll="ls -lh"
alias vim=$EDITOR
alias rr="ranger"
alias sss="source $HOME/.zshrc"
alias cs="xclip -selection clipboard"
alias cpwd="pwd | cs"
alias cdcp="cd '$(xsel --clipboard)'"
# alias dora="$FILE_EXPLORER . &"
alias datee="date '+%a %d %b'"
alias editi3="$EDITOR $HOME/.config/i3/config"
alias editz="$EDITOR $HOME/.zshrc"
alias editdns="sudo -E -s $EDITOR /etc/resolv.conf"

# jumps
alias j_s="cd $HOME/school"
alias j_p="cd $HOME/projects"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.extra_shit.zsh ] && source ~/.extra_shit.zsh

source $HOME/scripts/startup.sh

