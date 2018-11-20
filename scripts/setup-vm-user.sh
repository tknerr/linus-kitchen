#!/bin/bash

LOGIN_USER=$1
LOGIN_PASS=$2

# create the login user if it does not already exist
if getent passwd $LOGIN_USER >/dev/null; then
  echo "Login User '$LOGIN_USER' already created..."
  exit 0
fi

# create user, set password and add it to the usual groups
adduser $LOGIN_USER --gecos "" --home "/home/$LOGIN_USER" --disabled-password
echo "$LOGIN_USER:$LOGIN_PASS" | chpasswd
usermod -a -G adm,cdrom,sudo,dip,plugdev,lpadmin,sambashare $LOGIN_USER

# ensure the new user can do passwordless sudo
echo "$LOGIN_USER ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/$LOGIN_USER

# set the new user as the default in the login screen and end the current (vagrant) user's gnome session
mkdir -p /etc/gdm3
> /etc/gdm3/custom.conf
echo "[daemon]" >> /etc/gdm3/custom.conf
echo "# Enabling automatic login" >> /etc/gdm3/custom.conf
echo "AutomaticLoginEnable = true" >> /etc/gdm3/custom.conf
echo "AutomaticLogin = $LOGIN_USER" >> /etc/gdm3/custom.conf

if [[ $(which gnome-session) ]]; then
  systemctl restart display-manager
fi