#!/usr/bin/env bash

# Not sure if I'm going to use this.

echo
echo "youtube-dl-mp3"
echo "----------------------------------"
echo -n "Copy and paste a youtube link here. > "
read MUSIC
youtube-dl --extract-audio --audio-format mp3 ${MUSIC}
