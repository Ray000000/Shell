#!/bin/bash

script_name="${0##*/}"
echo "${script_name} started: $(date)" >> ./xray-log.txt

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
_/      _/  _/    _/    _/_/_/    _/_/_/           ____|_/ |_|  |_| |_|____ |_|____ |_|__|_|   〔繁體中文版〕
                                     _/       
                                _/_/ \e[0m"

echo -e "\e[1m\e[93m
請選擇您要安裝應用程式：
\e[0m"
echo "1. None"
echo -e "\e[1m\e[32m0. Exit\e[0m"

read -p "請輸入：" choice

if [[ $choice == "1" ]]; then
  curl -sS -O https://example.com && chmod +x .sh && sudo ./.sh

elif [[ $choice == "0" ]]; then
  exit
else
  echo -e "\e[1m\e[31m錯誤：無效選項\e[0m"
  read -n 1 -p "按任意按鍵以繼續"
  sudo ./xray-zh-hant-store.sh
fi
echo "${script_name} ended: $(date)" >> ./xray-log.txt