#!/bin/bash

: '
	@Author: Gonçalo Condeço - https://github.com/GoncaloAC

	Credits - As I wrote this file, some installers were taken from tutorials.

	MySQL - https://docs.microsoft.com/en-us/windows/wsl/tutorials/wsl-database#install-mysql
	PostgresSQL - https://docs.microsoft.com/en-us/windows/wsl/tutorials/wsl-database#install-postgresql
'
RED="\033[0;31m"
YELLOW="\033[1;33m"
GREEN="\033[0;32m"
BLUE="\033[0;34m"
ORANGE="\033[0;33m"
NONE="\033[0m"
CONT="Continuing configuration in"
INST="Configuring now "

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
    echo -e "${GREEN}$1${NONE}"
    sleep 5
}

sudo -i apt install dialog
cmd=(dialog --separate-output --checklist "Please Select Software you want to configure:" 22 76 16)

options=(
    1 "Install latest stable npm with nvm" off
    2 "Configure MySQL for WSL" off
    3 "Configure PostgresSQL for WSL" off
)

choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $choices
do
    case "${choice}" in
        1)
            clear && continuing "$CONT" "$INST NPM"
            source ~/.nvm/nvm.sh
            nvm install --lts
            tell "NPM configured successfully!"
            ;;
        2)
            clear && continuing "$CONT" "$INST MySQL"
            sudo /etc/init.d/mysql start
            sudo mysql_secure_installation
            sudo mysql
            tell "MySQL configured successfully!"
            ;;
        3)
            clear && continuing "$CONT" "$INST PostgresSQL"
            sudo passwd postgres
            tell "PostgresSQL configured successfully!"
            ;;
    esac
done

clear
tell "Configuration finished successfully!"