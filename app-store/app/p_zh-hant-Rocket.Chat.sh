#!/bin/bash
clear

script_name="${0##*/}"
language="zh-hant"

dir0="/root/xray-shell/app-store/app"
dir1="/root/xray-shell/app-store/app-bak"
local_dir_lang="./xray-shell/app-store/${language}"
local_dir0="./xray-shell/app-store/app"
local_dir1="./xray-shell/app-store/app-bak"
local_dir2="./xray-shell/file"

if [ ! -d "${local_dir_lang}" ]; then
  mkdir -p ${local_dir_lang}
  chmod +x ${local_dir_lang}
else
  chmod +x ${local_dir_lang}
fi
if [ ! -d "${local_dir0}" ]; then
  mkdir -p ${local_dir0}
  chmod +x ${local_dir0}
else
  chmod +x ${local_dir0}
fi
if [ ! -d "${local_dir1}" ]; then
  mkdir -p ${local_dir1}
  chmod +x ${local_dir1}
else
  chmod +x ${local_dir1}
fi
if [ ! -d "${local_dir2}" ]; then
  mkdir -p ${local_dir2}
  chmod +x ${local_dir2}
else
  chmod +x ${local_dir2}
fi

curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/app-store/app/${script_name} -o ${local_dir0}/${script_name} && chmod +x ${local_dir0}/${script_name}
curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/app-store/${language}/store.sh -o ${local_dir_lang}/store.sh && chmod +x ${local_dir_lang}/store.sh

echo -e "\e[1m\e[93m〔Rocket.Chat〕\e[0m"
echo "
Rocket.Chat 是一個開源的即時通訊平台，可用於個人、企業和社群。它提供多種功能，包括：

* 私人和群組聊天
* 檔案共享
* 應用程式和整合
* 安全性和隱私性

Rocket.Chat 可在各種平台上使用，包括網頁、桌面和行動裝置。它是免費和開源的，因此任何人都可以使用和自訂。"
echo -e "\e[1m\e[34m----------------------------------------\e[0m"

external_ip=$(curl -s ipv4.ip.sb)
echo -e "登入網址（安裝完成後可用）：
http://$external_ip:8020"
echo -e "建議使用 Nginx Proxy Manager 設定反向代理"
echo -e "\e[1m\e[34m----------------------------------------\e[0m"

echo -e "快速腳本：
sudo apt install curl
mkdir -p ${local_dir0} && chmod +x ${local_dir0}
curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/app-store/app/${script_name} -o ${local_dir0}/${script_name} && chmod +x ${local_dir0}/${script_name} && ${local_dir0}/${script_name}"
echo -e "\e[1m\e[34m----------------------------------------\e[0m"

echo "官方網站：
https://www.rocket.chat/"
echo -e "\e[1m\e[93m
請選擇您要執行的任務：
\e[0m"
echo "1. 安裝"
echo "2. 更新"
echo -e "\e[1m\e[31m3. 解除安裝（不保存資料）\e[0m"
echo -e "\e[1m\e[32m0. Back\e[0m"

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
  sudo ${local_dir_lang}/store.sh
else
  echo -e "\e[1m\e[31m錯誤：無效選項\e[0m"
  read -n 1 -p "按任意按鍵，回到菜單"
  sudo ${local_dir0}/${script_name}
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
      mkdir -p ${dir0}/rocket-chat
      cd ${dir0}/rocket-chat
      echo "
version: '3'
services:
  mongodb:
    image: 'mongo:latest'
    container_name: 'mongodb'
    command: mongod --replSet rs5 --oplogSize 256
    volumes:
      - ${dir0}/rocket-chat/mongodb:/data/db" >> docker-compose.yml
      docker-compose up -d
      docker exec -ti mongodb mongosh --eval "printjson(rs.initiate())"
      docker exec -ti mongodb mongo --eval "printjson(rs.initiate())"
      echo "
  rocket-chat:
    image: 'registry.rocket.chat/rocketchat/rocket.chat:latest'
    container_name: 'rocket-chat'
    ports:
      - '8020:3000'
    links:
      - 'mongodb'
    environment:
      ROOT_URL: http://localhost
      MONGO_OPLOG_URL: mongodb://mongodb:27017/rs5" >> docker-compose.yml
      docker-compose up -d
      docker update --restart=always mongodb rocket-chat
      cd

    read -n 1 -p "按任意按鍵以繼續"
    sudo ${local_dir0}/${script_name}
    ;;
  [Nn])
    sudo ${local_dir0}/${script_name}
    ;;
esac
  
case $yn2_choice in
  [Yy])
    cd ${dir0}/rocket-chat
    docker-compose down
    mkdir -p ${dir1}/rocket-chat
    cp ${dir0}/rocket-chat ${dir1}/rocket-chat
    docker-compose pull registry.rocket.chat/rocketchat/rocket.chat
    docker-compose up -d

    read -n 1 -p "按任意按鍵以繼續"
    sudo ${local_dir0}/${script_name}
    ;;
  [Nn])
    sudo ${local_dir0}/${script_name}
    ;;
esac

case $yn3_choice in
  [Yy])
    cd
    docker stop mongodb rocket-chat
    docker rm mongodb rocket-chat
    cd ${dir0}/rocket-chat
    docker-compose down
    rm -rf ${dir0}/rocket-chat
    cd

    read -n 1 -p "按任意按鍵以繼續"
    sudo ${local_dir0}/${script_name}
    ;;
  [Nn])
    sudo ${local_dir0}/${script_name}
    ;;
esac
