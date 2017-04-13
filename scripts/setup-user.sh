#!/bin/bash

LOGIN_USER=$1
LOGIN_PASS=$2

# create the login user if it does not already exist
if getent passwd $LOGIN_USER >/dev/null; then
  echo "Login User '$LOGIN_USER' already created..."
else
  # create user, set password and add it to the usual groups
  adduser $LOGIN_USER --gecos "" --home "/home/$LOGIN_USER" --disabled-password
  echo "$LOGIN_USER:$LOGIN_PASS" | chpasswd
  usermod -a -G adm,cdrom,sudo,dip,plugdev,lpadmin,sambashare $LOGIN_USER

  # ensure the new user can do passwordless sudo
  echo "$LOGIN_USER ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/$LOGIN_USER

  # set the new user as the default in the login screen and lock the current (vagrant user's) screen session
  echo -e "[SeatDefaults]\nautologin-user=$LOGIN_USER" | sudo tee /etc/lightdm/lightdm.conf
  XDG_SEAT_PATH=/org/freedesktop/DisplayManager/Seat0 dm-tool lock
fi
