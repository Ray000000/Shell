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
echo "2. "
echo "3. "
echo "00. 進階選項"
echo -e "\e[1m\e[32m0. Exit\e[0m"

read -p "請輸入：" choice

case $choice in
  1)
    sudo apt update -y && apt full-upgrade -y && apt upgrade -y && apt autoremove -y && apt autoclean -y
    curl -fsSL https://get.docker.com | sh
    curl -SL https://github.com/docker/compose/releases/download/v2.9.0/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
    sudo apt-get update -y && sudo apt-get upgrade docker-ce && sudo apt-get upgrade docker-compose -y
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
    ;;
  2)
    ;;
  3)
    ;;
  4)
    echo -e "\e[1m\e[93m
請選擇您要執行的任務：
    \e[0m"
    echo "1. 列出檔案"
    echo "2. 查看檔案內容"
    echo "3. 創建檔案"
    echo "4. 刪除檔案"
    echo "5. 壓縮檔案"
    echo "6. 解壓縮檔案"
    echo "log. 更新紀錄"
    echo -e "\e[1m\e[32m0. 返回上一級菜單\e[0m"
    read -p "請輸入：" next_choice

    case $next_choice in
      1)
        ls
        ;;
      2)
        cat file.txt
        ;;
      3)
        touch new_file.txt
        ;;
      4)
        rm file.txt
        ;;
      5)
        zip file.zip file.txt
        ;;
      6)
        unzip file.zip
        ;;
      log)
        curl -sS -O https://ray000000.github.io/Shell/xray-update-log.sh && chmod +x xray-update-log.sh && sudo ./xray-update-log.sh
        ;;
      0)
        sudo ./xray-zh-hant-store.sh
        ;;
      *)
        echo -e "\e[1m\e[31m錯誤：無效選項\e[0m"
        read -n 1 -p "按任意按鍵，回到菜單"
        sudo ./xray-zh-hant-store.sh
        ;;
    esac
    ;;
  
  0)
    exit
    ;;
  *)
    echo -e "\e[1m\e[31m錯誤：無效選項\e[0m"
    read -n 1 -p "按任意按鍵，回到菜單"
    sudo ./xray-zh-hant-store.sh
    ;;
esac
