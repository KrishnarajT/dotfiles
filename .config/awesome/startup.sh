#!/usr/bin/env bash

# Starting some basic utilities
source /home/krishnaraj/.config/awesome/monitor_setup.sh
flameshot &
picom --experimental-backends &
pulseaudio &
brave &
alacritty &

# Starting Bluetooth, and autoconnecting it to my usual bluetooth headset
sudo systemctl enable bluetooth-autoconnect
systemctl --user enable pulseaudio-bluetooth-autoconnect
sudo systemctl enable acpid # required by it
bluetooth-autoconnect & # a downloaded utility to autoconnect trusted and paired devices, but may not work all the time

# # doing it the usual system way, but another utility bluez and bluez-utils are required
sudo systemctl enable bluetooth.service
rfkill unblock all
bluetoothctl power on

# Making directories, and then mounting drives on them
sudo mkdir /run/media/krishnaraj
sudo mkdir /run/media/krishnaraj/Extras
sudo mkdir /run/media/krishnaraj/Windows
sudo mkdir /run/media/krishnaraj/Photos
sudo mkdir /run/media/krishnaraj/Miscellaneous
sudo mkdir /run/media/krishnaraj/Classes
sudo mount /dev/sda3 /run/media/krishnaraj/Windows
sudo mount /dev/sda5 /run/media/krishnaraj/Extras
sudo mount /dev/sda10 /run/media/krishnaraj/Photos
sudo mount /dev/sda11 /run/media/krishnaraj/Miscellaneous
sudo mount /dev/sda6 /run/media/krishnaraj/Classes
sudo chmod ugo+wx /run/media/krishnaraj/Extras

xinput set-prop "Synaptics TM3336-001" "libinput Tapping Enabled" 1

# To change the wallpaper
feh --bg-fill --randomize ~/Pictures/Wallpapers/Nature/*

# Doing recurring things
while sleep 60;
do
bluetooth-autoconnect &
feh --bg-fill --randomize ~/Pictures/Wallpapers/Nature/*;
bluetoothctl connect 00:00:AB:CD:3C:8D # connecting to Airdopes
done
