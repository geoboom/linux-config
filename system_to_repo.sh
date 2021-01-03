config_folder='./config/'
home_folder='./home/'

mkdir -p $config_folder
mkdir -p $home_folder

cp -r ~/.config/alacritty/ $config_folder
cp -r ~/.config/nvim/ $config_folder
cp -r ~/.config/i3/ $config_folder
cp -r ~/.config/i3status/ $config_folder
cp -r ~/.config/ranger/ $config_folder
cp -r ~/.config/rofi/ $config_folder
cp -r ~/.config/zathura/ $config_folder
cp -r ~/.config/.guake_preferences $config_folder

cp ~/.tmux.conf $home_folder
cp ~/.zshrc $home_folder
