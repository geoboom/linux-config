# Ubuntu 22.04 Server Bootstrap Notes

I'm using **Ubuntu 22.04**.
![image](https://user-images.githubusercontent.com/13282914/217356191-22fc1c32-4b58-4d53-adae-8a7cee3684dd.png)

## Diary - Linux

1. I downloaded `Ubuntu 22.04` server using `wget https://releases.ubuntu.com/22.04/ubuntu-22.04.1-live-server-amd64.iso` on my `pop-os` desktop
1. I plugged in my USB thumbdrive and ran `lsblk`, identified the block device corresponding to it which is `/dev/sdd`, and ran `sudo dd if=$HOME/Downloads/ubuntu-22.04.1-live-server-amd64.iso of=/dev/sdd bs=1M status=progress`. Alternatively, you can run `dmesg` (as root) after plugging in the thumbdrive and it'll tell you which block device it corresponds to. `dmesg` displays all the messages from the kernel ring buffer which is basically a log of the kernel.
1. Once `dd` is done, I plugged out the thumbdrive and plugged it into my new PC, using it as boot media. I followed the installation steps to install Ubuntu server and rebooted into a black tty.
1. However, I noticed that during the booting, this task "a start job is running for wait for network to be configured" was taking over 1min+ to complete. I have no idea what it's about so I googled it and found these commands to run `systemctl disable systemd-networkd-wait-online.service` and `systemctl mask systemd-networkd-wait-online.service` to respectively disable and disallow other services to re-enable this service, which is the cause of the issue. I don't know what implications it has and I don't really care since nobody is complaining on stackexchange.
1. (Optional) Ran `ip a` to get my local ipv4 address and `ssh-copy-id -i ~/.ssh/id_ed25519 geoboom@192.168.0.132` to append my public key from `poop-os` to my new machine's `~/.ssh/authorized_keys` so I don't have to use password to ssh.
1. (Optional) `ssh`'d into my new machine from `poop-os`. Let's just call my new machine `ubuntu-server-main`.
1. In `ubuntu-server-main`, ran:
```
# to avoid annoying popup and autorestart services
# apparently just writing `export DEBIAN_FRONTEND=noninteractive\nexport NEEDRESTART_MODE=a`
# in terminal won't work because the `apt upgrade` and `apt install` commands are run
# with sudo, which doesn't preserve this user environment unless ran with sudo -E.
# so, I will add these exports into /etc/environment, used system-wide :D
echo -e 'export DEBIAN_FRONTEND=noninteractive\nexport NEEDRESTART_MODE=a' \
  | sudo tee -a /etc/environment > /dev/null

sudo apt update && sudo apt upgrade -y

# add alacritty ppa
sudo add-apt-repository ppa:aslatter/ppa -y

# update again
sudo apt update && sudo apt upgrade -y

# install some packages
sudo apt install xinit \
                 i3 \
                 zsh \
                 ripgrep \
                 python3-pip \
                 fd-find \
                 rofi \
                 npm \
                 zip \
                 xsel \
                 alacritty \
                 libfuse2 \
                 tree \
                 cheese -y

sudo npm install --global yarn

mkdir -p $HOME/.local/bin
ln -s /usr/bin/fdfind $HOME/.local/bin/fd

# use zsh shell
chsh -s $(which zsh)

# install omz
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# make omz not lag in git repos
git config --global --add oh-my-zsh.hide-status 1
git config --global --add oh-my-zsh.hide-dirty 1

# make xinit start i3 and GTK apps not take 10 years to fking open
# see reply in https://bbs.archlinux.org/viewtopic.php?id=224787 by dumblob
STUPID_GTK='dbus-update-activation-environment'
STUPID_GTK+=' --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY'
echo -e "${STUPID_GTK}\nexec i3" > $HOME/.xinitrc

# install fzf and set up bindings
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

# install rust, sh -s reads options from stdin
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"

# install rust-analyzer (https://rust-analyzer.github.io/manual.html#installation)
rustup component add rust-src
rustup component add rust-analyzer
ln -s $(rustup which --toolchain stable rust-analyzer) ~/.cargo/bin/rust-analyzer

# install clang stuff, see `.config/clangd/config.yaml` in configuration-files
sudo apt install clang-format clang-tidy clang-tools clang clangd libc++-dev libc++1 libc++abi-dev libc++abi1 libclang-dev libclang1 liblldb-dev libllvm-ocaml-dev libomp-dev libomp5 lld lldb llvm-dev llvm-runtime llvm python3-clang -y

# add bits/stdc++.h header
sudo mkdir -p /usr/include/bits
sudo wget \
  https://raw.githubusercontent.com/tekfyl/bits-stdc-.h-for-mac/master/stdc%2B%2B.h \
  --output-document=/usr/include/bits/stdc++.h

# install neovim
mkdir -p $HOME/.local/bin
cd $HOME/.local/bin
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
mv nvim.appimage nvim
chmod +x nvim
cd $HOME

# install this https://github.com/lbonn/i3-focus-last into $HOME/.local/bin/i3-focus-last
mkdir -p Downloads && cd Downloads
git clone https://github.com/lbonn/i3-focus-last
cd i3-focus-last
cargo build --release
cp target/release/i3-focus-last $HOME/.local/bin/

# copy over configuration files
# Use git root as variable so I don't accidentally
# rsync -ravP . 192.168.0.132:~/ while # inside configuration-files/.config
# dir and make a mess in remote's ~/ lol. This way, can run rsync in any subdir
# of this repo yey
GIT_ROOT_DIR=$(git rev-parse --show-toplevel)
rsync -ravP $GIT_ROOT_DIR/configuration-files/ 192.168.0.132:~/

# alternatively on the same machine,
GIT_ROOT_DIR=$(git rev-parse --show-toplevel)
rsync -ravP $GIT_ROOT_DIR/configuration-files/ ~

# install jetbrains mono nerd font
mkdir -p $HOME/.local/share/fonts
cd $HOME/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/JetBrainsMono.zip
unzip JetBrainsMono.zip
fc-cache -f -v
cd $HOME

# install alacritty themes
mkdir -p ~/.config/alacritty/themes
git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes

# install chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo add-apt-repository "deb http://dl.google.com/linux/chrome/deb/ stable main" -y
sudo apt update
sudo apt install google-chrome-stable -y

# install nvidia driver for RTX 4080 (method#1)
sudo add-apt-repository ppa:graphics-drivers/ppa -y
sudo apt update
sudo apt install nvidia-driver-525 -y

# install nvidia driver for RTX 4080 (method#2)
cd $HOME/Downloads
wget https://us.download.nvidia.com/XFree86/Linux-x86_64/525.60.11/NVIDIA-Linux-x86_64-525.60.11.run
chmod +x NVIDIA-Linux-x86_64-525.60.11.run
sudo ./NVIDIA-Linux-x86_64-525.60.11.run
cd $HOME

# set time to kill pending process to 10s so shutdown is faster by
# changing these DefaultTimeoutStartSec, DefaultTimeoutStopSec in /etc/systemd/system.conf
# TODO: use sed to uncomment and set the values instead of appending
echo -e "DefaultTimeoutStartSec=10s\nDefaultTimeoutStopSec=10s\n" | sudo tee -a /etc/systemd/system.conf > /dev/null

# set timezone, might break idk
sudo timedatectl set-timezone $(timedatectl list-timezones | grep -i singapore | head -n 1)

# install dragon for drag and drop
cd $HOME/Downloads && git clone https://github.com/mwh/dragon dragon-dnd
cd dragon-dnd
sudo apt install libgtk-3-dev
make install PREFIX=$HOME/.local
cd $HOME

# install zathura and make it the default pdf reader
sudo apt install zathura
xdg-mime default org.pwmt.zathura.desktop application/pdf

# set up audio
sudo apt install alsa-utils pavucontrol -y
pulseaudio -k
pulseaudio -D

# TODO:
# instructions on setting up kitty, installing pillow, ffmpeg, ffmpegthumbnailer
# for ranger image and video preview

# TODO:
# instructions on compiling mupdf, zathura, zathura-pdf-mupdf and setting
# mupdf-x11 as default image viewer using mimeopen -d or creating .local/share/applications/<...>.desktop
# and adding to .config/mimeapps.list:
# image/png=mupdf-usercreated-1.desktop;
# image/jpeg=mupdf-usercreated-2.desktop;
# under [Added Associations]

# install some comms
sudo snap install discord
sudo snap connect discord:system-observe
sudo snap install telegram-desktop --edge

# Update kernel from 5.15.X to 5.19.X, just to see if it'll fix the
# "/user.slice/user-1000.slice/session-1.scope is not a snap cgroup" issue caused
# by running i3 using `dbus-launch --exit-with-session i3` in ~/.xinitrc to
# fix GTK apps taking 20s to open, sigh. SPOILER ALERT - it didn't fix the issue
# but now with just `exec i3` after kernel update, opening GTK apps is instantaneous
# (for now at least) so I wasted an hour of debugging for nothing.
sudo add-apt-repository ppa:cappelikan/ppa
sudo apt update
sudo apt install mainline
sudo mainline --install 5.19.17
# if not it's gonna hang on startup because my gpu doesn't support modeset
sudo sed -i \
    's/GRUB_CMDLINE_LINUX_DEFAULT.*/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash nomodeset"/g' \
    /etc/default/grub
sudo update-grub2
sudo reboot
```

## Diary - Mac

- System Preferences > General:
  - Accent color: graphite
  - Sidebar icon size: small
- System Preferences > Accessibility:
  - Tick "Reduce motion"
  - Tick "Reduce transparency"
- System Preferences > Trackpad:
  - Untick "Scroll direction: Natural"
- System Preferences > Desktop & Dock:
  - Automatically hide and show the menu bar: "Always"
- Might have to set up workspace switching keybinds (`alt+{1-0,;,'}`), idk
- Install chrome extensions:
  - ublock-origin
  - vimium-c
    - import configuration into chrome

- Install xcode tools:
```
xcode-select --install
```

- Save and run this script to import defaults
```
#!/bin/bash

IFS=$', '
EXPORT_DIR=MY_DEFAULTS_EXPORTS_PATH
domains=$(defaults domains)

for domain in $domains; do
    cmd="defaults import $domain $EXPORT_DIR/$domain.txt"
    echo $cmd
    eval $cmd
done
```

- Install homebrew:
```
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# if no sudo
mkdir ~/homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C ~/homebrew
echo 'export PATH=$PATH:$HOME/homebrew/bin' >> ~/.zshrc && source ~/.zshrc
```

- Install programs
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
brew install --cask alacritty
brew install tmux
brew install ripgrep
brew install fd
brew install --cask karabiner-elements
brew install --cask alt-tab
brew install --cask hammerspoon
brew install koekeishiya/formulae/skhd
brew install koekeishiya/formulae/yabai # https://github.com/koekeishiya/yabai/wiki/Installing-yabai-(latest-release)

# install fzf and set up bindings
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all
```

- Start services
```
brew services start yabai
brew services start skhd
```

- Install and setup sketchybar
```
brew tap homebrew/cask-fonts
brew install font-jetbrains-mono-nerd-font
brew install --cask font-hack-nerd-font
brew tap FelixKratz/formulae
brew install sketchybar
brew services start sketchybar

git clone https://github.com/FelixKratz/SketchyBar
mkdir -p ~/.config/sketchybar
cp -r ./SketchyBar/{plugins,sketchybarrc} ~/.config/sketchybar
chmod +x ~/.config/sketchybar/plugins/*
rm -rf SketchyBar
```
