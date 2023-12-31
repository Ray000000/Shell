#!/bin/bash
clear

script_name="${0##*/}"

update_message=$(curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/xray-update-message.sh | awk '/echo -e ".*"/ {print}')
if [[ -n "${update_message}" ]]; then
  eval "${update_message}"
fi

local_dir0="./xray-shell/language"

if [ ! -d "${local_dir0}" ]; then
  mkdir -p ${local_dir0}
  chmod +x ${local_dir0}
else
  chmod +x ${local_dir0}
fi

echo -e "\e[1m\e[34m
    _/      _/  _/_/_/                        
     _/  _/    _/    _/    _/_/_/  _/    _/        ______   _    _   ______  ______  _       
      _/      _/_/_/    _/    _/  _/    _/        / |      | |  | | | |     | |     | |      
   _/  _/    _/    _/  _/    _/  _/    _/         '------. | |--| | | |---- | |---- | |   _  
_/      _/  _/    _/    _/_/_/    _/_/_/           ____|_/ |_|  |_| |_|____ |_|____ |_|__|_| 
                                     _/       
                                _/_/ \e[0m"

echo -e "\e[1m\e[93m
Choose your language:
\e[0m"
echo "1. English (Coming)"
echo "2. 繁體中文"
echo "3. 简体中文"
echo -e "\e[1m\e[32m0. Exit\e[0m"

read -p "Please input: " choice

if [[ $choice == "1" ]]; then
  curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/language/en.sh -o ${local_dir0}/en.sh && chmod +x ${local_dir0}/en.sh && sudo ${local_dir0}/en.sh
elif [[ $choice == "2" ]]; then
  curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/language/zh-hant.sh -o ${local_dir0}/zh-hant.sh && chmod +x ${local_dir0}/zh-hant.sh && sudo ${local_dir0}/zh-hant.sh
elif [[ $choice == "3" ]]; then
  curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/language/zh-hans.sh -o ${local_dir0}/zh-hans.sh && chmod +x ${local_dir0}/zh-hans.sh && sudo ${local_dir0}/zh-hans.sh
elif [[ $choice == "00" ]]; then
  cd
  rm -rf ./xray-shell
  clear
  cd
elif [[ $choice == "0" ]]; then
  exit
else
  echo -e "\e[1m\e[31mError: Invalid option\e[0m"
  read -n 1 -p "Press any key to return to the menu"
  sudo ./xray-shell/${script_name}
fi
