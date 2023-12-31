#!/bin/bash
clear

script_name="${0##*/}"
#--------------------------------------------------<lang>-------------------------------------------------------#
language="<lang_code>"

dir0="/root/xray-shell/app-store/app"
dir1="/root//xray-shell/app-store/app-bak"
local_dir_lang="./xray-shell/app-store/${language}"
local_dir0="./xray-shell/app-store/app"
local_dir1="./xray-shell/app-store/app-bak"
local_dir2="./xray-shell/file"

if [ ! -d "${local_dir_lang}" ]; then
  mkdir -p ${local_dir_lang}
  chmod +x ${local_dir_lang}
else
  chmod +x ${local_dir_lang}
fi
if [ ! -d "${local_dir0}" ]; then
  mkdir -p ${local_dir0}
  chmod +x ${local_dir0}
else
  chmod +x ${local_dir0}
fi
if [ ! -d "${local_dir1}" ]; then
  mkdir -p ${local_dir1}
  chmod +x ${local_dir1}
else
  chmod +x ${local_dir1}
fi
if [ ! -d "${local_dir2}" ]; then
  mkdir -p ${local_dir2}
  chmod +x ${local_dir2}
else
  chmod +x ${local_dir2}
fi

curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/app-store/app/${script_name} -o ${local_dir0}/${script_name} && chmod +x ${local_dir0}/${script_name}
curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/app-store/${language}/store.sh -o ${local_dir_lang}/store.sh && chmod +x ${local_dir_lang}/store.sh

echo -e "\e[1m\e[93m〔Application Name〕\e[0m"
echo "
Application Introduction and Help"
echo -e "\e[1m\e[34m----------------------------------------\e[0m"

echo -e "Use:
sudo apt install curl
mkdir -p ${local_dir0} && chmod +x ${local_dir0}
curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/app-store/app/${script_name} -o ${local_dir0}/${script_name} && chmod +x ${local_dir0}/${script_name} && ${local_dir0}/${script_name}"
echo -e "\e[1m\e[34m----------------------------------------\e[0m"

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
  sudo ${local_dir0}/${script_name}
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
  sudo ${local_dir0}/${script_name}
elif [[ $choice == "0" ]]; then
  sudo ${local_dir_lang}/store.sh
else
  echo -e "\e[1m\e[31mError: Ineffective choices\e[0m"
  read -n 1 -p "Press any key to return to the menu."
  sudo ${local_dir0}/${script_name}
fi
#--------------------------------------------------choice-------------------------------------------------------#
#--------------------------------------------------yn_choice----------------------------------------------------#
case $yn_choice in
  [Yy])
    sudo apt install -y

    read -n 1 -p "Press any key to continue."
    sudo ${local_dir0}/${script_name}
    ;;
  [Nn])
    sudo ${local_dir0}/${script_name}
    ;;
esac
#--------------------------------------------------yn_choice----------------------------------------------------#
#--------------------------------------------------yn2_choice---------------------------------------------------#
case $yn2_choice in
  [Yy])
    sudo apt uninstall -y

    read -n 1 -p "Press any key to continue."
    sudo ${local_dir0}/${script_name}
    ;;
  [Nn])
    sudo ${local_dir0}/${script_name}
    ;;
esac
#--------------------------------------------------yn2_choice----------------------------------------------------#
#--------------------------------------------------yn3_choice---------------------------------------------------#
case $yn3_choice in
  [Yy])
    sudo apt uninstall -y
    rm

    read -n 1 -p "Press any key to continue."
    sudo ${local_dir0}/${script_name}
    ;;
  [Nn])
    sudo ${local_dir0}/${script_name}
    ;;
esac
#--------------------------------------------------yn3_choice----------------------------------------------------#
