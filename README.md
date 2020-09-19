# My very rough walkthrough for setting up stuff on an Arch-based system

**Contents (TODO: hyperlink):**

- manjaro installation walkthrough
- shell (zsh/bash/fish) aliases and functions
- nvim
- tmux
- i3 config (includes startup scripts)
- Xresources (urxvt) config
- suspend on lid close (systemd-logind)

**TODO:**

- make note on the need to change workspace-to-output mapping when change to laptop with external display
- find out how to copy and paste with tmux keyboard-only
- alt-tab behavior for workspace switching perhaps LOL
- zathura config
- document `system_to_repo.sh` and `repo_to_system.sh`. AND HAVE CONFIRMATION PROMPT.
- install intellij idea and document process and blog about the helpful keybindings
  - figure out if intellij idea vim emulation has plugin support
  - evaluate performance of intellij idea vim emulation especially `set rnu nu`
- huion tablet driver installation walkthrough and `xinput map-to-output <device-id> <output-id>`
- add misc section and add this in: `sudo chown -R $(whoami) /usr/share/idea`
- add notes on `bluetoothctl` setup for audio devices (`a2dp_sink`, `aptX` support, `pavucontrol`, `pulseaudio`, `pactl`, `modprobe`, `lsusb`, `journalctl -f`)
- add stuff on what is `lsmod`, `modprobe`, `lsblk`, `lsusb`, what is a linux kernel module, etc
- add more kernel and hardware stuff and how terminal commands interface with them (so next time know where to look to diagnose an issue)
- disable `lightdm` and use `startx` to run `i3`

## My manjaro installation walkthrough (i3wm)

Take note that this section is heavily WIP. Will move the tips out to another
section.

1.  `xset r rate 270 33` my preferred repeat rate and delay
2.  `xset -b` to remove the bell
3.  clone this repo
4.  update pacman and repos `pacman-mirrors --geoip && pacman -Syyu`
5.  open `pamac-manager` gui and ensure enable AUR support is yes
6.  install google-chrome with yay from AUR `yay google-chrome` (check AUR first for the correct package name in case it changes). TODO: replaced with chromium now!!!
7.  remove palemoon and update default browser for all applications (in `~/.profile`, `.config/mimeapps.list` do this before `:PlugInstall` in nvim!!!) (TODO: more detaile steps)
8.  install zsh
9.  configure multiple monitor layout with arandr and save config as `.sh`. Then, xrandr startup script... (TODO: persist xrandr config, rate 144, etc)
10. sound: (TODO: `alsa-utils` sound driver install; `pulseaudio` is the soundserver)
    1. install pavucontrol and pulseaudio. Not sure if need pulseaudio if I have pavucontrol/any alternatives to pavucontrol...
    2. default soundcard issue `/etc/modprobe.d/alsa-base.conf` (see arch wiki)
11. disable mouse acceleration
12. configure datetime properly. Not sure why after boot into manjaro timezone fucks up: manjaro-settings-manager -> time and date -> set time and date automatically
13. flameshot for screenshot: `pacman -S flameshot` (TODO: remove this. Document `scrot`)
14. disable mouse acceleration (`xinput --list`, `xinput --list-props <device-id>`, `xinput --set-prop <device-id> 'libinput Accel Speed' -0.7`) and permanently commit: xorg config file in `/etc/X11/xorg.conf.d/10-mouse.conf`:

    ```sh
    Section "InputClass"
        Identifier "Mouse"
        MatchIsPointer "True"
        Option "libinput Accel Speed" "-0.8"
    EndSection
    ```

15. if window is nested/stuck, just move it to the left/right until it gets unnested!
16. change cursor to inverted color and make it bigger
17. replace `dmenu` with `rofi`
18. to mount windows partition (`mkdir -p /media/$USER/WIN_PART` first):
    1. `lsblk`
    2. `sudo mount -t ntfs-3g -o ro /dev/sdX# /media/$USER/WIN_PART`
    3. `sudo umount /media/$USER/WIN_PART`
19. `inxi -G` to see graphic drivers. Then, `nvidia-settings`: set refresh rate to 144Hz.
20. set ctrl+j/k to select prev/next row in rofi: https://gist.github.com/MilesMcBain/0e6f449c3f8e07ed1b06aa785b0726ff
    1. to get rofi config, `mkdir -p ~/.config/rofi/`
    2. then `rofi -dump-xresources > ~/.config/rofi/config`
21. change DNS to google dns:
    1. create `/etc/NetworkManager/conf.d/20-rc-manager.conf`
    2. save with:
       ```sh
       [main]
       rc-manager=resolvconf
       ```
    3. edit `/etc/resolvconf.conf` and add:
       ```sh
       # google dns
       name_servers="8.8.8.8 8.4.4.4"
       ```
    4. `sudo resolvconf -u` to reload changes but breaks after restart. Not sure why (TODO).
22. `i3-msg -t get_tree` to see all windows. Can get class of specific window you
    wish to make floating e.g. `for_window [class="Google-chrome" window_role="pop-up"] floating enable`
    for chrome pop-ups e.g. sign in with google OAuth.
23. for alt-tab behavior:
    1. `pip3 install i3ipc`
    2. download the `focus-last.py` from https://github.com/altdesktop/i3ipc-python
    3. `chmod +x focus-last.py` and `mv focus-last.py /usr/bin/`.
    4. add `exec_always --no-startup-id focus-last.py` and
       `bindsym Mod1+Tab exec --no-startup-id focus-last.py --switch` to `~/.i3/config`
    5. restart i3 and enjoy alt-tab behavior for 2 LRU windows
24. `sudo pacman -S imwheel` to install `imwheel` which can modify scroll wheel speed on a per-program basis and paste the following config into `~/.imwheelrc`

    ```sh
    # Speed up scrolling for chromium
    "^chromium$"
        None, Up, Button4, 2
        None, Down, Button5, 2

    # Speed up scrolling for the document viewer
    "^zathura$"
        None, Up, Button4, 2
        None, Down, Button5, 2
    ```

    This will allow you to scroll faster (twice normal speed) in chromium and zathura and not break your index finger trying to scroll at one sentence per revolution, the default in linux -\_-. To reload config, `pkill imwheel` and then run `imwheel`. TODO: run as startup task.

25. `sudo pacman -S piper` for mouse config. Supports g502.
26. `i3-msg 'rename workspace <num1> to <num2>'` helpful to rename/renumber workspace!
27. Troubleshooting steps if attempting to run docker but getting permissions issue
    trying to connect to the docker daemon socket:
    1. google first and follow digitalocean's guide (the docker usergroup one)
    2. `sudo chmod 777 /var/run/docker.sock` from some stackoverflow answer.
28. spellchecking: `pacman -S hunspell-en_US` and `echo $LANG` - make sure `LANG` is `en_US`.
    Otherwise, `vim /etc/locale.conf` and set `LANG=en_US.UTF-8`.
29. Dropbox installation process
    1. `cd ~/Downloads` and `git clone https://aur.archlinux.org/dropbox.git`
    2. `cd dropbox` and `wget https://linux.dropbox.com/fedora/rpm-public-key.asc` to download dropbox's
       public key
    3. import it with `gpg --import rpm-public-key.asc` and check keys with `gpg -k`
    4. `makepkg -si` to build and install
    5. run `dropbox` from dmenu/rofi and login to dropbox on the browser
    6. your dropbox folder can be found in `~/dropbox`. Installation complete.
30. Installing powerline fonts and configuring urxvt to use them

### Wifi setup

1. Follow manjaro wifi connection guide and if you can connect to wifi, ignore following steps.
2. Ensure your packages are updated first: `pacman -Syyu`.
3. Type `ip link` and see if `wlan0` is present. Probably not.
4. Type `lspci -nn` and find your `Network Controller` and google the installation instructions for it.
5. Example:
   ```
   09:00.0 Network controller [0280]: Broadcom Inc. and subsidiaries BCM4360 802.11ac Wireless Network Adapter [14e4:43a0] (rev 03)
   ```
   1. From google, I have to install `broadcom-wl` using `pacman -S broadcom-wl`.
   2. After typing that, there will be a list of `broadcom-wl` versions to install - these are actually
      kernel versions and you must install the correct one based on your linux kernel.
   3. To view your kernel version, type `uname -r`. Example output is `5.7.14-1-MANJARO`.
   4. Thus, I will select `linux57-broadcom-wl` from the `pacman -S broadcom-wl` to install.
   5. After successful install, type `ip link` and check if `wlan0` is present. If it is, you may connect to wifi normally (step 1).

## shell stuff

Find my `zsh` config in `.zshrc`. I wrote some aliases to simplify common operations
cough cough alias vim=nvim and opening tmux splits.

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
9. bind alt+tab and super+tab to switch workspaces back-and-forth because I keep hitting alt+tab accidentally lol.

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
