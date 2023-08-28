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
echo "2. 檔案管理"
echo "3. 系統資訊"
echo "4. 自訂命令"
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
    echo "3. 創建檔案"
    echo "4. 刪除檔案"
    echo "5. 壓縮檔案"
    echo "6. 解壓縮檔案"
    echo "7. 返回上一級菜單"
    read next_choice

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
      7)
        #Back
        ;;
      *)
        echo "錯誤：無效選項"
        ;;
    esac
    ;;
  3)
    echo "您的系統資訊如下："
    echo -e "\e[1m\e[93mCPU 型號：\e[0m`cat /proc/cpuinfo | grep 'model name' | head -n1 | tr -d 'model name        : '`"
    echo -e "\e[1m\e[93m記憶體大小：\e[0m`cat /proc/meminfo | grep MemTotal | tr -d 'MemTotal:        '`"
    echo -e "\e[1m\e[93m`df -h`\e[0m"
    ;;
  4)
    echo "請輸入您要執行的命令："
    read command
    eval $command
    ;;
  0)
    exit
    ;;
  *)
    echo "錯誤：無效選項"
    ;;
esac
