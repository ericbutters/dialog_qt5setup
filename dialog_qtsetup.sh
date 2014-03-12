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


cd /tmp
QT_VERSION="5.0.2"
QT_ARCHIVE=qt-everywhere-opensource-src-$QT_VERSION.tar.gz
URL="http://ftp.fau.de/qtproject/archive/qt/5.0/$QT_VERSION/single/$QT_ARCHIVE"
wget "$URL" 2>&1 | \
 stdbuf -o0 awk '/[.] +[0-9][0-9]?[0-9]?%/ { print substr($0,63,3) }' | \
 dialog --gauge "downloading $QT_ARCHIVE" 10 100
 
(pv -n qt-everywhere-opensource-src-5.0.2.tar.gz | tar xz -C /tmp ) \
2>&1 | dialog --title "Extract Test" --backtitle "$BT" \
              --gauge "extracting $QT_ARCHIVE" 10 100
