#!/bin/bash

echo
echo '-----------------------------------------'
echo 'Uruk Install Script v0.3 by Adam'
echo '-----------------------------------------'
echo
echo 'This is the installation script for Arch Linux, Desktop Install.'
echo 'Run as root.'
wifi-menu



####### USER SETUP
echo
echo '-----------------------------------------'
echo -n "Enter your new desired username > "
read NEWUSER
echo "Username to add: $NEWUSER"
# Asks user for a new user name, and stores the input as a variable.
# This $NEWUSER variable will be used for the rest of the script. 



########### Append user to Sudoers file
echo
echo 'Configuring sudo priviliges.'
# Main User Setup:
useradd -m -G wheel -s /bin/bash ${NEWUSER}
echo '%wheel ALL=(ALL) ALL' >> /etc/sudoers
echo '# Above line appended by Uruk install script.' >> /etc/sudoers
# Allows user to use sudo command.



########### Password Configuration
echo
echo 'Now passwords must be manually configured.'
echo
echo 'Enter the new password for root.'
passwd root
echo
echo "Enter the new password for ${NEWUSER}."
passwd ${NEWUSER}
echo
echo 'Passwords configured.'
echo 'User assigned.'
# Changes the password of the root user and the generated user




######### Hostname Setup
echo
echo -n "Enter your new desired computer hostname (default: sumer) > "
read NEWHOSTNAME
echo "Hostname to add: $NEWHOSTNAME"
hostnamectl set-hostname ${NEWHOSTNAME}
echo
# Ask user for the name of the computer as seen on networks. 
# Default is Sumer




######### Timezone Setup
echo
echo 'Configuring timezone settings.'
echo -n "Enter Zone (Continent) (default: America) > "
read NEWZONE
echo -n "Enter Subzone (City) (default: Denver) > "
read NEWSUBZONE
timedatectl set-timezone ${NEWZONE}/${NEWSUBZONE}
echo "$NEWZONE/$NEWSUBZONE timezone added."
echo
# Ask user for timezones. Default is America/Denver.




########## SYU
echo
echo '-----------------------------------------'
echo 'Updating base system.'
echo
pacman -Syu
echo
# Updates/upgrades system.





########## GNOME and Battery
echo
echo '-----------------------------------------'
echo 'Installing "GNOME" desktop environment.'
echo
pacman -S gnome gnome-keyring gnome-software tlp
#pacman -S gdm
# Gnome standard packages and TLP battery saver.





######## Configuring GNOME
echo 
echo 'Configuring "GNOME" system environment.' 
echo
gsettings set org.gnome.desktop.background show-desktop-icons true
echo 'WaylandEnable=false' >> /etc/gdm/custom.conf
echo '# Above line appended by Sumer install script.' >> /etc/gdm/custom.conf
systemctl enable gdm.service




# This allows use of Xorg to draw desktop icons using nautilus. 
# Allows Gnome to show desk icons, enables GDM Lock Screen.




########## Autoboot to GNOME
echo
echo 'Configured auto-boot to GNOME Desktop.'
echo
echo 'exec gnome-session' >> /home/${NEWUSER}/.xinitrc
echo '# Above comment appended by Uruk install script.' >> /home/${NEWUSER}/.xinitrc
echo 'exec startx' >> /home/${NEWUSER}/.bash_profile
echo '# Above comment appended by Uruk install script.' >> /home/${NEWUSER}/.bash_profile
# Enables GNOME and X to start at boot. 




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
echo '-----------------------------------------'
echo 'Installing programming tools.'
echo
pacman -S git base-devel wget gvfs gamin bash-completion tk python3 python2 pluma gparted eric dosfstools conky


touch /home/${NEWUSER}/.xprofile
cp conky-visor.txt /home/${NEWUSER}/.config/conky/conky.conf
echo 'conky' >> /home/${NEWUSER}/.xprofile
# copies all relevant things into conky.conf, autostarts at system login
# Installs basic programming tools to your liking.



########## Network Tools
echo
echo '-----------------------------------------'
echo 'Installing network tools.'
echo
pacman -S iw wpa_supplicant dialog
pacman -S networkmanager network-manager-applet dnsmasq networkmanager-openvpn openvpn
pacman -S transmission-cli transmission-gtk chromium gparted
# Installs network tools.


########### Configuring Network Tools
echo
echo 'Configuring network tools.'
systemctl enable NetworkManager.service
systemctl enable wpa_supplicant.service
gpasswd -a ${NEWUSER} network
# Configures network tools. 



########## File Processing Tools
echo
echo '-----------------------------------------'
echo 'Installing file processing tools.'
echo
pacman -S gimp libreoffice-fresh




########## Entertainment
echo
echo '-----------------------------------------'
echo 'Installing entertainment and bluetooth packages.'
echo
pacman -S rhythmbox transmission-cli transmission-gtk kodi
pacman -S bluez bluez-utils pulseaudio-bluetooth
systemctl enable bluetooth.service
# Installs entertainment tools.
# Installs bluetooth




echo
echo '-----------------------------------------'
echo 'Auto-installed system tools.'
echo 'Be sure to configure what else you need by yourself.'
echo 'This includes fonts, wifi connections, etc.'
echo 'A restart is necessary.' 
echo 'To install AUR packages or an AUR helper, see the AUR script.'
echo 'To configure additional secondary users, see secondary user setup script.'
echo 'Configure backlight, enable multilib in pacman for steam and wine.' 
echo '-----------------------------------------'
echo

