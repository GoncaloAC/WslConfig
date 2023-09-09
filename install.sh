#!/bin/bash

GREEN="\033[0;32m"
CYAN="\033[0;36m"
ORANGE="\033[0;33m"
NONE="\033[0m"

timer() {
    clear
    secs=4
    while [ $secs -gt 0 ]; do
        echo -ne "${CYAN}$1 ${ORANGE}$secs\033[O\r${NONE}" && sleep 1
        ((secs--))
    done
    echo -e "${CYAN}$1 ${ORANGE}0\033[0K\r${NONE}" && echo -e "${GREEN}$2${NONE}"
}

info() {
    echo -e "${CYAN}$1${NONE}"
}

info "Updating Ubuntu in"

sudo -i apt-get update > /dev/null 2>&1
sudo apt-get upgrade -y > /dev/null 2>&1

timer "Installing JDK 17 in"
echo "sudo apt-get install openjdk-17-jdk -y"
echo >> ~/.bashrc
echo 'export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64' >> ~/.bashrc

timer "Installing JDK 17 Sources in"
sudo apt-get install openjdk-17-source -y

timer "Installing Maven in"
sudo apt install maven -y

timer "Installing Node Version Manager (NVM)"
sudo apt-get install curl
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

timer "Installing GCC in"
sudo apt install gcc -y

timer "Installing Make in"
sudo apt install make

timer "Installing Miniconda"
wget https://repo.anaconda.com/miniconda/Miniconda3-py39_4.12.0-Linux-x86_64.sh
bash Miniconda3-py39_4.12.0-Linux-x86_64.sh
rm Miniconda3-py39_4.12.0-Linux-x86_64.sh

timer "Installing MariaDB in"
sudo apt install mariadb-server