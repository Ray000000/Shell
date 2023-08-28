#!/bin/bash

clear
echo -e "\e[1m\e[34m
    _/      _/  _/_/_/                        
     _/  _/    _/    _/    _/_/_/  _/    _/        ______   _    _   ______  ______  _       
      _/      _/_/_/    _/    _/  _/    _/        / |      | |  | | | |     | |     | |      
   _/  _/    _/    _/  _/    _/  _/    _/         '------. | |--| | | |---- | |---- | |   _  
_/      _/  _/    _/    _/_/_/    _/_/_/           ____|_/ |_|  |_| |_|____ |_|____ |_|__|_| 
                                     _/       
                                _/_/ \e[0m"

echo "Choose your language:"
echo "1. English"
echo "2. 繁體中文"
echo "3. 简体中文"
echo "0. Exit"

read -p "Please input:" choice

case $choice in
  1)
    curl -sS -O https://ray000000.github.io/Shell/main/en.sh && chmod +x en.sh && sudo ./en.sh
    ;;
  2)
    curl -sS -O https://ray000000.github.io/Shell/main/zh-hant.sh && chmod +x zh-hant.sh && sudo ./zh-hant.sh
    ;;
  3)
    curl -sS -O https://ray000000.github.io/Shell/main/zh-hans.sh && chmod +x zh-hans.sh && sudo ./zh-hans.sh
    ;;
  0)
    exit
    ;;
  *)
    echo "Error: Ineffective choices"
    ;;
esac
