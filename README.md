# My Config for Linux/WSL2

## Contents

- shell (zsh/bash/fish) aliases and functions
- nvim
- tmux
- i3 config (includes startup scripts)
- Xresources (urxvt) config

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

alias vim='nvim'

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

## i3 config ($\Delta$s)

This section contains the things I changed/added to the default manjaro config for i3.

1. Under `#Start Applications`, I changed `$mod+F2` to open `google-chrome-stable`
   instead of the default `Pale Moon` (yikes). I also changed all the browser instances
   in `.config/mimeapps.list` (associates default apps to filetypes) to google-chrome.desktop.
2. I commented out `bindsym $mod+Shift+h exec xdg-open /usr/share/doc/manjaro/i3_help.pdf` because
   I'm using `$mod+h/j/k/l` for focus switching (instead of `$mod+j/k/l/;`) and `Shift+` the
   corresponding keys for movement. Also I'll just google for the manual if I need it.
3. I uncommented this line `focus_follows_mouse no` because it's annoying to have the cursor
   focus the window I'm on without me clicking on it, which is the default behavior if said line
   remained commented.
4. The following keybinds have been changed from `j/k/l/;` for navigation to vim-keybinds `h/j/k/l`.

```sh
# ...

# change focus
bindsym $mod+h focus left
bindsym $mod+j focus down
bindsym $mod+k focus up
bindsym $mod+l focus right

# ...

# move focused window
bindsym $mod+Shift+h move left
bindsym $mod+Shift+j move down
bindsym $mod+Shift+k move up
bindsym $mod+Shift+l move right

# ...

# Resize window (you can also use the mouse for that)
bindsym $mod+r mode "resize"
mode "resize" {
        # These bindings trigger as soon as you enter the resize mode
        # Pressing left will shrink the window’s width.
        # Pressing right will grow the window’s width.
        # Pressing up will shrink the window’s height.
        # Pressing down will grow the window’s height.
        bindsym h resize shrink width 5 px or 5 ppt
        bindsym j resize grow height 5 px or 5 ppt
        bindsym k resize shrink height 5 px or 5 ppt
        bindsym l resize grow width 5 px or 5 ppt
# ...
```

5. To account for `$mod+h` being used for navigate left, I have changed horizontal split mode
   to `mod+Shift+v`.

```sh
# split orientation
# bindsym $mod+h split h;exec notify-send 'tile horizontally'
bindsym $mod+v split v;exec notify-send 'tile vertically'
bindsym $mod+Shift+v split h;exec notify-send 'tile horizontally'
```

6. I added these lines under the `# Autostart applications` section of the config:

```sh
exec --no-startup-id xset r rate 270 33 # delay, interval
exec --no-startup-id xset -b # remove the stupid bell
```

`xset r rate 270 33` sets the keyboard repeat delay to be 270ms and the repeat rate to be 33
\<of some unit\>.

**Todos:**

- set up keybind to resize window in all directions. Will be useful in floating mode so
  I don't have to resize by some amount in one direction 4 times.
- explore if `$mod+p` is a feasible shortcut (less mental context switching required) for `dmenu`
  (where you search for an app to run) - it's the shortcut I use for vim `ctrlp/fzf` plugin to
  search for a file.
