# My Config for Linux/WSL2

## Contents

- shell (zsh/bash/fish) aliases and functions
- nvim
- tmux

## shell stuff

```sh
gitcm() {
    git add . && git commit -m "$1" && git push
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

export VISUAL=nvim
export EDITOR=nvim

alias ..='cd ..'
```

Change `nvim` in `VISUAL=nvim` or `EDITOR=nvim` to your preferred editor.

## nvim (WIP)

Install fzf and Ag/Rg.
:PlugInstall

## tmux

```sh
# default shell
set-option -g default-shell "/bin/bash"
```

**in tmux.conf:**

- Change default shell `bash` to your preferred shell.
- Change `nvim` in `bind-key M split-window -h "nvim ~/.tmux.conf"` to your preferred editor.
