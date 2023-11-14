#!/bin/bash

clear
echo -e "\e[1m\e[93m〔Nginx Proxy Manager〕\e[0m"
echo "
Nginx Proxy Manager 是一個用於管理和監控 Nginx 代理的開放原始碼軟體。它提供一個簡潔的圖形化介面，使管理 Nginx 代理變得更加容易。
Nginx Proxy Manager 具有以下功能：
*管理 Nginx 代理的 HTTP 和 HTTPS 流量。
*為 Nginx 代理配置 SSL/TLS 憑證，包括 Let's Encrypt 自動化。
*監控 Nginx 代理的性能和狀態。
*提供日誌分析功能。
Nginx Proxy Manager 適用於各種用途，包括：
*托管網站和應用程式。
*提供代理服務。
*測試和開發環境。
Nginx Proxy Manager 的安裝和配置非常簡單。它可以安裝在各種操作系統上，包括 Linux、Windows 和 macOS。"
echo "----------------------------------------"
echo "官方網站：
https://nginxproxymanager.com/"
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

if [[ $choice == "1" ]]; then
  echo -e "\e[1m\e[34mY. 確認安裝\e[0m"
  echo -e "\e[1m\e[31mN. 取消安裝\e[0m"
  read -p "請輸入：" yn_choice
elif [[ $choice == "2" ]]; then
  sudo apt-get update -y && sudo apt-get upgrade docker-ce -y && sudo apt-get upgrade docker-compose -y
  read -n 1 -p "按任意按鍵以繼續"
  sudo ./xray-zh-hant-docker.sh
elif [[ $choice == "3" ]]; then
  echo -e "\e[1m\e[34mY. 確認解除安裝\e[0m"
  echo -e "\e[1m\e[31mN. 取消解除安裝\e[0m"
  read -p "請輸入：" yn2_choice
elif [[ $choice == "4" ]]; then
  echo -e "\e[1m\e[34mY. 確認解除安裝\e[0m"
  echo -e "\e[1m\e[31mN. 取消解除安裝\e[0m"
  read -p "請輸入：" yn3_choice
elif [[ $choice == "5" ]]; then
  docker --version
  docker-compose --version
  read -n 1 -p "按任意按鍵以繼續"
  sudo ./xray-zh-hant-docker.sh
elif [[ $choice == "0" ]]; then
  sudo ./xray-zh-hant-store.sh
else
  echo -e "\e[1m\e[31m錯誤：無效選項\e[0m"
  read -n 1 -p "按任意按鍵，回到菜單"
  sudo ./xray-zh-hant-docker.sh
fi

case $yn_choice in
  [Yy])
    if command -v docker; then
      echo "Docker 已安裝"
    else
      echo "尚未安裝 Docker"
      sudo ./xray-zh-hant-docker.sh
    fi
    if [ -f "/etc/debian_version" ]; then
      DEBIAN_FRONTEND=noninteractive apt update -y
      DEBIAN_FRONTEND=noninteractive apt full-upgrade -y
      DEBIAN_FRONTEND=noninteractive apt upgrade -y
      DEBIAN_FRONTEND=noninteractive apt autoremove -y
      DEBIAN_FRONTEND=noninteractive apt autoclean -y
      DEBIAN_FRONTEND=noninteractive apt-get install -y curl wget sudo nano htop socat neofetch
    fi
    if [ -f "/etc/redhat-release" ]; then
      yum -y update
      yum -y install curl wget sudo nano htop socat neofetch
    fi
    curl -fsSL https://get.docker.com | sh
    curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose

    read -n 1 -p "按任意按鍵以繼續"
    sudo ./xray-zh-hant-docker.sh
    ;;
  [Nn])
    sudo ./xray-zh-hant-docker.sh
    ;;
esac
  
case $yn2_choice in
  [Yy])
    sudo apt-get remove docker -y
    sudo apt-get remove docker-ce -y
    sudo apt-get purge docker-ce -y
    sudo rm -rf /var/lib/docker
    sudo rm /usr/local/bin/docker-compose

    read -n 1 -p "按任意按鍵以繼續"
    sudo ./xray-zh-hant-docker.sh
    ;;
  [Nn])
    sudo ./xray-zh-hant-docker.sh
    ;;
esac

case $yn3_choice in
  [Yy])
    docker rm $(docker ps -a -q) && docker rmi $(docker images -q) && docker network prune
    sudo apt-get remove docker -y
    sudo apt-get remove docker-ce -y
    sudo apt-get purge docker-ce -y
    sudo rm -rf /var/lib/docker
    sudo rm /usr/local/bin/docker-compose

    read -n 1 -p "按任意按鍵以繼續"
    sudo ./xray-zh-hant-docker.sh
    ;;
  [Nn])
    sudo ./xray-zh-hant-docker.sh
    ;;
esac