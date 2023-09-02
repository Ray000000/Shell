#!/bin/bash

clear
echo -e "\e[1m\e[93m〔Docker〕\e[0m"
echo "
"
echo "----------------------------------------"
echo "Official website: 
https://www.docker.com/"
echo -e "\e[1m\e[93m
Please select the task you want to perform:
\e[0m"
echo "1. Install"
echo "2. Update"
echo "3. Uninstall"
echo -e "\e[1m\e[31m4. Uninstall and erase all data\e[0m"
echo "5. Check version"
echo -e "\e[1m\e[32m0. Back\e[0m"

read -p "Please input: " choice

if [[ $choice == "1" ]]; then
  echo -e "\e[1m\e[34mY. Confirm install\e[0m"
  echo -e "\e[1m\e[31mN. Cancel install\e[0m"
  read -p "Please input: " yn_choice
elif [[ $choice == "2" ]]; then
  sudo apt-get update -y && sudo apt-get upgrade docker-ce -y && sudo apt-get upgrade docker-compose -y
  read -n 1 -p "Press any key to continue."
  sudo ./xray-en-docker.sh
elif [[ $choice == "3" ]]; then
  echo -e "\e[1m\e[34mY. Confirm uninstall\e[0m"
  echo -e "\e[1m\e[31mN. Cancel uninstall\e[0m"
  read -p "Please input: " yn2_choice
elif [[ $choice == "4" ]]; then
  echo -e "\e[1m\e[34mY. Confirm uninstall\e[0m"
  echo -e "\e[1m\e[31mN. Cancel uninstall\e[0m"
  read -p "Please input: " yn3_choice
elif [[ $choice == "5" ]]; then
  docker --version
  docker-compose --version
  read -n 1 -p "Press any key to continue."
  sudo ./xray-en-docker.sh
elif [[ $choice == "0" ]]; then
  sudo ./xray-en-store.sh
else
  echo -e "\e[1m\e[31mError: Ineffective choices\e[0m"
  read -n 1 -p "Press any key to return to the menu."
  sudo ./xray-en-docker.sh
fi

case $yn_choice in
  [Yy])
    sudo apt update -y && apt full-upgrade -y && apt upgrade -y && apt autoremove -y && apt autoclean -y
    curl -fsSL https://get.docker.com | sh
    curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose

    read -n 1 -p "Press any key to continue."
    sudo ./xray-en-docker.sh
    ;;
  [Nn])
    sudo ./xray-en-docker.sh
    ;;
esac
  
case $yn2_choice in
  [Yy])
    sudo apt-get remove docker -y
    sudo apt-get remove docker-ce -y
    sudo apt-get purge docker-ce -y
    sudo rm -rf /var/lib/docker
    sudo rm /usr/local/bin/docker-compose

    read -n 1 -p "Press any key to continue."
    sudo ./xray-en-docker.sh
    ;;
  [Nn])
    sudo ./xray-en-docker.sh
    ;;
esac

case $yn3_choice in
  [Yy])
    docker rm $(docker ps -a -q) && docker rmi $(docker images -q) && docker network prune
    sudo apt-get remove docker -y
    sudo apt-get remove docker-ce -y
    sudo apt-get purge docker-ce -y
    sudo rm -rf /var/lib/docker
    sudo rm /usr/local/bin/docker-compose

    read -n 1 -p "Press any key to continue."
    sudo ./xray-en-docker.sh
    ;;
  [Nn])
    sudo ./xray-en-docker.sh
    ;;
esac
