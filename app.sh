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
#--------------------------------------------------choice-------------------------------------------------------#
if [[ $choice == "1" ]]; then
    echo -e "\e[1m\e[34mY. Confirm install\e[0m"
    echo -e "\e[1m\e[31mN. Cancel install\e[0m"
    read -p "Please input:" yn_choice
elif [[ $choice == "2" ]]; then
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
#--------------------------------------------------yn_choice----------------------------------------------------#
case $yn_choice in
  [Yy])

    read -n 1 -p "Press any key to continue."
    sudo ./app.sh
    ;;
  [Nn])
    sudo ./app.sh
    ;;
esac
#--------------------------------------------------yn2_choice---------------------------------------------------#
case $yn2_choice in
  [Yy])

    read -n 1 -p "Press any key to continue."
    sudo ./app.sh
    ;;
  [Nn])
    sudo ./app.sh
    ;;
esac
#--------------------------------------------------yn3_choice---------------------------------------------------#
case $yn3_choice in
  [Yy])

    read -n 1 -p "Press any key to continue."
    sudo ./app.sh
    ;;
  [Nn])
    sudo ./app.sh
    ;;
esac
