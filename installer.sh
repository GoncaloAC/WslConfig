#!/bin/bash

: '
	@Author: Gonçalo Condeço - https://github.com/GoncaloAC

	Credits - As I wrote this file, some installers were taken from tutorials.

	MySQL - https://docs.microsoft.com/en-us/windows/wsl/tutorials/wsl-database#install-mysql
	PostgresSQL - https://docs.microsoft.com/en-us/windows/wsl/tutorials/wsl-database#install-postgresql
	SQLite - https://docs.microsoft.com/en-us/windows/wsl/tutorials/wsl-database#install-sqlite
	Apache Cassandra - https://www.varunsrivatsa.dev/blog/cassandra-installation/how-to-install-cassandra-4-on-windows/
	MongoDB - https://docs.microsoft.com/en-us/windows/wsl/tutorials/wsl-database#install-mongodb
	Redis - https://docs.microsoft.com/en-us/windows/wsl/tutorials/wsl-database#install-redis
	Neo4j - https://github.com/lqst/neo4j-wsl2
'

RED="\033[0;31m"
YELLOW="\033[1;33m"
GREEN="\033[0;32m"
BLUE="\033[0;34m"
ORANGE="\033[0;33m"
NONE="\033[0m"
CONT="Continuing configuration in"
INST="Installing: "

countdown() {
	clear
	echo -e "${BLUE}Updating the System...${NONE}"
	sudo -i apt-get update > /dev/null
	sudo apt-get upgrade -y > /dev/null
	secs=5
	while [ $secs -gt 0 ]; do
		echo -ne "${BLUE}$1 ${ORANGE}$secs\033[0K\r${NONE}"
		sleep 1
		((secs--))
	done
	echo -e ""
	echo -e "${BLUE}$2${NONE}"
	sleep 4
}

warn() {
	echo -e "${RED}This needs further configuration. Check the tutorial Readme-md.${NONE}"
	sleep 4
}

sudo -i apt-get update
sudo apt-get upgrade -y
sudo -i apt install dialog

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
	9 "PostgresSQL" off
	10 "SQLite" off
	11 "Apache Cassandra" off
	12 "MongoDB" off
	13 "Redis" off
	14 "Neo4j" off
)

choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $choices
do
	case "${choice}" in
		1)
			countdown "$CONT" "$INST${GREEN}Java 11${NONE}"
			sudo apt-get install openjdk-11-jdk
			;;
		2)
			countdown "$CONT" "$INST${GREEN}Java 11 Sources${NONE}"
			sudo apt-get install openjdk-11-source
			;;
		3)
			countdown "$CONT" "$INST${GREEN}Maven${NONE}"
			sudo apt-get install maven
			;;
		4)
			countdown "$CONT" "$INST${GREEN}Node Version Manager (nvm)${NONE}"
			sudo apt-get install curl
			curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
			warn
			;;
		5) 
			countdown "$CONT" "$INST${GREEN}Gcc${NONE}"
			sudo apt install gcc
			;;
		6)
			countdown "$CONT" "$INST${GREEN}Make${NONE}"
			sudo apt install make
			;;
		7)
			countdown "$CONT" "$INST${GREEN}Anaconda${NONE}"
			wget https://repo.continuum.io/archive/Anaconda3-5.3.1-Linux-x86_64.sh
			bash Anaconda3-5.3.1-Linux-x86_64.sh
			;;
		8) 
			countdown "$CONT" "$INST${GREEN}MySQL${NONE}"
			sudo apt install mysql-server
			warn
			;;
		9) 
			countdown "$CONT" "$INST${GREEN}PostgresSQL${NONE}"
			sudo apt install postgresql postgresql-contrib
			warn
			;;
		10)\
			countdown "$CONT" "$INST${GREEN}SQLite${NONE}"
			sudo apt install sqlite3
			;;
		11)
			countdown "$CONT" "$INST${GREEN}Apache Cassandra${NONE}"
			echo "deb http://downloads.apache.org/cassandra/debian 40x main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list
			curl https://downloads.apache.org/cassandra/KEYS | sudo apt-key add -
			sudo apt-get update
			sudo apt-get install cassandra
			warn
			;;
		12) 
			countdown "$CONT" "$INST${GREEN}MongoDB${NONE}"
			wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -
			echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-5.0.list
			sudo apt-get update
			sudo apt-get install mongodb-org
			mkdir -p ~/data/db
			curl https://raw.githubusercontent.com/mongodb/mongo/master/debian/init.d | sudo tee /etc/init.d/mongodb >/dev/null
			sudo chmod +x /etc/init.d/mongodb
			warn
			;;
		13)
			countdown "$CONT" "$INST${GREEN}Redis${NONE}"
			sudo apt install redis-server
			;;
		14)
			countdown "$CONT" "$INST${GREEN}Neo4j${NONE}"
			wget -O - https://debian.neo4j.com/neotechnology.gpg.key | sudo apt-key add -
			echo 'deb https://debian.neo4j.com stable latest' | sudo tee -a /etc/apt/sources.list.d/neo4j.list
			sudo apt-get update
			sudo apt-get install neo4j-enterprise=1:4.4.4
			;;
	esac
done

echo -e "${GREEN}Installation finished!${NONE}"