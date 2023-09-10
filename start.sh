#!/bin/bash

RED="\033[0;31m"
CYAN="\033[0;36m"
NONE="\033[0m"
RUN=" is now running."
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

run "mariadb-server" "Mariadb" "${NOP}" "${RUN}" "sudo service mariadb start"
run "cassandra" "Apache Cassandra" "${NOP}" "${RUN}" "sudo service cassandra start"
run "redis-server" "Redis" "${NOP}" "${RUN}" "sudo service redis-server start"
run "neo4j-enterprise" "Neo4j" "${NOP}" "${RUN}" "sudo service neo4j start"