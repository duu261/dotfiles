pacman -S noto-fonts noto-fonts-emoji ttf-linux-libertine
noto-fonts-emoji noto-fonts-cjk ruby git luarocks lua51 neovim tmux zsh wezterm stow ttf-firacode-nerd
sudo pacman -S bluez bluez-utils blueman
sudo pacman -S fcitx5 fcitx5-bamboo fcitx5-configtool
sudo systemctl enable ufw and sudo ufw enable.
###yay###
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
cd .. rm -rf yay
 must pkg neovim {
     luarocks lua51 ripgrep xclip fd clipmenu
 } git auth to install??
yay -Syu --devel --timeupdate

###TMUX

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
###END TMUX

#command
chsh -s $(which zsh)

############zsh#######
pkg fzf eza zoxide bat thefuck fd vivid
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/catppuccin/zsh-syntax-highlighting.git
cd zsh-syntax-highlighting/themes/
cp -v catppuccin_mocha-zsh-syntax-highlighting.zsh ~/.zsh/
#######################
#####sddm theme########
pacman -Syu qt6-svg qt6-declarative qt5-quickcontrols2

curl https://github.com/catppuccin/sddm/releases/download/v1.0.0/catppuccin-macchiato.zip
sudo unzip catppuccin-macchiato.zip -d /usr/share/sddm/themes/
sudo echo -e "[Theme]\nCurrent=catppuccin-flavour" > sddm.conf && mv sddm.conf /etc
sudo mv sddm.conf /etc
sudo cp ~/Pictures/Wallpapers/catppuccin-macchiatio/anime-girl-skull.png /usr/share/sddm/themes/catppuccin-macchiato/backgrounds/wall.png
i need to fix the setting somehow..
#######i3########3
i3status-rust dunst yay -S catppuccin-cursors-macchiato sudo pacman -S lxappearance qt5ct qt6ct brightnessctl nwg-look
wallpaper
pkg feh
yay -S i3-auto-tiling
sudo pacman -S xdg-user-dirs
xdg-user-dirs-update
git clone https://github.com/duu261/wallpapers ~/Pictures/Wallpapers
sudo pacman -S papirus-icon-theme
git clone https://github.com/catppuccin/papirus-folders.git
cd papirus-folders
sudo cp -r src/* /usr/share/icons/Papirus
curl -LO https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-folders/master/papirus-folders && chmod +x ./papirus-folders
For Arch Linux Users

With your favorite AUR helper, install with:

yay -S papirus-folders-catppuccin-git

then you could run papirus-folders -h to see all available command. Bash & ZSH completions are included.
#######
#######power###
sudo pacman -S tlp acpi acpid
sudo systemctl enable tlp
sudo systemctl start tlp
sudo systemctl enable acpid
sudo systemctl start acpid
sudo pacman -S tp_smapi tlp
#########
####wiki###
pkg: tealdeer pacman -S wikiman arch-wiki-docs
curl -L 'https://raw.githubusercontent.com/filiparag/wikiman/master/Makefile' -o 'wikiman-makefile'
make -f ./wikiman-makefile source-tldr
sudo make -f ./wikiman-makefile source-install
sudo make -f ./wikiman-makefile clean
