#!/bin/bash

RED="\033[0;31m"
YELLOW="\033[1;33m"
GREEN="\033[0;32m"
BLUE="\033[0;34m"
ORANGE="\033[0;33m"
NONE="\033[0m"

update() {
    clear
    echo -e "${BLUE}Updating Ubuntu...${NONE}"
    sudo -i apt-get update > /dev/null 2>&1
    sudo apt-get upgrade -y > /dev/null 2>&1
}

continuing() {
    secs=5
    while [ $secs -gt 0 ]; do
        echo -ne "${BLUE}$1 ${ORANGE}$secs\033[0K\r${NONE}"
        sleep 1
        ((secs--))
    done
    echo -e "${BLUE}$1 ${ORANGE}0\033[0K\r${NONE}"
    echo -e "${GREEN}$2${NONE}"
}

tell() {
    echo -e "${GREEN}$2${NONE}"
    sleep $1
}

warn() {
    echo -e "${YELLOW}$2${NONE}"
    sleep $1
}

error() {
    echo -e "${RED}$2${NONE}"
    sleep $1
}