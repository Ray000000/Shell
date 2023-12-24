#!/bin/bash

script_name="${0##*/}"

clear
echo -e "\e[1m\e[93m〔Rocker.Chat〕\e[0m"
echo "
Rocket.Chat 是一個開源的即時通訊平台，可用於個人、企業和社群。它提供多種功能，包括：
*私人和群組聊天
*檔案共享
*應用程式和整合
*安全性和隱私性
Rocket.Chat 可在各種平台上使用，包括網頁、桌面和行動裝置。它是免費和開源的，因此任何人都可以使用和自訂。"
external_ip=$(curl -s ipv4.ip.sb)
echo -e "登入網址（安裝完成後可用）：
http://$external_ip:8020"
echo -e "建議使用 Nginx Proxy Manager 設定反向代理"
echo "----------------------------------------"
echo "官方網站：
https://www.rocket.chat/"
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
      mkdir -p /root/data/docker/rocket-chat
      cd /root/data/docker/rocket-chat
      echo "
version: '3'
services:
  mongodb:
    image: mongo:latest
    container_name: 'mongodb'
    command: mongod --replSet rs5 --oplogSize 256
    volumes:
      - /root/data/docker/rocket-chat/mongodb:/data/db" >> docker-compose.yml
      docker-compose up -d
      docker exec -ti mongodb mongosh --eval "printjson(rs.initiate())"
      docker exec -ti mongodb mongo --eval "printjson(rs.initiate())"
      echo "
  rocket-chat:
    image: registry.rocket.chat/rocketchat/rocket.chat:latest
    container_name: 'rocket-chat'
    ports:
      - 8020:3000
    links:
      - mongodb
    environment:
      ROOT_URL: http://localhost
      MONGO_OPLOG_URL: mongodb://mongodb:27017/rs5" >> docker-compose.yml
      docker-compose up -d
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
    cd /root/data/docker/rocket-chat
    docker-compose down
    cp /root/data/docker/rocket-chat /root/data/docker/rocket-chat.bak
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
    docker stop mongodb rocket-chat
    docker rm mongodb rocket-chat
    cd /root/data/docker/rocket-chat
    docker-compose down
    rm -rf /root/data/docker/rocket-chat
    cd

    read -n 1 -p "按任意按鍵以繼續"
    sudo ./${script_name}
    ;;
  [Nn])
    sudo ./${script_name}
    ;;
esac
