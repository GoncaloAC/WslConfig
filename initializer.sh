#!/bin/bash

: '
	@Author: Gonçalo Condeço - https://github.com/GoncaloAC
'

RED="\033[0;31m"
YELLOW="\033[1;33m"
GREEN="\033[0;32m"
BLUE="\033[0;34m"
ORANGE="\033[0;33m"
NONE="\033[0m"

tell() {
    echo -e "${GREEN}$1${NONE}"
}

error() {
    echo -e "${RED}$1${NONE}"
}

if type mysql >/dev/null 2>&1
    then
        sudo /etc/init.d/mysql start > /dev/null 2>&1
        tell "MySQL is now running."
    else
        error "MySQL is not installed."
fi

if type postgresql >/dev/null 2>&1
    then 
        sudo service postgresql start
        tell "PostgresSQL is now running."
    else
        error "PostgresSQL is not installed."
fi

if type mongo >/dev/null 2>&1
    then
        sudo service mongodb start > /dev/null 2>&1
        tell "MongoDB is now running."
    else
        error "MongoDB is not installed."
fi

if redis-server -v >/dev/null 2>&1
    then
        sudo service redis-server start > /dev/null 2>&1
        tell "Redis is now running."
    else
        error "Redis is not installed."
fi

if type cassandra >/dev/null 2>&1
    then
        sudo service cassandra start > /dev/null 2>&1
        tell "Apache Cassandra is now running."
    else
        error "Apache Cassandra is not installed."
fi

if type neo4j >/dev/null 2>&1
    then
        sudo service neo4j start > /dev/null 2>&1
        tell "Neo4j is now running."
    else
        error "Neo4j is not installed."
fi