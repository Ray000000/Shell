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
請選擇您要執行的任務：
\e[0m"
echo "1. 檢測並更新系統"
echo "2. 系統資訊"
echo "3. 應用商店"
echo "4. 進階選項"
echo -e "\e[1m\e[32m0. Exit\e[0m"

read -p "請輸入：" choice

case $choice in
  1)
    apt update -y && apt full-upgrade -y && apt upgrade -y && apt autoremove -y && apt autoclean -y
    lsb_release -d
    ;;
  2)
    echo -e "\e[1m\e[93m您的系統資訊如下：\e[0m"
    cat /proc/cpuinfo | grep 'model name' | head -n1
    cat /proc/meminfo | grep MemTotal
    df -h
    ;;
  3)
    curl -sS -O https://ray000000.github.io/Shell/file/xray-zh-hant-store.sh && chmod +x xray-zh-hant-store.sh && sudo ./xray-zh-hant-store.sh
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
      0)
        sudo ./xray-zh-hant.sh
        ;;
      *)
        echo -e "\e[1m\e[31m錯誤：無效選項\e[0m"
        read -n 1 -p "按任意按鍵，回到菜單"
        ./xray-zh-hant.sh
        ;;
    esac
    ;;
  
  0)
    exit
    ;;
  *)
    echo -e "\e[1m\e[31m錯誤：無效選項\e[0m"
    ;;
esac
