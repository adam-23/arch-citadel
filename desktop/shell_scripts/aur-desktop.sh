#!/bin/bash

echo 'AUR Uruk Install Script v0.2 by Adam'
echo '-----------------------------------------'
echo
echo 'This is the installation script for Desktop AUR packages.'
echo 'Cannot be run with root.'
echo 'If you need a new user, run the user-setup.sh script.'



################# SYU
echo 'Updating base system.'
echo
sudo pacman -Syu
echo
# Updates/upgrades system.



################### Install AUR Helper
echo 'Installing AUR Helper: Yaourt.'
git clone https://aur.archlinux.org/package-query.git
cd package-query
makepkg -si
cd ..
git clone https://aur.archlinux.org/yaourt.git
cd yaourt
makepkg -si
cd ..
# Installs AUR Helper: Yaourt



############# Install AUR Packages
echo "Installing PDF editor, popcorntime, spotify, flash, slack, and Minecraft."
yaourt -S masterpdfeditor popcorntime-bin spotify pepper-flash slack-desktop minecraft cava
# PDF editor, popcorntime, spotify, Flash, slack, minecraft, cava (audio visualizer)
echo "Be sure to tweak cava in .config/cava/config to your liking."
echo
echo "Installing system themes Dark Arc GTK Theme and La Capitaine icons."
yaourt -S arc-gtk-theme la-capitaine-icon-theme-git gnome-terminal-transparency
echo
echo "Be sure to set the new GTK and Icon themes using the Gnome Tweak tool."
# System themes for GTK/Icons,



######## Steam Under Wine, 64bit
echo
echo "Installing Wine, Steam"
echo
sudo pacman -S wine lib32-alsa-lib lib32-alsa-plugins
echo
echo "Installing Steam system fonts."
echo
yaourt -S ttf-tahoma ttf-ms-fonts
echo "Now you must download the Steam Installer. Opening Chrome..."
sleep 5s
exec chromium http://store.steampowered.com/about/



echo 'AUR Packages installed.'
