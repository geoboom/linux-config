rm -rf ./nvim/
rm -rf ./.i3/
rm ./.tmux.conf
rm ./.Xresources
rm ./.zshrc
rm ./.ideavimrc
rm -rf ./ranger/
rm -rf ./rofi/
rm -rf ./zathura/
rm ./.xprofile
rm -rf ./alacritty/
rm .Xmodmap

cp -r ~/.config/nvim/ .
cp -r ~/.i3/ .
cp ~/.tmux.conf .
cp ~/.Xresources .
cp ~/.zshrc .
cp -r ~/.config/ranger/ .
cp -r ~/.config/rofi/ .
cp -r ~/.config/zathura/ .
cp ~/.xprofile .
cp -r ~/.config/alacritty/ .
cp ~/.ideavimrc .
cp ~/.Xmodmap .
cp ~/.guake_preferences .
