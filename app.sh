#!/bin/bash

script_name="${0##*/}"

clear
echo -e "\e[1m\e[93m〔Application Name〕\e[0m"
echo "
Application Introduction and Help"
echo "----------------------------------------"
echo "Official Website:
https://example.com/"
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
  stop
  cp
  cd
  read -n 1 -p "Press any key to continue."
  sudo ./${script_name}
elif [[ $choice == "3" ]]; then
  echo -e "\e[1m\e[34mY. Confirm uninstall\e[0m"
  echo -e "\e[1m\e[31mN. Cancel uninstall\e[0m"
  read -p "Please input:" yn2_choice
elif [[ $choice == "4" ]]; then
  echo -e "\e[1m\e[34mY. Confirm uninstall\e[0m"
  echo -e "\e[1m\e[31mN. Cancel uninstall\e[0m"
  read -p "Please input:" yn3_choice
elif [[ $choice == "5" ]]; then
  version
  read -n 1 -p "Press any key to continue."
  sudo ./${script_name}
elif [[ $choice == "0" ]]; then
  sudo ./${script_name}
else
  echo -e "\e[1m\e[31mError: Ineffective choices\e[0m"
  read -n 1 -p "Press any key to return to the menu."
  sudo ./${script_name}
fi
#--------------------------------------------------choice-------------------------------------------------------#
#--------------------------------------------------yn_choice----------------------------------------------------#
case $yn_choice in
  [Yy])
    sudo apt install -y

    read -n 1 -p "Press any key to continue."
    sudo ./${script_name}
    ;;
  [Nn])
    sudo ./${script_name}
    ;;
esac
#--------------------------------------------------yn_choice----------------------------------------------------#
#--------------------------------------------------yn2_choice---------------------------------------------------#
case $yn2_choice in
  [Yy])
    sudo apt uninstall -y

    read -n 1 -p "Press any key to continue."
    sudo ./${script_name}
    ;;
  [Nn])
    sudo ./${script_name}
    ;;
esac
#--------------------------------------------------yn2_choice----------------------------------------------------#
#--------------------------------------------------yn3_choice---------------------------------------------------#
case $yn3_choice in
  [Yy])
    sudo apt uninstall -y
    rm

    read -n 1 -p "Press any key to continue."
    sudo ./${script_name}
    ;;
  [Nn])
    sudo ./${script_name}
    ;;
esac
#--------------------------------------------------yn3_choice----------------------------------------------------#
