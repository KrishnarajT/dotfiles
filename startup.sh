#!/usr/bin/env bash

# Starting some basic utilities
# picom
# pulseaudio

# # Starting Bluetooth, and autoconnecting it to my usual bluetooth headset
# sudo systemctl enable bluetooth-autoconnect
# systemctl --user enable pulseaudio-bluetooth-autoconnect
# sudo systemctl enable acpid # required by it
# bluetooth-autoconnect # a downloaded utility to autoconnect trusted and paired devices, but may not work all the time

# # doing it the usual system way, but another utility bluez and bluez-utils are required
# sudo systemctl enable bluetooth.service
# rfkill unblock all
# bluetoothctl power on


# unmounting stuff if its mounted first. 
sudo umount /run/media/krishnaraj/Classes /run/media/krishnaraj/Extras /run/media/krishnaraj/Miscellaneous /run/media/krishnaraj/Programs /run/media/krishnaraj/Windows /run/media/krishnaraj/Free

# Making directories, and then mounting drives on them
sudo mount --mkdir /dev/sda6 /run/media/krishnaraj/Programs
sudo mount --mkdir /dev/sda3 /run/media/krishnaraj/Windows
sudo mount --mkdir /dev/sda9 /run/media/krishnaraj/Extras
sudo mount --mkdir /dev/sda8 /run/media/krishnaraj/Classes
sudo mount --mkdir /dev/sdb11 /run/media/krishnaraj/Miscellaneous
sudo mount --mkdir /dev/sdb1 /run/media/krishnaraj/Free




# xinput set-prop "Synaptics TM3336-001" "libinput Tapping Enabled" 1

# # To change the wallpaper
# feh --bg-fill --randomize ~/Pictures/Wallpapers/Minimalist/*

# # Doing recurring things
# while sleep 60;
# do
# bluetooth-autoconnect;
# feh --bg-fill --randomize ~/Pictures/Wallpapers/Minimalist/*;
# bluetoothctl connect A0:60:90:64:D7:2E # connecting to samsung level U
# done
