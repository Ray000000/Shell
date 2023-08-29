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
    clear
    echo -e "\e[1m\e[93m〔Docker〕
    \e[0m"
    echo "
Docker 是一種開源軟體平台，可讓您快速地建立、測試和部署應用程式。Docker 將軟體封裝到名為容器的標準化單位，其中包含程式庫、系統工具、程式碼和執行時間等執行軟體所需的所有項目。使用Docker，您可以將應用程式快速地部署到各種環境並加以擴展，而且知道程式碼可以執行。

Docker 容器是一種輕量級的虛擬化解決方案，它們比傳統的虛擬機器更小、更快、更易於管理。容器共享主機的作業系統內核，這使得它們可以更有效地使用資源。

Docker 有許多優點，包括：

可移植性：容器可以運行在任何支援 Linux 的環境中。
效率：容器共享主機的作業系統內核，這使得它們可以更有效地使用資源。
可擴展性：容器可以輕鬆地擴展和縮減，以滿足需求。
安全性：容器可以隔離彼此，這有助於防止安全漏洞的傳播。
Docker 被廣泛使用於各種行業，包括開發、運營和安全。它已成為現代軟體開發和部署的關鍵工具。"
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
