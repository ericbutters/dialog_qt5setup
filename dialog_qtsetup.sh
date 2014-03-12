#!/bin/bash

BT="Qt5 - SETUP SUBMODULES"

dialog --title "Input Test" --backtitle "$BT" \
       --inputbox "Enter your name please" 8 60 2>/tmp/input.$$

sel=$?
na=`cat /tmp/input.$$`

case $sel in
    0) echo "Hello $na" ;;
    1) echo "Cancel is Press" ;;
    255) echo "[ESCAPE] key pressed" ;;
esac

rm -f /tmp/input.$$
#sleep 2

version=$(dialog --title "Qt5 Version" --backtitle "$BT" \
             --radiolist "choose version" 15 50 8 \
       Qt-5.0.2 "" off \
       Qt-5.1.0 "" on \
       Qt-5.2.0 "" off \
       2>&1 >/dev/tty )

QT_VERSION=$(echo $version | cut -d- -f2)
QT_MAJOR=$(echo $QT_VERSION | cut -d. -f1,2)

cd /tmp
QT_ARCHIVE=qt-everywhere-opensource-src-$QT_VERSION.tar.gz
URL="http://ftp.fau.de/qtproject/archive/qt/$QT_MAJOR/$QT_VERSION/single/$QT_ARCHIVE"
wget "$URL" 2>&1 | \
 stdbuf -o0 awk '/[.] +[0-9][0-9]?[0-9]?%/ { print substr($0,63,3) }' | \
 dialog --title "WGET" --backtitle "$BT" \
        --gauge "downloading $QT_ARCHIVE" 10 100
 
(pv -n $QT_ARCHIVE | tar xz -C /tmp ) 2>&1 | \
 dialog --title "TAR" --backtitle "$BT" \
        --gauge "extracting $QT_ARCHIVE" 10 100
