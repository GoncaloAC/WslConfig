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
timer "JDK 17 installed successfully!"

timer "Installing JDK 17 Sources in"
sudo apt-get install openjdk-17-source -y
timer "JDK 17 Sources installed successfully!"

timer "Installing Maven in"
sudo apt install maven -y
timer "Maven installed successfully!"

timer "Installing Node Version Manager (NVM)"
sudo apt-get install curl
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
timer "Node Version Manager (NVM) installed successfully!"

timer "Installing GCC in"
sudo apt install gcc -y
timer "GCC installed successfully!"

timer "Installing Make in"
sudo apt install make
timer "Make installed successfully!"

timer "Installing Miniconda"
wget https://repo.anaconda.com/miniconda/Miniconda3-py39_4.12.0-Linux-x86_64.sh
bash Miniconda3-py39_4.12.0-Linux-x86_64.sh
rm Miniconda3-py39_4.12.0-Linux-x86_64.sh
timer "Miniconda installed successfully!"

timer "Installing MariaDB in"
sudo apt install mariadb-server -y
timer "MariaDB installed successfully!"

timer "Installing Apache Cassandra in"
sudo apt install openjdk-8-jre -y
sudo sh -c 'echo "deb https://debian.cassandra.apache.org 311x main" > /etc/apt/sources.list.d/cassandra.sources.list'
curl https://downloads.apache.org/cassandra/KEYS | sudo apt-key add -
sudo apt-get update
sudo apt-get install cassandra -y
sudo chmod -R a+w /usr/share/cassandra/
echo 'JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64' >> /usr/share/cassandra/cassandra.in.sh
timer "Apache Cassandra installed successfully!"
                    
timer "Installing Redis in"
sudo apt install redis-server -y
timer "Redis installed successfully!"

timer "Installing Neo4j in"
wget -O - https://debian.neo4j.com/neotechnology.gpg.key | sudo apt-key add -
echo 'deb https://debian.neo4j.com stable latest' | sudo tee -a /etc/apt/sources.list.d/neo4j.list
sudo apt-get update
sudo apt-get install neo4j-enterprise -y
timer "Neo4j installed successfully!"

timer "Installing Google Chrome"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt install --fix-broken -y
sudo dpkg -i google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb
timer "Google Chrome installed successfully!"

timer "Installing Mozzila Firefox"
sudo add-apt-repository ppa:mozillateam/ppa
sudo apt install firefox
timer "Mozzila Firefox installed successfully!"

timer "Installing Microsoft Edge"
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-beta.list'
sudo rm microsoft.gpg
sudo apt update
sudo apt install microsoft-edge-beta
timer "Microsoft Edge installed successfully!"

timer "Installing the scripts now..."
