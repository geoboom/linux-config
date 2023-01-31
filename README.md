# Ubuntu 22.04 Server Bootstrap Notes

I'm using **Ubuntu 22.04**.
![image](https://user-images.githubusercontent.com/13282914/215683931-be2f8529-ca97-47b3-a9d2-c9bd3748066e.png)

## Diary

1. I downloaded `Ubuntu 22.04` server using `wget https://releases.ubuntu.com/22.04/ubuntu-22.04.1-live-server-amd64.iso` on my `pop-os` desktop
1. I plugged in my USB thumbdrive and ran `lsblk`, identified the block device corresponding to it which is `/dev/sdd`, and ran `sudo dd if=$HOME/Downloads/ubuntu-22.04.1-live-server-amd64.iso of=/dev/sdd bs=1M status=progress`. Alternatively, you can run `dmesg` (as root) after plugging in the thumbdrive and it'll tell you which block device it corresponds to. `dmesg` displays all the messages from the kernel ring buffer which is basically a log of the kernel.
1. Once `dd` is done, I plugged out the thumbdrive and plugged it into my new PC, using it as boot media. I followed the installation steps to install Ubuntu server and rebooted into a black tty.
1. However, I noticed that during the booting, this task "a start job is running for wait for network to be configured" was taking over 1min+ to complete. I have no idea what it's about so I googled it and found these commands to run `systemctl disable systemd-networkd-wait-online.service` and `systemctl disable systemd-networkd-wait-online.service` to respectively disable and disallow other services to re-enable this service, which is the cause of the issue. I don't know what implications it has and I don't really care since nobody is complaining on stackexchange.
1. (Optional) Ran `ip a` to get my local ipv4 address and `ssh-copy-id -i ~/.ssh/id_ed25519 geoboom@192.168.0.132` to append my public key from `poop-os` to my new machine's `~/.ssh/authorized_keys` so I don't have to use password to ssh.
1. (Optional) `ssh`'d into my new machine from `poop-os`. Let's just call my new machine `ubuntu-server-main`.
1. In `ubuntu-server-main`, ran:
```
# to avoid annoying popup and autorestart services
# apparently just writing `export DEBIAN_FRONTEND=noninteractive\nexport NEEDRESTART_MODE=a`
# in terminal won't work because the `apt upgrade` and `apt install` commands are run
# with sudo, which doesn't preserve this user environment unless ran with sudo -E.
# so, I will add these exports into /etc/environment, used system-wide :D
echo 'export DEBIAN_FRONTEND=noninteractive\nexport NEEDRESTART_MODE=a' \
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
                 ranger \
                 npm \
                 zip \
                 xsel \
                 alacritty \
                 libfuse2 -y

mkdir -p $HOME/.local/bin
ln -s /usr/bin/fdfind $HOME/.local/bin/fd

# use zsh shell
chsh -s $(which zsh)

# install omz
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# make xinit start i3
echo "exec i3" > $HOME/.xinitrc

# install fzf and set up bindings
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

# install rust, sh -s reads options from stdin
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"

# install clang stuff
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
echo "DefaultTimeoutStartSec=10s\nDefaultTimeoutStopSec=10s\n" | sudo tee -a /etc/systemd/system.conf > /dev/null

# set timezone, might break idk
sudo timedatectl set-timezone $(timedatectl list-timezones | grep -i singapore | head -n 1)
```

