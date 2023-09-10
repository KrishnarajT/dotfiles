#!/usr/bin/env bash
echo "Download $(xclip -o)"
wget --directory-prefix=/home/krishnaraj/Downloads/ $(xclip -o)
