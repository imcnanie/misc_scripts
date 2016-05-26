#!/bin/sh

sudo apt-get update && sudo apt-get dist-upgrade
sudo apt-get install git
sudo apt-get install libusb-1.0-0-dev

git clone https://github.com/IntelRealSense/librealsense.git
cd librealsense/

cd ./scripts/
wget https://raw.githubusercontent.com/imcnanie/misc_scripts/master/realsense/install_dependencies-4.4-i386.sh
cd ..

scripts/install_glfw3.sh

sudo cp config/99-realsense-libusb.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules && udevadm trigger

./scripts/install_dependencies-4.4-i386.sh
./scripts/patch-uvcvideo-4.4.sh v4.4-wily

sudo modprobe uvcvideo
sudo dmesg | tail -n 50

#sudo apt-get install qtcreator
#sudo scripts/install_qt.sh

make && sudo make install
#cd ./bin
