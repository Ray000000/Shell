#!/bin/bash

script_name="${0##*/}"

clear
echo -e "\e[1m\e[93m〔SearXNG〕\e[0m"
echo "
SearXNG 是一個免費的網路元搜尋引擎，它匯集了來自 70 多個搜尋服務和資料庫的結果。SearXNG 不追蹤也不分析使用者，因此可以保護使用者的隱私。

SearXNG 的功能包括：

*搜索結果來自 70 多個搜尋服務和資料庫，包括 Google、Bing、DuckDuckGo、Yandex、YouTube、Wikipedia 等。
*不追蹤也不分析使用者，因此可以保護使用者的隱私。
*支持多種語言，包括英文、中文、日文、韓文等。
*支持多種搜索引擎配置，可以根據自己的需求定制 SearXNG。
SearXNG 的優點包括：

*免費：SearXNG 是免費的，你可以免費使用 SearXNG。
*安全：SearXNG 不追蹤也不分析使用者，因此可以保護使用者的隱私。
*功能強大：SearXNG 支持多種功能，可以滿足你的各種需求。
SearXNG 是一個非常實用的網路元搜尋引擎，如果你正在尋找一個安全、可靠的搜尋引擎，SearXNG 是一個不錯的選擇。

以下是 SearXNG 的一些常用功能：

*搜索：你可以在 SearXNG 中輸入要搜索的關鍵字，然後 SearXNG 就會返回來自多個搜尋服務的搜索結果。
*結果過濾：你可以根據自己的需求過濾搜索結果，例如按搜索引擎、搜索結果類型、搜索結果位置等。
*結果排序：你可以根據自己的喜好排序搜索結果，例如按搜索結果的相關性、日期、搜索引擎等。
*結果保存：你可以保存搜索結果，以便以後查看。
*結果分享：你可以分享搜索結果，以便與他人分享。
SearXNG 的使用方法非常簡單，你可以參考 SearXNG 的官方文檔或教程。"
external_ip=$(curl -s ipv4.ip.sb)
echo -e "SearXNG 網址（安裝完成後可用）：
http://$external_ip:8089"
echo -e "建議使用 Nginx Proxy Manager 設定反向代理"
echo "----------------------------------------"
echo "官方網站：
https://docs.searxng.org/"
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
      mkdir -p /root/data/docker/searxng
      cd /root/data/docker/searxng
      echo "
version: '3'

services:
  searxng:
    image: searxng/searxng
    container_name: searxng
    ports:
      - 8089:8080
    volumes:
      - './searxng:/etc/searxng'
    environment:
      - BASE_URL=http://localhost:8089/
      - INSTANCE_NAME=searxng" >> docker-compose.yml
    docker-compose up -d
    docker update --restart=always searxng
  
    read -n 1 -p "按任意按鍵以繼續"
    sudo ./${script_name}
    ;;
  [Nn])
    sudo ./${script_name}
    ;;
esac
  
case $yn2_choice in
  [Yy])
    cd /root/data/docker/searxng
    docker-compose down
    cp /root/data/docker/searxng /root/data/docker/searxng.bak
    docker-compose pull
    docker-compose up -d

    read -n 1 -p "按任意按鍵以繼續"
    sudo ./${script_name}
    ;;
  [Nn])
    sudo ./${script_name}
    ;;
esac

case $yn3_choice in
  [Yy])
    cd
    docker stop searxng
    docker rm searxng
    cd /root/data/docker/searxng
    docker-compose down
    rm -rf /root/data/docker/searxng
    cd

    read -n 1 -p "按任意按鍵以繼續"
    sudo ./${script_name}
    ;;
  [Nn])
    sudo ./${script_name}
    ;;
esac
