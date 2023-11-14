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

if [[ $choice == "1" ]]; then
    echo -e "\e[1m\e[34mY. Confirm install\e[0m"
    echo -e "\e[1m\e[31mN. Cancel install\e[0m"
    read -p "Please input:" yn_choice
elif [[ $choice == "2" ]]; then
  sudo apt-get update -y && sudo apt-get upgrade docker-ce -y && sudo apt-get upgrade docker-compose -y
  read -n 1 -p "Press any key to continue."
  sudo ./app.sh
elif [[ $choice == "3" ]]; then
  echo -e "\e[1m\e[34mY. Confirm uninstall\e[0m"
  echo -e "\e[1m\e[31mN. Cancel uninstall\e[0m"
  read -p "Please input:" yn2_choice
elif [[ $choice == "4" ]]; then
  echo -e "\e[1m\e[34mY. Confirm uninstall\e[0m"
  echo -e "\e[1m\e[31mN. Cancel uninstall\e[0m"
  read -p "Please input:" yn3_choice
elif [[ $choice == "5" ]]; then
  docker --version
  docker-compose --version
  read -n 1 -p "Press any key to continue."
  sudo ./app.sh
elif [[ $choice == "0" ]]; then
  sudo ./app.sh
else
  echo -e "\e[1m\e[31mError: Ineffective choices\e[0m"
  read -n 1 -p "Press any key to return to the menu."
  sudo ./app.sh
fi

case $yn_choice in
  [Yy])
function progress() {
  local total=$1
  local current=$2
  local percent=$((current / total * 100))

  echo -ne "\r[%%-50s] %d%%" "$(seq -s " " 1 50)" $percent
}
    sudo apt update -y && apt full-upgrade -y && apt upgrade -y && apt autoremove -y && apt autoclean -y && progress 100 1
    curl -fsSL https://get.docker.com | sh && progress 100 1
    curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && progress 100 1
    chmod +x /usr/local/bin/docker-compose && progress 100 1

    read -n 1 -p "Press any key to continue."
    sudo ./app.sh
    ;;
  [Nn])
    sudo ./app.sh
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
    sudo ./app.sh
    ;;
  [Nn])
    sudo ./app.sh
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
    sudo ./app.sh
    ;;
  [Nn])
    sudo ./app.sh
    ;;
esac
