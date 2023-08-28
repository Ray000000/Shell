#!/bin/bash

clear
echo -e "\e[1m\e[34m
    _/      _/  _/_/_/                        
     _/  _/    _/    _/    _/_/_/  _/    _/        ______   _    _   ______  ______  _       
      _/      _/_/_/    _/    _/  _/    _/        / |      | |  | | | |     | |     | |      
   _/  _/    _/    _/  _/    _/  _/    _/         '------. | |--| | | |---- | |---- | |   _  
_/      _/  _/    _/    _/_/_/    _/_/_/           ____|_/ |_|  |_| |_|____ |_|____ |_|__|_|   〔繁體中文版〕
                                     _/       
                                _/_/ \e[0m"

echo -e "\e[1m\e[93m
請選擇您要執行的任務：:
\e[0m"
echo "1. 檢測並更新系統"
echo "2. ***"
echo "3. ***"
echo -e "\e[1m\e[32m0. Exit\e[0m"

read -p "請輸入：" choice

case $choice in
  1)
    apt update -y && apt full-upgrade -y && apt upgrade -y && apt autoremove -y && apt autoclean -y
    lsb_release -d
    ;;
  2)
    echo "您想執行哪個操作？"
    echo "1. 列出檔案"
    echo "2. 查看檔案內容"
    echo "0. 返回上一級菜單"
    read next_choice

    case $next_choice in
      1)
        ls
        ;;
      2)
        cat file.txt
        ;;
      0)
        #Back
        ;;
      *)
        echo "錯誤：無效選項"
        ;;
    esac
    ;;
  2)
    gnome-terminal
    ;;
  0)
    exit
    ;;
  *)
    echo "錯誤：無效選項"
    ;;
esac
