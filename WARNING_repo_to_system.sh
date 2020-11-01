rm -rf ~/.config/nvim/
rm -rf ~/.i3/
rm ~/.tmux.conf
rm ~/.Xresources
rm ~/.zshrc
rm -rf ~/.config/alacritty/

cp -r ./nvim/ ~/.config/nvim/
cp -r ./.i3/ ~/.i3/
cp ./.tmux.conf ~
cp ./.Xresources ~
cp ./.zshrc ~
cp -r ./alacritty/ ~/.config/alacritty/
cp .Xmodmap ~/.Xmodmap
cp .ideavimrc ~/.ideavimrc
cp -r ./ranger/  ~/.config/ranger/
cp -r ./rofi/    ~/.config/rofi/
cp -r ./zathura/ ~/.config/zathura/
