#!/bin/bash

script_name="${0##*/}"

clear
echo -e "\e[1m\e[93m〔Nginx Proxy Manager〕\e[0m"
echo "
Nginx Proxy Manager 是一個用於管理 Nginx 代理的軟體。它可以幫助你輕鬆管理 Nginx 代理的 HTTP 和 HTTPS 流量，配置 SSL/TLS 憑證，監控 Nginx 代理的性能和狀態，以及分析日誌。
Nginx Proxy Manager 適用於各種用途，包括托管網站和應用程式、提供代理服務、以及測試和開發環境。

以下是 Nginx Proxy Manager 的一些具體優點：

* 簡潔的圖形化介面，易於使用
* 支持多種操作系統
* 提供多種功能，可滿足各種需求

Nginx Proxy Manager 是一個非常實用的軟體，可以幫助你輕鬆管理 Nginx 代理。"
external_ip=$(curl -s ipv4.ip.sb)
echo -e "登入網址（安裝完成後可用）：
http://$external_ip:81"
echo -e "Email: admin@example.com"
echo -e "Password: changeme"
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
  sudo ./xray-zh-hant-store.sh
else
  echo -e "\e[1m\e[31m錯誤：無效選項\e[0m"
  read -n 1 -p "按任意按鍵，回到菜單"
  sudo ./${script_name}
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
      mkdir -p /root/data/xray-shell/docker/nginx-proxy-manager
      cd /root/data/xray-shell/docker/nginx-proxy-manager
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
      - './data:/data'
      - './letsencrypt:/etc/letsencrypt'" >> docker-compose.yml
      docker-compose up -d
      docker update --restart=always nginx-proxy-manager
      cd

    read -n 1 -p "按任意按鍵以繼續"
    sudo ./${script_name}
    ;;
  [Nn])
    sudo ./${script_name}
    ;;
esac

case $yn2_choice in
  [Yy])
    cd /root/data/xray-shell/docker/nginx-proxy-manager
    docker-compose down
    mkdir -p /root/data/xray-shell-bak/docker/nginx-proxy-manager
    cp /root/data/xray-shell/docker/nginx-proxy-manager /root/data/xray-shell-bak/docker/nginx-proxy-manager
    docker-compose pull jc21/nginx-proxy-manager
    docker-compose up -d
    docker update --restart=always nginx-proxy-manager

    read -n 1 -p "按任意按鍵以繼續"
    sudo ./${script_name}
    ;;
  [Nn])
    sudo ./${script_name}
    ;;
esac
  
case $yn3_choice in
  [Yy])
    cd /root/data/xray-shell/docker/nginx-proxy-manager
    docker-compose down
    rm -rf /root/data/xray-shell/docker/nginx-proxy-manager

    read -n 1 -p "按任意按鍵以繼續"
    sudo ./${script_name}
    ;;
  [Nn])
    sudo ./${script_name}
    ;;
esac
