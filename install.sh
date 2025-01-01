#!/bin/bash

if [[ $EUID -ne 0 ]]; then
  echo "Skrip ini harus dijalankan sebagai root!"
  exit 1
fi

echo "Memperbarui repositori dan sistem..."
sudo pacman -Syu --noconfirm

packages=(
  bspwm
  sxhkd
  polybar
  dunst
  rofi
  pamixer
  nitrogen
  thunar
  lxappearance
  j4-dmenu-desktop
  brightnessctl
  alacritty
  lightdm
  lightdm-gtk-greeter
  lightdm-gtk-greeter-settings
  google-chrome
  zsh
  starship
  git
  neofetch
  nvim
)

echo "Menginstal paket-paket yang diperlukan..."
sudo pacman -S "${packages[@]}" --noconfirm

echo "Mengaktifkan dan memulai LightDM..."
sudo systemctl enable lightdm
sudo systemctl start lightdm

echo "Mengatur LightDM sebagai display manager default..."
sudo dpkg-reconfigure lightdm

echo "Mengatur Zsh sebagai shell default..."
chsh -s $(which zsh)

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  echo "Menginstal Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo "Memindahkan file .zshrc ke direktori home..."
cp zsh/.zshrc $HOME/.zshrc

echo "Memindahkan konfigurasi LightDM..."
sudo cp lightdm/lightdm-gtk-greeter.conf /etc/lightdm/lightdm-gtk-greeter.conf

sudo cp lightdm/background_dark.jpg /usr/share/backgrounds/background_dark.jpg

echo "Memindahkan file konfigurasi ke ~/.config..."
mkdir -p $HOME/.config/alacritty
cp alacritty/alacritty.conf $HOME/.config/alacritty/alacritty.yml

mkdir -p $HOME/.config/bspwm
cp bspwm/bspwmrc $HOME/.config/bspwm/bspwmrc

mkdir -p $HOME/.config/sxhkd
cp -r bspwm/script $HOME/.config/sxhkd/script
chmod +x $HOME/.config/sxhkd/script

mkdir -p $HOME/.config/starship
cp starship/starship.toml $HOME/.config/starship.toml

mkdir -p $HOME/.config/sxhkd
cp bspwm/sxhkdrc $HOME/.config/sxhkd/sxhkdrc

mkdir -p $HOME/.config/polybar
cp bspwm/polybar/config $HOME/.config/polybar/config

mkdir -p $HOME/.config/picom
cp bspwm/picom.conf $HOME/.config/picom/picom.conf

mkdir -p $HOME/.config/dunst
cp bspwm/dunstrc $HOME/.config/dunst/dunstrc

echo "Instalasi selesai! Harap restart sistem untuk memastikan semua konfigurasi berjalan dengan baik."
