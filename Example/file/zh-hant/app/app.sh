#!/bin/bash
clear
echo -e "\e[1m\e[93m〔----- # Application Name # -----〕\e[0m"
echo "
----- # Application Introduction and Help # -----"

# The dividing line
echo "----------------------------------------"

# Official Website:
# https://example.com/
echo "Official Website and Developer Help"
echo -e "\e[1m\e[93m
Which operations do you want to perform:
\e[0m"
echo "1. Install"
echo "2. Update"
echo "3. Uninstall"
echo -e "\e[1m\e[31m4. Uninstall and erase all data\e[0m"
echo "5. View Version"
echo -e "\e[1m\e[32m0. Back\e[0m"

read -p "Please input:" choice

case $choice in
  1)
    echo -e "\e[1m\e[34mY. Confirm install\e[0m"
    echo -e "\e[1m\e[31mN. Cancel install\e[0m"
    read -p "Please input:" yn_choice
    ;;
  2)
    sudo apt-get update -y && sudo apt-get upgrade docker-ce -y && sudo apt-get upgrade docker-compose -y
    read -n 1 -p "Press any key to continue."
    sudo ./xray-zh-hant-docker.sh
    ;;
  3)
    echo -e "\e[1m\e[34mY. Confirm uninstall\e[0m"
    echo -e "\e[1m\e[31mN. Cancel uninstall\e[0m"
    read -p "Please input:" yn2_choice
    ;;
  4)
    echo -e "\e[1m\e[34mY. Confirm uninstall\e[0m"
    echo -e "\e[1m\e[31mN. Cancel uninstall\e[0m"
    read -p "Please input:" yn3_choice
    ;;
  5)
    docker --version
    docker-compose --version
    read -n 1 -p "Press any key to continue."
    sudo ./app.sh
    ;;
  0)
    sudo ./app.sh
    ;;
  *)
    echo -e "\e[1m\e[31mError: Ineffective choices\e[0m"
    read -n 1 -p "Press any key to return to the menu."
    sudo ./app.sh
    ;;
esac

case $yn_choice in
  Y)
    sudo apt update -y && apt full-upgrade -y && apt upgrade -y && apt autoremove -y && apt autoclean -y
    curl -fsSL https://get.docker.com | sh
    curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose

    read -n 1 -p "Press any key to continue."
    sudo ./app.sh
    ;;
  y)
    sudo apt update -y && apt full-upgrade -y && apt upgrade -y && apt autoremove -y && apt autoclean -y
    curl -fsSL https://get.docker.com | sh
    curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose

    read -n 1 -p "Press any key to continue."
    sudo ./app.sh
    ;;
  N)
    sudo ./app.sh
    ;;
  n)
    sudo ./app.sh
    ;;
esac
  
case $yn2_choice in
  Y)
    sudo apt-get remove docker -y
    sudo apt-get remove docker-ce -y
    sudo apt-get purge docker-ce -y
    sudo rm -rf /var/lib/docker
    sudo rm /usr/local/bin/docker-compose

    read -n 1 -p "Press any key to continue."
    sudo ./app.sh
    ;;
  y)
    sudo apt-get remove docker -y
    sudo apt-get remove docker-ce -y
    sudo apt-get purge docker-ce -y
    sudo rm -rf /var/lib/docker
    sudo rm /usr/local/bin/docker-compose

    read -n 1 -p "Press any key to continue."
    sudo ./app.sh
    ;;
  N)
    sudo ./app.sh
    ;;
  n)
    sudo ./app.sh
    ;;
esac

case $yn3_choice in
  Y)
    docker rm $(docker ps -a -q) && docker rmi $(docker images -q) && docker network prune
    sudo apt-get remove docker -y
    sudo apt-get remove docker-ce -y
    sudo apt-get purge docker-ce -y
    sudo rm -rf /var/lib/docker
    sudo rm /usr/local/bin/docker-compose

    read -n 1 -p "Press any key to continue."
    sudo ./app.sh
    ;;
  y)
    docker rm $(docker ps -a -q) && docker rmi $(docker images -q) && docker network prune
    sudo apt-get remove docker -y
    sudo apt-get remove docker-ce -y
    sudo apt-get purge docker-ce -y
    sudo rm -rf /var/lib/docker
    sudo rm /usr/local/bin/docker-compose

    read -n 1 -p "Press any key to continue"
    sudo ./app.sh
    ;;
  N)
    sudo ./app.sh
    ;;
  n)
    sudo ./app.sh
    ;;
esac
