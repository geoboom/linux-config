# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/geoboom/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="bureau"
# ZSH_THEME="agnoster"
# powerline-daemon -q . /usr/lib/python3.8/site-packages/powerline/bindings/zsh/powerline.zsh

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
  export EDITOR='nvim'
else
  export EDITOR='nvim'
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias vim='nvim'
alias v='nvim'
alias ..='cd ..'
alias rr='ranger'
alias ssource='source ~/.zshrc'
alias sss='source ~/.zshrc'
alias cs='xclip -selection clipboard' # to simplify copying
alias cpwd='pwd | cs'
alias dora='pcmanfm . &'
alias venv='. venv/bin/activate'
alias datee='date "+%a %d %b"'

function tablmap {
    if [ "$1" = "right" ]; then
        echo "tablet mapped to right monitor (HDMI-0)"
        xinput map-to-output 25 HDMI-0
    else
        echo "tablet mapped to main monitor (DP-4)"
        xinput map-to-output 25 DP-4
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

gitcm() {
    git add . && git commit -m "$1" && git push
}

ide() {
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

. /usr/share/fzf/key-bindings.zsh

