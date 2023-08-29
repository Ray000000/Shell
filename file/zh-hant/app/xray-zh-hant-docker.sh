#!/bin/bash
clear
echo -e "\e[1m\e[93m〔Docker〕\e[0m"
echo "
Docker 是一種開源軟體平台，可讓您快速地建立、測試和部署應用程式。Docker 將軟體封裝到名為容器的標準化單位，其中包含程式庫、系統工具、程式碼和執行時間等執行軟體所需的所有項目。使用Docker，您可以將應用程式快速地部署到各種環境並加以擴展，而且知道程式碼可以執行。
Docker 容器是一種輕量級的虛擬化解決方案，它們比傳統的虛擬機器更小、更快、更易於管理。容器共享主機的作業系統內核，這使得它們可以更有效地使用資源。
Docker 有許多優點，包括：
可移植性：容器可以運行在任何支援 Linux 的環境中。
*效率：容器共享主機的作業系統內核，這使得它們可以更有效地使用資源。
*可擴展性：容器可以輕鬆地擴展和縮減，以滿足需求。
*安全性：容器可以隔離彼此，這有助於防止安全漏洞的傳播。
Docker 被廣泛使用於各種行業，包括開發、運營和安全。它已成為現代軟體開發和部署的關鍵工具。"
echo "----------------------------------------"
echo "官方網站：
https://www.docker.com/"
echo -e "\e[1m\e[93m
請選擇您要執行的任務：
\e[0m"
echo "1. 安裝"
echo "2. 更新"
echo "3. 解除安裝"
echo -e "\e[1m\e[31m4. 解除安裝（不保存資料）\e[0m"
echo "5. 查看版本"
echo -e "\e[1m\e[32m0. 回到菜單\e[0m"

read -p "請輸入：" choice

case $choice in
  1)
    echo -e "\e[1m\e[34mY. 確認安裝\e[0m"
    echo -e "\e[1m\e[31mN. 取消安裝\e[0m"
    read -p "請輸入：" yn_choice
    ;;
  2)
    sudo apt-get update && sudo apt-get upgrade docker-ce && sudo apt-get upgrade docker-compose
    ;;
  3)
    echo -e "\e[1m\e[34mY. 確認解除安裝\e[0m"
    echo -e "\e[1m\e[31mN. 取消解除安裝\e[0m"
    read -p "請輸入：" yn2_choice
    ;;
  4)
    echo -e "\e[1m\e[34mY. 確認解除安裝\e[0m"
    echo -e "\e[1m\e[31mN. 取消解除安裝\e[0m"
    read -p "請輸入：" yn3_choice
    ;;
  5)
    docker --version
    docker-compose --version
    read -n 1 -p "按任意按鍵以繼續"
    sudo ./xray-zh-hant-docker.sh
    ;;
  0)
    sudo ./xray-zh-hant-store.sh
    ;;
  *)
    echo -e "\e[1m\e[31m錯誤：無效選項\e[0m"
    read -n 1 -p "按任意按鍵，回到菜單"
    sudo ./xray-zh-hant-docker.sh
    ;;
  esac
  ;;

  case $yn_choice in
    Y)
      sudo apt update -y && apt full-upgrade -y && apt upgrade -y && apt autoremove -y && apt autoclean -y
      curl -fsSL https://get.docker.com | sh
      curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
      chmod +x /usr/local/bin/docker-compose
      ;;
    y)
      sudo apt update -y && apt full-upgrade -y && apt upgrade -y && apt autoremove -y && apt autoclean -y
      curl -fsSL https://get.docker.com | sh
      curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
      chmod +x /usr/local/bin/docker-compose
      ;;
    N)
      sudo ./xray-zh-hant-docker.sh
      ;;
    n)
      sudo ./xray-zh-hant-docker.sh
      ;;
    *)
      echo -e "\e[1m\e[31m錯誤：無效選項\e[0m"
      read -n 1 -p "按任意按鍵，回到菜單"
      sudo ./xray-zh-hant-docker.sh
      ;;
  esac
  ;;
  
  case $yn2_choice in
    Y)
      sudo apt-get remove docker
      sudo apt-get remove docker-ce
      sudo apt-get purge docker-ce
      sudo rm -rf /var/lib/docker
      sudo rm /usr/local/bin/docker-compose
      ;;
    y)
      sudo apt-get remove docker
      sudo apt-get remove docker-ce
      sudo apt-get purge docker-ce
      sudo rm -rf /var/lib/docker
      sudo rm /usr/local/bin/docker-compose
      ;;
    N)
      sudo ./xray-zh-hant-docker.sh
      ;;
    n)
      sudo ./xray-zh-hant-docker.sh
      ;;
    *)
      echo -e "\e[1m\e[31m錯誤：無效選項\e[0m"
      read -n 1 -p "按任意按鍵，回到菜單"
      sudo ./xray-zh-hant-docker.sh
      ;;
  esac
  ;;

  case $yn3_choice in
    Y)
      docker rm $(docker ps -a -q) && docker rmi $(docker images -q) && docker network prune
      sudo apt-get remove docker
      sudo apt-get remove docker-ce
      sudo apt-get purge docker-ce
      sudo rm -rf /var/lib/docker
      sudo rm /usr/local/bin/docker-compose
      ;;
    y)
      docker rm $(docker ps -a -q) && docker rmi $(docker images -q) && docker network prune
      sudo apt-get remove docker
      sudo apt-get remove docker-ce
      sudo apt-get purge docker-ce
      sudo rm -rf /var/lib/docker
      sudo rm /usr/local/bin/docker-compose
      ;;
    N)
      sudo ./xray-zh-hant-docker.sh
      ;;
    n)
      sudo ./xray-zh-hant-docker.sh
      ;;
    *)
      echo -e "\e[1m\e[31m錯誤：無效選項\e[0m"
      read -n 1 -p "按任意按鍵，回到菜單"
      sudo ./xray-zh-hant-docker.sh
      ;;
  esac
  ;;
