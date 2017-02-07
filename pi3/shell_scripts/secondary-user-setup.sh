echo 'Secondary User Setup Script v0.2 by Adam'
echo '-----------------------------------------'
echo
echo 'This adds a new secondary user to the sudoers file.'
echo 'Must be run with root.'
echo 'Only works if system is already installed.'


############## Ask for User Input
echo
echo -n "Enter your new desired username > "
read NEWUSER
echo "Username to add: $NEWUSER"
# Asks user for a new user name, and stores the input as a variable.
# This $NEWUSER variable will be used for the rest of the script. 
# Must be run as root.



############ Add to sudoers file
echo 'Configuring sudo priviliges.'
# Main User Setup:
useradd -m -G wheel -s /bin/bash $NEWUSER
# Allows user to use sudo command.



############ New user password setup
echo
echo 'Enter the new password for the new user.'
passwd $NEWUSER
echo
echo 'Password configured.'



########## Autoboot to XFCE
echo
echo 'Configured auto-boot to XFCE Desktop.'
echo
echo 'exec startxfce4' >> /home/$NEWUSER/.xinitrc
echo '# Above comment appended by Konosos install script.' >> /home/$NEWUSER/.xinitrc
echo 'exec startx' >> /home/$NEWUSER/.bash_profile
echo '# Above comment appended by Konosos install script.' >> /home/$NEWUSER/.bash_profile
gpasswd -a $NEWUSER network
# Enables XFCE and X to start at boot, adds user to network group. 



echo "New user $NEWUSER is ready."

