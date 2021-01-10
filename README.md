# Ubuntu/Debian-based config

I'm using **Pop!\_OS**.

## Summary

```sh
# install necessary packages
sudo apt install i3 i3lock i3status fzf scrot zsh \
         ripgrep python3-pip guake rofi ranger \
         pavucontrol alacritty tmux fonts-powerline \
         lxappearance gtk-chtheme -y

# install ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install python packages
pip3 install pynvim i3ipc

# install nvim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod +x nvim.appimage
sudo mv ./nvim.appimage /usr/local/bin/nvim

# install nodejs
curl -sL https://deb.nodesource.com/setup_15.x | sudo -E bash sudo apt-get install -y nodejs

# commands below not tested yet
cp -r config/. ~/.config/
cp -r home/. ~/

# close terminal and open alacritty
# open vim and :PlugInstall
vim
# - let vim plugins install
# - let coc.nvim plugins install

# load guake preferences
guake --restore-preferences ~/.config/.guake_preferences

# install google-chrome from
# https://www.google.com/intl/en_sg/chrome/

# logout and login using i3
```

```bash
# install nerd fonts
git clone https://github.com/ryanoasis/nerd-fonts --depth 1
cd nerd-fonts
./install.sh

# install fzf bindings
git clone https://github.com/junegunn/fzf
cd fzf
./install.sh
```

```bash
# to connect to VPN using openconnect

# install openconnect
sudo apt install openconnect -y

# fix symlink /etc/resolv.conf -> /run/resolvconf/resolv.conf issue
sudo dpkg-reconfigure resolvconf

# convert pfx key to pem key type (for my work vpn)
openssl pkcs12 -in GeneralVPN.pfx -out WorkVPN.pem -nodes

# connect to vpn
sudo openconnect -c path_to_pem_file vpn_url
```
