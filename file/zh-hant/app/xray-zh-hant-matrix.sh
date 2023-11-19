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
https://element.io/"
echo -e "\e[1m\e[93m
請選擇您要執行的任務：
\e[0m"
echo "1. 安裝"
echo "2. 更新"
echo -e "\e[1m\e[31m3. 解除安裝（不保存資料）\e[0m"
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
  sudo ./xray-zh-hant-matrix.sh
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
      read -p "請輸入網址：" choice1
      mkdir -p /root/data/docker/matrix
      cd /root/data/docker/matrix
      sudo docker run -it --rm \
      -v /root/data/docker/matrix/data:/data \
      -e SYNAPSE_SERVER_NAME=$choice1 \
      -e SYNAPSE_REPORT_STATS=yes \
      matrixdotorg/synapse:latest generate
      cd /root/data/docker/matrix/data
      echo "
enable_registration: true
enable_registration_without_verification: true" >> homeserver.yaml
      cd /root/data/docker/matrix
      echo "
version: '3.3'
services:
  synapse:
      image: 'matrixdotorg/synapse:latest'
      container_name: 'matrix'
      ports:
        - 8010:8008
      volumes:
        - './data:/data'
      environment:
        VIRTUAL_HOST: '$choice1'
        VIRTUAL_PORT: 8008
        LETSENCRYPT_HOST: '$choice1'
        SYNAPSE_SERVER_NAME: '$choice1'
        SYNAPSE_REPORT_STATS: 'yes'
  element-web:
      image: 'vectorim/element-web'
      container_name: 'element-web'
      ports:
        - '8009:80'" >> docker-compose.yml
    docker-compose up -d
    cd

    read -n 1 -p "按任意按鍵以繼續"
    sudo ./xray-zh-hant-matrix.sh
    ;;
  [Nn])
    sudo ./xray-zh-hant-matrix.sh
    ;;
esac
  
case $yn2_choice in
  [Yy])
    cd /root/data/docker/matrix
    docker-compose down
    cp /root/data/docker/matrix /root/data/docker/matrix.bak
    docker-compose pull
    docker-compose up -d

    read -n 1 -p "按任意按鍵以繼續"
    sudo ./xray-zh-hant-matrix.sh
    ;;
  [Nn])
    sudo ./xray-zh-hant-matrix.sh
    ;;
esac

case $yn3_choice in
  [Yy])
    cd /root/data/docker/matrix
    docker-compose down
    rm -rf /root/data/docker/matrix
    cd

    read -n 1 -p "按任意按鍵以繼續"
    sudo ./xray-zh-hant-matrix.sh
    ;;
  [Nn])
    sudo ./xray-zh-hant-matrix.sh
    ;;
esac
