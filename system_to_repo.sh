rm -rf ./nvim/
rm -rf ./.i3/
rm ./.tmux.conf
rm ./.Xresources
rm ./.zshrc

cp -r ~/.config/nvim/ .
cp -r ~/.i3/ .
cp ~/.tmux.conf .
cp ~/.Xresources .
cp ~/.zshrc .
