#!/bin/bash

script_name="${0##*/}"

clear

update_message=$(curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/xray-update-message.sh | awk '/echo -e ".*"/ {print}')

if [[ -n "$update_message" ]]; then
  eval "$update_message"
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
echo "1. English(Coming)"
echo "2. 繁體中文"
echo "3. 简体中文(Coming)"
echo -e "\e[1m\e[32m0. Exit\e[0m"

read -p "Please input:" choice

if [[ $choice == "1" ]]; then
  curl -sS -O https://raw.githubusercontent.com/Ray000000/Shell/main/main/xray-en.sh && chmod +x xray-en.sh && sudo ./xray-en.sh
elif [[ $choice == "2" ]]; then
  curl -sS -O https://raw.githubusercontent.com/Ray000000/Shell/main/main/xray-zh-hant.sh && chmod +x xray-zh-hant.sh && sudo ./xray-zh-hant.sh
elif [[ $choice == "3" ]]; then
  curl -sS -O https://raw.githubusercontent.com/Ray000000/Shell/main/main/xray-zh-hans.sh && chmod +x xray-zh-hans.sh && sudo ./xray-zh-hans.sh
elif [[ $choice == "0" ]]; then
  exit
else
  echo -e "\e[1m\e[31mError: Ineffective choices\e[0m"
  read -n 1 -p "Press any key to return to the menu."
  sudo ./${script_name}
fi
