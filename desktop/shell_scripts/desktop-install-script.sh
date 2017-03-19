#!/bin/bash
####### Opening Announcement
echo
echo "-----------------------------------------"
echo "Athens Install Script v0.5 by Adam"
echo "-----------------------------------------"
echo
echo "This is the installation script for Arch Linux, Desktop Install."
echo "Run as root."



echo "Connect to wifi or ethernet."
wifi-menu
# Pulls up wifi connectivity options.



####### USER SETUP
echo
echo "-----------------------------------------"
echo "A new user will be created as the main user."
echo
echo -n "New username needed. If ready, type yes > "
read NAMEGATE
while [ ${NAMEGATE} != "yes" ]
do
echo "You didn't type yes."
echo
echo -n "New password. If ready, type yes > "
read NAMEGATE
done
if [ ${NAMEGATE} == "yes" ]
    then
    echo -n "Enter your new desired username > "
    read NEWUSER
fi
echo "Username to add: $NEWUSER"
# Asks user for a new user name, and stores the input as a variable.
# This $NEWUSER variable will be used for the rest of the script.



########### Append user to Sudoers file
echo
echo "Configuring sudo priviliges."
# Main User Setup:
useradd -m -G wheel -s /bin/bash ${NEWUSER}
echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers
echo "# Above line appended by Athens install script." >> /etc/sudoers
# Allows user to use sudo command.



########### Password Configuration
echo
echo "Now passwords must be manually configured."
echo
echo -n "New root password needed. If ready, type yes > "
read ROOTGATE
while [ ${ROOTGATE} != "yes" ]
do
echo "You didn't type yes."
echo
echo -n "New root password needed. If ready, type yes > "
read ROOTGATE
done
if [ ${ROOTGATE} == "yes" ]
    then
    echo "Enter the new password for root."
    passwd root
fi
# Use a gate to accept root password.
echo -n "New main user password needed. If ready, type yes > "
read USERGATE
while [ ${USERGATE} != "yes" ]
do
echo "You didn't type yes."
echo
echo -n "${NEWUSER} password needed. If ready, type yes > "
read USERGATE
done
if [ ${USERGATE} == "yes" ]
    then
    echo "Enter password for ${NEWUSER}."
    passwd ${NEWUSER}
fi
# Use a gate to accept user password.
echo
echo "Passwords configured."
echo "$NEWUSER password assigned."
# Changes the password of the root user and the generated user



######### Hostname Setup
echo
echo -n "Enter your new desired computer hostname (default: ellas) > "
read NEWHOSTNAME
echo "Hostname to add: $NEWHOSTNAME"
hostnamectl set-hostname ${NEWHOSTNAME}
echo
# Ask user for the name of the computer as seen on networks.
# Default is ellas



######### Timezone/Locale Setup
echo
echo "Configuring timezone settings."
echo -n "Enter Zone (Continent) (default: America) > "
read NEWZONE
echo -n "Enter Subzone (City) (default: Denver) > "
read NEWSUBZONE
timedatectl set-timezone ${NEWZONE}/${NEWSUBZONE}
echo "$NEWZONE/$NEWSUBZONE timezone added."
echo
echo "Running clock sync."
hwclock --systohc
echo "Adding US Locale."
echo "If you want to recongifure this, the file is /etc/locale.gen"
locale-gen
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "# Above code added by Athens install script." >> /etc/locale.gen
# Also added in locale.conf
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "# Above code added by Athens install script." >> /etc/locale.conf
# Ask user for timezones. Default is America/Denver.
# Run clock sync.
# Run locale-gen



########## SYU
echo
echo "-----------------------------------------"
echo "Updating base system."
echo
pacman -Syu
echo
# Updates/upgrades system.



########## GNOME and Battery
echo
echo "-----------------------------------------"
echo "Installing "GNOME" desktop environment."
echo
pacman -S gnome gnome-keyring gnome-software tlp xfce4-terminal gdm
# Gnome standard packages and TLP battery saver.



######## Configuring GNOME
echo
echo "Configuring "GNOME" system environment."
echo
# gsettings set org.gnome.desktop.background show-desktop-icons true
# As of posting my theme on unixporn I've decided to forgo this because the default icons look ugly
echo "WaylandEnable=false" >> /etc/gdm/custom.conf
echo "# Above line appended by Athens install script." >> /etc/gdm/custom.conf
systemctl enable gdm.service
pacman -Rs evolution
# Removed evolution because I hate it.
# This allows use of Xorg to draw desktop icons using nautilus.
###### Removed this functionality because the default ones look ugly, but I'm keeping the code in just in case.
###### Can be undone using the Gnome Tweak Tool
# Allows Gnome to show desk icons, enables GDM Lock Screen.



########## Autoboot to GNOME
echo
echo "Configured auto-boot to GNOME Desktop."
echo
echo "exec gnome-session" >> /home/${NEWUSER}/.xinitrc
echo "# Above comment appended by Athens install script." >> /home/${NEWUSER}/.xinitrc
echo "exec startx" >> /home/${NEWUSER}/.bash_profile
echo "# Above comment appended by Athens install script." >> /home/${NEWUSER}/.bash_profile
# Might technically be defunct because gdm is being used. Will have to test later.
# Enables GNOME and X to start at boot.




########## Enable TLP (Battery)
echo
echo "Configuring battery life saver."
echo
systemctl enable tlp.service
systemctl enable tlp-sleep.service
systemctl disable systemd-rfkill.service
# Enables and configures TLP battery saver.



######### Programming Tools
echo
echo "-----------------------------------------"
echo "Installing programming tools."
echo
pacman -S git base-devel wget gvfs gamin bash-completion tk python3 python2 gparted dosfstools conky atom
touch /home/${NEWUSER}/.xprofile
cp /../config_files/conky-visor.txt /home/${NEWUSER}/.config/conky/conky.conf
echo "conky" >> /home/${NEWUSER}/.xprofile
# Copies all relevant things into conky.conf, conky autostarts at system login
git config --global core.editor nano
# Makes git's default editor as nano, not emacs.
# Installs basic programming tools.


####### Install Atom packages in $NEWUSER home directory
su $NEWUSER
apm install minimap git-diff highlight-line symbols-tree-view script
# minimap, git differentiation, highlights the current line you're on, show symbols in tree view, run scripts.
apm install linter linter-ui-default  busy-signals intentions tablr atom-save-all
# General base for installing syntax highlighters, tablr for CSV/TSV, save all windows at once.
apm install linter-pylama magicpython
# python syntax-highlighting
apm install open-in-browser open-in-browsers linter-tidy
exit
# Installs desired Atom packages.




########## Network Tools
echo
echo "-----------------------------------------"
echo "Installing network tools."
echo
pacman -S iw wpa_supplicant dialog
pacman -S networkmanager network-manager-applet dnsmasq networkmanager-openvpn openvpn
pacman -S transmission-cli transmission-gtk chromium
# Installs network tools.



########### Configuring Network Tools
echo
echo "Configuring network tools."
systemctl enable NetworkManager.service
systemctl enable wpa_supplicant.service
gpasswd -a ${NEWUSER} network
# Configures network tools.



########## File Processing Tools
echo
echo "-----------------------------------------"
echo "Installing file processing tools."
echo
pacman -S gimp libreoffice-fresh



########## Entertainment
echo
echo "-----------------------------------------"
echo "Installing entertainment and bluetooth packages."
echo
pacman -S kodi youtube-dl retroarch
#
pacman -S bluez bluez-utils pulseaudio-bluetooth
systemctl enable bluetooth.service
# Installs entertainment tools.
# Installs bluetooth



########## Final Comment
echo
echo "-----------------------------------------"
echo "Auto-installed system tools."
echo "Full desktop has been configured."
echo "A restart is necessary."
echo "To install AUR packages or an AUR helper, see the AUR script."
echo "-----------------------------------------"
echo
echo "Arch Linux is the best!"
