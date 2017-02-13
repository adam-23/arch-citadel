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
yaourt -S masterpdfeditor popcorntime-bin spotify pepper-flash slack-desktop minecraft
# Look I added minecraft...
# Kodi-rpb needs to be configured heavily. Should be run as standalone program. 
# Kodi does not work well with screen resolution yet, and fucks up upon exiting. 

echo 'AUR Packages installed.'