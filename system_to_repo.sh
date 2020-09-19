rm -rf ./nvim/
rm -rf ./.i3/
rm ./.tmux.conf
rm ./.Xresources
rm ./.zshrc
rm -rf ./ranger/
rm -rf ./rofi/
rm -rf ./zathura/

cp -r ~/.config/nvim/ .
cp -r ~/.i3/ .
cp ~/.tmux.conf .
cp ~/.Xresources .
cp ~/.zshrc .
cp -r ~/.config/ranger/ .
cp -r ~/.config/rofi/ .
cp -r ~/.config/zathura/ .
