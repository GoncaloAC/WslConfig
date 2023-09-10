#!/bin/bash

RED="\033[0;31m"
CYAN="\033[0;36m"
NONE="\033[0m"
STOP=" is now stopped."
NOP=" is not installed."

info() {
    echo -e "${CYAN}$1${NONE}"
}

error() {
    echo -e "${RED}$1${NONE}"
}

missing() {
    dpkg -s $1 &> /dev/null
    if [ $? -eq 0 ]; then
        return 1
    else
        return 0
    fi
}

run() {
    if missing "$1"; then 
        error "$2$3"
    else
        $5 > /dev/null 2>&1 && info "$2$4"
    fi
}

run "mariadb-server" "MySQL" "${NOP}" "${STOP}" "sudo service mariadb stop"
run "cassandra" "Apache Cassandra" "${NOP}" "${STOP}" "sudo service cassandra stop"
run "redis-server" "Redis" "${NOP}" "${STOP}" "sudo service redis-server stop"
run "neo4j-enterprise" "Neo4j" "${NOP}" "${STOP}" "sudo service neo4j stop"