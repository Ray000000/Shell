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
請選擇您要安裝的應用程式：
\e[0m"
echo "1. Docker"
echo "2. Nginx Proxy Manager"
echo "00. 進階選項"
echo -e "\e[1m\e[32m0. Exit\e[0m"

read -p "請輸入：" choice

if [[ $choice == "1" ]]; then
  curl -sS -O https://ray000000.github.io/Shell/file/zh-hant/app/xray-zh-hant-docker.sh && chmod +x xray-zh-hant-docker.sh && sudo ./xray-zh-hant-docker.sh
if [[ $choice == "1" ]]; then
  curl -sS -O https://ray000000.github.io/Shell/file/zh-hant/app/xray-zh-hant-nginx-proxy-manager.sh && chmod +x xray-zh-hant-nginx-proxy-manager.sh && sudo ./xray-zh-hant-nginx-proxy-manager.sh

elif [[ $choice == "00" ]]; then
  echo -e "\e[1m\e[93m
請選擇您要執行的任務：
    \e[0m"
  echo "1. 查看系統日誌"
  echo "2. 查看用戶和群組"
  echo "3. 修改系統語言"
  echo "log. 更新紀錄"
  echo -e "\e[1m\e[32m0. 返回上一級菜單\e[0m"
  read -p "請輸入：" next_choice

  if [[ $next_choice == "1" ]]; then
    echo -e "\e[1m\e[93m您的系統日誌如下：\e[0m"
    cat /var/log/syslog
    read -n 1 -p "按任意按鍵以繼續"
    sudo ./xray-zh-hant-store.sh
  elif [[ $next_choice == "2" ]]; then
    echo -e "\e[1m\e[93m您的所有用戶資訊如下：\e[0m"
    cat /etc/passwd
    echo -e "\e[1m\e[93m您的所有群組資訊如下：\e[0m"
    cat /etc/group
    read -n 1 -p "按任意按鍵以繼續"
    sudo ./xray-zh-hant-store.sh
  elif [[ $next_choice == "3" ]]; then
    export LANG=zh_TW.UTF-8
  elif [[ $next_choice == "log" ]]; then
    curl -sS -O https://ray000000.github.io/Shell/xray-update-log.sh && chmod +x xray-update-log.sh && sudo ./xray-update-log.sh
  elif [[ $next_choice == "0" ]]; then
    sudo ./xray-zh-hant-store.sh
  else
    echo -e "\e[1m\e[31m錯誤：無效選項\e[0m"
    read -n 1 -p "按任意按鍵以繼續"
    sudo ./xray-zh-hant-store.sh
  fi

elif [[ $choice == "0" ]]; then
  exit
else
  echo -e "\e[1m\e[31m錯誤：無效選項\e[0m"
  read -n 1 -p "按任意按鍵以繼續"
  sudo ./xray-zh-hant-store.sh
fi
;;