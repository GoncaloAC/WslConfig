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

source common.sh

CONT="Continuing installtion in"
INST="Installing now"
WARN="This needs further configuration. Check the tutorial Readme.md."

update
sudo -i apt install dialog > /dev/null 2>&1

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
            update && continuing "$CONT" "$INST Java 11"
			sudo apt-get install openjdk-11-jdk
			echo 'export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64' >> ~/.bashrc
			tell 5 "Java 11 installed successfully!"
			;;
		2)
			update && continuing "$CONT" "$INST Java 11 sources"
			sudo apt-get install openjdk-11-source
			tell 5 "Java 11 sources installed successfully!"
			;;
		3)
			update && continuing "$CONT" "$INST Maven"
			sudo apt-get install maven
			tell 5 "Maven installed successfully!"
			;;
		4)
			update && continuing "$CONT" "$INST Node Version Manager (nvm)"
			sudo apt-get install curl
			curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
			tell 0 "NVM installed successfully!"
			warn 5 "$WARN"
			;;
		5) 
			update && continuing "$CONT" "$INST Gcc"
			sudo apt install gcc
			tell 5 "Gcc installed successfully!"
			;;
		6)
			update && continuing "$CONT" "$INST Make"
			sudo apt install make
			tell 5 "Make installed successfully!"
			;;
		7)
			update && continuing "$CONT" "$INST Anaconda"
			wget https://repo.continuum.io/archive/Anaconda3-5.3.1-Linux-x86_64.sh
			bash Anaconda3-5.3.1-Linux-x86_64.sh
			rm Anaconda3-5.3.1-Linux-x86_64.sh
			tell 5 "Anaconda installed successfully!"
			;;
		8)
			update && continuing "$CONT" "$INST MySQL"
			sudo apt install mysql-server
			tell 0 "MySQL installed successfully!"
			warn 5 "$WARN"
			;;
		9)
			update && continuing "$CONT" "$INST PostgresSQL"
			sudo apt install postgresql postgresql-contrib
			tell 0 "PostgresSQL installed successfully!"
			warn 5 "$WARN"
			;;
		10)
			update && continuing "$CONT" "$INST SQLite"
			sudo apt install sqlite3
			tell 5 "SQLite installed successfully!"
			;;
		11)
			update && continuing "$CONT" "$INST Apache Cassandra"
			echo "deb http://downloads.apache.org/cassandra/debian 40x main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list
			curl https://downloads.apache.org/cassandra/KEYS | sudo apt-key add -
			sudo apt-get update
			sudo apt-get install cassandra
			tell 5 "Apache Cassandra installed successfully!"
			;;
		12)
			update && continuing "$CONT" "$INST MongoDB"
			wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -
			echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-5.0.list
			sudo apt-get update
			sudo apt-get install mongodb-org
			mkdir -p ~/data/db
			curl https://raw.githubusercontent.com/mongodb/mongo/master/debian/init.d | sudo tee /etc/init.d/mongodb >/dev/null
			sudo chmod +x /etc/init.d/mongodb
			tell 5 "MongoDB installed successfully!"
			;;
		13) 
			update && continuing "$CONT" "$INST Redis"
			sudo apt install redis-server
			tell 5 "Redis installed successfully!"
			;;
		14)
			update && continuing "$CONT" "$INST Neo4j"
			wget -O - https://debian.neo4j.com/neotechnology.gpg.key | sudo apt-key add -
			echo 'deb https://debian.neo4j.com stable latest' | sudo tee -a /etc/apt/sources.list.d/neo4j.list
			sudo apt-get update
			sudo apt-get install neo4j-enterprise=1:4.4.4
			tell 5 "Neo4j installed successfully!"
			;;
    esac
done

clear
tell 1 "Installation finished successfully!"