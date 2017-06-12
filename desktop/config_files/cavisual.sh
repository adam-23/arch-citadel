#!/bin/bash
xfce4-terminal -e cava --hide-borders --hide-toolbar --hide-menubar \
--title=desktopconsole --geometry=30x10+1614+838 &
sleep 0.3
wmctrl -r desktopconsole -b add,below,sticky
wmctrl -r desktopconsole -b add,skip_taskbar,skip_pager
# Was designed for a 1920 x 1080 16:9 ratio screen.
# Refactor this for handy programs?
