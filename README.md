# Ubuntu/Debian-based config

I'm using **Pop!\_OS**.

## Summary

```sh
# install necessary packages
sudo apt install i3 i3lock i3status fzf \
         ripgrep python3-pip guake rofi \
         pavucontrol alacritty tmux fonts-powerline -y

# install python packages
pip3 install pynvim i3ipc

# install nvim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod +x nvim.appimage
sudo mv ./nvim.appimage /usr/local/bin/nvim

# install nodejs
curl -sL https://deb.nodesource.com/setup_15.x | sudo -E bash -\nsudo apt-get install -y nodejs

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
