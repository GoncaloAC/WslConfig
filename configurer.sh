#!/bin/bash

: '
	@Author: Gonçalo Condeço - https://github.com/GoncaloAC

	Credits - As I wrote this file, some installers were taken from tutorials.

	MySQL - https://docs.microsoft.com/en-us/windows/wsl/tutorials/wsl-database#install-mysql
	PostgresSQL - https://docs.microsoft.com/en-us/windows/wsl/tutorials/wsl-database#install-postgresql
'

source common.sh

CONT="Continuing configuration in"
INST="Configuring now "
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
            tell 5 "NPM configured successfully!"
            ;;
        2)
            clear && continuing "$CONT" "$INST MySQL"
            sudo /etc/init.d/mysql start
            sudo mysql_secure_installation
            sudo mysql
            tell 5 "MySQL configured successfully!"
            ;;
        3)
            clear && continuing "$CONT" "$INST PostgresSQL"
            sudo passwd postgres
            tell 5 "PostgresSQL configured successfully!"
            ;;
    esac
done

clear
tell 1 "Configuration finished successfully!"