#!/bin/bash

GREEN="\033[0;32m"
CYAN="\033[0;36m"
ORANGE="\033[0;33m"
NONE="\033[0m"

timer() {
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

sudo -i apt-get update
sudo apt-get upgrade -y

timer "Installing JDK 17 in"
sudo apt-get install openjdk-17-jdk -y
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
sudo apt install mariadb-server -y

timer "Installing Apache Cassandra in"
sudo apt install openjdk-8-jre -y
curl https://downloads.apache.org/cassandra/KEYS | sudo apt-key add -
sudo apt-get update
sudo apt-get install cassandra -y
echo 'JAVA_HOME=usr/lib/jvm/java-8-openjdk-amd64' >> ~/usr/share/cassandra/cassandra.in.sh
                    
timer "Installing Redis in"
sudo apt install redis-server -y

timer "Installing Neo4j in"
wget -O - https://debian.neo4j.com/neotechnology.gpg.key | sudo apt-key add -
echo 'deb https://debian.neo4j.com stable latest' | sudo tee -a /etc/apt/sources.list.d/neo4j.list
sudo apt-get update
sudo apt-get install neo4j-enterprise -y

timer "Installing Google Chrome"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt install --fix-broken -y
sudo dpkg -i google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

timer "Installing Mozzila Firefox"
sudo add-apt-repository ppa:mozillateam/ppa
sudo apt install firefox

timer "Installing Microsoft Edge"
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-beta.list'
sudo rm microsoft.gpg
sudo apt update
sudo apt install microsoft-edge-beta
