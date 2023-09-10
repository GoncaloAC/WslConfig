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

success() {
    echo -e "${GREEN}$1${NONE}"
}

timer "Installing NPM's --lts"
source ~/.nvm/nvm.sh && nvm install --lts
success "NPM configured successfully!"
timer "NPM's --lts installed!"

timer "Configuring MariaDB"
sudo /etc/init.d/mysql start
sudo mysql_secure_installation && sudo mariadb
timer "MariaDB installed!"