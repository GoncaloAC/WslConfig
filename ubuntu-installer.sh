#!/bin/bash

RED="\033[0;31m"
YELLOW="\033[1;33m"
GREEN="\033[0;32m"
BLUE="\033[0;34m"
ORANGE="\033[0;33m"
NONE="\033[0m"

countdown() {
	secs=$(($1))
	while [ $secs -gt 0 ]; do
		echo -ne "${BLUE}$2 ${ORANGE}$secs\033[0K\r${NONE}"
		sleep 1
		((secs--))
	done
	echo -e "${BLUE}$3${NONE}"
}

countdown 5 "Starting Ubuntu updates/upgrades in" "Updating/upgrading..."

sudo -i apt-get update > /dev/null
sudo apt-get upgrade -y > /dev/null
sudo -i apt install dialog > /dev/null

cmd=(dialog --separate-output --checklist "Please Select Software you want to install:" 22 76 16)

options=(
	1 "Java 11" off
	2 "Java 11 Sources" off
	3 "Maven" off
	4 "Node Version Manager (nvm)" off
	5 "Gcc" off
	6 "Makefile" off
	7 "Anaconda" off
	8 "Mysql" off
	9 "Apache Cassandra" off
	10 "Neo4j" off
	11 "Redis" off
)

choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)

for choice in $choices
do
	case "${choice}" in
		1)
			countdown 5 "Continuing configuration in" "Installing: ${GREEN}Java 11${NONE}"
			sudo apt-get install openjdk-11-jdk
			;;
		2)
			countdown 5 "Continuing configuration in" "Installing: ${GREEN}Java 11 Sources${NONE}"
			sudo apt-get install openjdk-11-source
			;;
		3)
			countdown 5 "Continuing configuration in" "Installing: ${GREEN}Maven${NONE}"
			sudo apt-get install maven
			;;
		4)
			countdown 5 "Continuing configuration in" "Installing: ${GREEN}Node Version Manager (nvm)${NONE}"
			sudo apt install nodejs
			sudo apt install npm
			;;	
	esac
done	
# https://gist.github.com/bradchesney79/41f711d6dcd4e2ed8925de0f32aab01b
# https://stackoverflow.com/questions/63716587/in-wsl2-ubuntu-20-04-for-windows-10-nodejs-is-installed-but-npm-is-not-working
# https://github.com/lqst/neo4j-wsl2
# https://gist.github.com/waleedahmad/a5b17e73c7daebdd048f823c68d1f57a