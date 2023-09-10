#!/bin/bash

success() {
    echo -e "${GREEN}$1${NONE}"
}

mkdir -p ~/.scripts/
cp ./install.sh ~/.scripts/install.sh
cp ./config.sh ~/.scripts/config.sh
cp ./start.sh ~/.scripts/start.sh
cp ./stop.sh ~/.scripts/stop.sh

success "Scripts copied successfully!"

chmod u+x ~/.scripts/install.sh
chmod u+x ~/.scripts/config.sh
chmod u+x ~/.scripts/start.sh
chmod u+x ~/.scripts/stop.sh

sed -i 's/\r$//' ~/.scripts/install.sh
sed -i 's/\r$//' ~/.scripts/config.sh
sed -i 's/\r$//' ~/.scripts/start.sh
sed -i 's/\r$//' ~/.scripts/stop.sh

success "Executable permissions assigned to scripts!"

echo >>  ~/.bashrc
echo "alias install='~/.scripts/install.sh'" >> ~/.bashrc
echo "alias config='~/.scripts/config.sh'" >> ~/.bashrc
echo "alias start='~/.scripts/start.sh'" >> ~/.bashrc
echo "alias stop='~/.scripts/stop.sh'" >> ~/.bashrc
source ~/.bashrc

success "Scripts successfully configured!"