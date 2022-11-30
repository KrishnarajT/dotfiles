#!/bin/bash
echo "connecting to bluetooth device Samsung Level U2"
sudo systemctl stop bluetooth.service
sudo systemctl start bluetooth.service
bluetoothctl power on
bluetoothctl connect 6C:14:14:B9:93:04
echo "exiting"
