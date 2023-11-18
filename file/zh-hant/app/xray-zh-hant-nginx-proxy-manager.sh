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
echo -e "\e[1m\e[31m2. 解除安裝（不保存資料）\e[0m"
echo -e "\e[1m\e[32m0. 回到菜單\e[0m"

read -p "請輸入：" choice

if [[ $choice == "1" ]]; then
  echo -e "\e[1m\e[34mY. 確認安裝\e[0m"
  echo -e "\e[1m\e[31mN. 取消安裝\e[0m"
  read -p "請輸入：" yn_choice
elif [[ $choice == "2" ]]; then
  echo -e "\e[1m\e[34mY. 確認更新\e[0m"
  echo -e "\e[1m\e[31mN. 取消更新\e[0m"
  read -p "請輸入：" yn2_choice
elif [[ $choice == "3" ]]; then
  echo -e "\e[1m\e[34mY. 確認解除安裝\e[0m"
  echo -e "\e[1m\e[31mN. 取消解除安裝\e[0m"
  read -p "請輸入：" yn3_choice
elif [[ $choice == "0" ]]; then
  sudo ./xray-zh-hant-store-n.sh
else
  echo -e "\e[1m\e[31m錯誤：無效選項\e[0m"
  read -n 1 -p "按任意按鍵，回到菜單"
  sudo ./xray-zh-hant-nginx-proxy-manager.sh
fi

case $yn_choice in
  [Yy])
    if ! command -v docker &>/dev/null; then
      curl -fsSL https://get.docker.com | sh
      curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
      chmod +x /usr/local/bin/docker-compose
      systemctl start docker
      systemctl enable docker
    else
      echo "Docker 已安裝"
    fi
      su
      mkdir -p /root/data/docker/nginx-proxy-manager
      cd /root/data/docker/nginx-proxy-manager
      echo "
version: '3'
services:
  app:
    image: 'jc21/nginx-proxy-manager:latest'
    container_name: 'nginx-proxy-manager'
    restart: unless-stopped
    ports:
      - '80:80'
      - '81:81'
      - '443:443'
    volumes:
      - ./data:/data
      - ./letsencrypt:/etc/letsencrypt" >> docker-compose.yml
      docker-compose up -d
      docker update --restart=always nginx-proxy-manager

      external_ip=$(curl -s ipv4.ip.sb)
      echo -e "登入網址：
      http://$external_ip:81"
      echo -e "
      Email: admin@example.com"
      echo -e "
      Password: changeme"

    read -n 1 -p "按任意按鍵以繼續"
    sudo ./xray-zh-hant-nginx-proxy-manager.sh
    ;;
  [Nn])
    sudo ./xray-zh-hant-nginx-proxy-manager.sh
    ;;
esac

case $yn2_choice in
  [Yy])
    cd /root/data/docker/nginx-proxy-manager
    docker-compose down 
    cp /root/data/docker/nginx-proxy-manager /root/data/docker/nginx-proxy-manager.bak
    docker-compose pull
    docker-compose up -d
    docker update --restart=yes nginx-proxy-manager

    read -n 1 -p "按任意按鍵以繼續"
    sudo ./xray-zh-hant-nginx-proxy-manager.sh
    ;;
  [Nn])
    sudo ./xray-zh-hant-nginx-proxy-manager.sh
    ;;
esac
  
case $yn3_choice in
  [Yy])
    cd /root/data/docker/nginx-proxy-manager
    docker-compose down
    rm -rf /root/data/docker/nginx-proxy-manager

    read -n 1 -p "按任意按鍵以繼續"
    sudo ./xray-zh-hant-nginx-proxy-manager.sh
    ;;
  [Nn])
    sudo ./xray-zh-hant-nginx-proxy-manager.sh
    ;;
esac
