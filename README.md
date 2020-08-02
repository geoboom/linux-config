# My Config for Linux/WSL2

**Contents:**

- manjaro installation walkthrough
- shell (zsh/bash/fish) aliases and functions
- nvim
- tmux
- i3 config (includes startup scripts)
- Xresources (urxvt) config
- suspend on lid clsoe (systemd-logind)

## manjaro installation walkthrough (i3wm)

1. `xset r rate 270 33` my preferred repeat rate and delay
2. `xset -b` to remove the bell
3. clone this repo
4. update pacman and repos `pacman-mirrors --geoip && pacman -Syyu`
5. open `pamac-manager` gui and ensure enable AUR support is yes
6. install google-chrome with yay from AUR `yay google-chrome` (check AUR first for the correct package name in case it changes)
7. remove pale moon and update default browser for all applications (in `~/.profile`, `.config/mimeapps.list` do this before `:PlugInstall` in nvim!!!)
8. install zsh
9. configure multiple monitor layout with xrandr
10. sound:
    1. install pavucontrol and pulseaudio. Not sure if need pulseaudio if I have pavucontrol/any alternatives to pavucontrol...
    2. default soundcard issue `/etc/modprobe.d/alsa-base.conf` (see arch wiki)
11. disable mouse acceleration
12. configure datetime properly. Not sure why after boot into manjaro timezone fucks up: manjaro-settings-manager -> time and date -> set time and date automatically
13. flameshot for screenshot: `pacman -S flameshot`
14. disable mouse acceleration (`xinput --list`, `xinput --list-props <device-id>`, `xinput --set-prop <device-id> 'libinput Accel Speed' -0.7`) and permanently commit: xorg config file in `/etc/X11/xorg.conf.d/`...
15. if window is nested/stuck, just move it to the left/right until it gets unnested!
16. change cursor to inverted color and make it bigger

## shell stuff

**todo:** upload zsh config

```sh
# change all instances of VISUAL and EDITOR to nvim
export VISUAL=nvim
export EDITOR=nvim
```

```sh
# helpful functions
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

# helpful aliases
alias vim='nvim'
alias ..='cd ..'
alias rr='ranger'
```

Change `nvim` in `VISUAL=nvim` or `EDITOR=nvim` to your preferred editor.

## nvim (WIP)

Install pynvim: `python3 -m pip install --user --upgrade pynvim`
Install nodejs and npm: `pacman -S nodejs npm`
Install fzf and Ag/Rg.
:PlugInstall

## tmux (.tmux.conf)

```sh
# default shell
set-option -g default-shell "/bin/bash"
```

**in tmux.conf:**

- Change default shell `bash` to your preferred shell.
- Change `nvim` in `bind-key M split-window -h "nvim ~/.tmux.conf"` to your preferred editor.

## i3 config (.i3/config <img src="https://latex.codecogs.com/gif.latex?\Delta\text{s}" />)

This section contains the things I changed/added to the default manjaro config for i3.

0. sudo xdg-settings set default-web-browser google-chrome-stable.desktop
1. `/home/$USER/.profile` replace browser entry google-chrome-stable.
2. Under `#Start Applications`, I changed `$mod+F2` to open `google-chrome-stable`
   instead of the default `Pale Moon` (yikes). I also changed all the browser instances
   in `.config/mimeapps.list` (associates default apps to filetypes) to google-chrome.desktop.
3. I commented out `bindsym $mod+Shift+h exec xdg-open /usr/share/doc/manjaro/i3_help.pdf` because
   I'm using `$mod+h/j/k/l` for focus switching (instead of `$mod+j/k/l/;`) and `Shift+` the
   corresponding keys for movement. Also I'll just google for the manual if I need it.
4. `sudo systemctl restart lightdm` to restart xserver or some shit so the settings would take effect.
5. I uncommented this line `focus_follows_mouse no` because it's annoying to have the cursor
   focus the window I'm on without me clicking on it, which is the default behavior if said line
   remained commented.
6. The following keybinds have been changed from `j/k/l/;` for navigation to vim-keybinds `h/j/k/l`.
7. super+Print to screenshot currently focused window with scrot -u into xclip clipboard. TODO: `flameshot`
   to screenshot active display
8. bind different workspaces to different displays

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
   keybind to `mod+Shift+v`.

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

## urxvt config (.Xresources)

urxvt is a unicode version of the lightweight rxvt terminal and is shipped with manjaro i3 by default, alongside iterm and i3-sensible-terminal which I don't use and should uninstall soon.

I basically just wiped all `iterm.*` related configs here and applied gruvbox-dark theme which replaced the old one (between `! BEGIN THEME` and `! END THEME`). Additionally, I removed any lines in the file related to `URxvt*background/foreground` because they overrided the colors. Not sure why they were there to begin with.

I also changed the font from fixed `9x15` to dynamic `pixelsize` based and installed two themes `resize-font` (requires installation from AUR, see arch wiki) and `clipboard` and configured them with the following keybinds (+removed any similar keybinds hitherto present):

```sh
! keybindings
!! extension: resize-font
URxvt.keysym.C-minus:     resize-font:smaller
URxvt.keysym.C-plus:      resize-font:reset
URxvt.keysym.C-equal:     resize-font:bigger
URxvt.keysym.C-slash:     resize-font:show

!! extension: clipboard
URxvt.keysym.Shift-Control-C: perl:clipboard:copy
URxvt.keysym.Shift-Control-V: perl:clipboard:paste
```

## suspend on lid close

See `/etc/systemd/logind.conf`.
