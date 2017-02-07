#!/bin/bash
echo 'Konosos Install Script v0.3 by Adam'
echo '-----------------------------------------'
echo
echo 'This is the installation script for Arch Linux, Lightweight Install.'
echo 'This will install AUR packages for Arch Citadel for Rpi3'
echo 'Run as root.'



####### USER SETUP
echo
echo -n "Enter your new desired username > "
read NEWUSER
echo "Username to add: $NEWUSER"
# Asks user for a new user name, and stores the input as a variable.
# This $NEWUSER variable will be used for the rest of the script. 



########### Append user to Sudoers file
echo 'Configuring sudo priviliges.'
# Main User Setup:
useradd -m -G wheel -s /bin/bash $NEWUSER
echo '%wheel ALL=(ALL) ALL' >> /etc/sudoers
echo '# Above line appended by Konosos install script.' >> /etc/sudoers
# Allows user to use sudo command.



########### Password Configuration
echo
echo 'Now passwords must be manually configured.'
echo
echo 'Enter the new password for root.'
passwd root
echo
echo 'Enter the new password for the new user.'
passwd $NEWUSER
echo
echo 'Passwords configured.'
echo 'User assigned.'
# Changes the password of the root user and the generated user



########## SYU
echo 'Updating base system.'
echo
pacman -Syu
echo
# Updates/upgrades system.



########## X
echo
echo 'Installing "X" graphical display packages.' 
echo
pacman -S xorg xorg-xinit xorg-server
# Installs X GUI backend.



########## XFCE and Battery
echo
echo 'Installing "XFCE" desktop environment.'
echo
pacman -S xfce4 gnome-keyring tlp
# XFCE standard packages and TLP battery saver.



########## Soundcard Enable
echo
echo 'Configuring "XFCE" system environment.'
echo
pacman -S alsa-utils alsa-tools alsa-firmware pulseaudio
echo 'dtparam=audio=on' >> /boot/config.txt
echo 'audio_pwm_mode=2' >> /boot/config.txt
echo '# Above line appended by Konosos install script.' >> /boot/config.txt
# Required packages and configuration for sound to work on RPi3. 
echo



########## Autoboot to XFCE
echo
echo 'Configured auto-boot to XFCE Desktop.'
echo
echo 'exec startxfce4' >> /home/$NEWUSER/.xinitrc
echo '# Above comment appended by Konosos install script.' >> /home/$NEWUSER/.xinitrc
echo 'exec startx' >> /home/$NEWUSER/.bash_profile
echo '# Above comment appended by Konosos install script.' >> /home/$NEWUSER/.bash_profile
# Enables XFCE and X to start at boot. 



########## Enable TLP (Battery)
echo
echo 'Configuring battery life saver.' 
echo
systemctl enable tlp.service
systemctl enable tlp-sleep.service
systemctl disable systemd-rfkill.service
# Enables and configures TLP battery saver. 



######### Programming Tools 
echo
pacman -S git base-devel wget gvfs gamin bash-completion tk python3 python2 pluma gparted
# Installs basic programming tools to your liking.



########## Network Tools
echo
echo 'Installing network tools.'
echo
pacman -S iw wpa_supplicant dialog
pacman -S networkmanager network-manager-applet dnsmasq networkmanager-openvpn 
pacman -S transmission-cli transmission-gtk chromium gparted
# Installs network tools.


########### Configuring Network Tools
echo
echo 'Configuring network tools.'
echo
systemctl enable NetworkManager.service
systemctl enable wpa_supplicant.service
gpasswd -a $NEWUSER network
# Configures network tools. 



########## File Processing Tools
echo
echo 'Installing file processing tools.'
echo
pacman -S gimp libreoffice-fresh




########## Raspberry Pi Media System/Torrenting
echo
echo 'Installing entertainment packages.'
echo
pacman -S rhythmbox omxplayer transmission-cli transmission-gtk
# Installs entertainment tools. 



############ TO DO
# Allot more GPU memory in config.txt files. let's try 128M instead of 64 this time.
# Add in a script to DELETE text from a file
# instead of just haphazardly adding to the end of a file. 




echo 'Auto-installed system tools.'
echo 'Be sure to configure what else you need by yourself.'
echo 'This includes fonts, wifi connections, etc.'
echo 'A restart is necessary.' 
echo 'To install AUR packages or an AUR helper, see the AUR script.'
echo 'To configure additional secondary users, see secondary user setup script.'
