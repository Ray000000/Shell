#!/bin/bash

script_name="${0##*/}"

clear
echo -e "\e[1m\e[93m〔Rocket.Chat〕\e[0m"
echo "
Rocket.Chat 是一个开源的即时通讯平台，可用于个人、企业和社群。它提供多种功能，包括：

* 私人和群组聊天
* 文件共享
* 应用程序和整合
* 安全性和隐私性

Rocket.Chat 可在各种平台上使用，包括网页、桌面和移动设备。它是免费和开源的，因此任何人都可以使用和自定义。"
external_ip=$(curl -s ipv4.ip.sb)
echo -e "登录网址（安装完成后可用）：
http://$external_ip:8020"
echo -e "建议使用 Nginx Proxy Manager 设置反向代理"
echo "----------------------------------------"
echo "官方网站：
https://www.rocket.chat/"
echo -e "\e[1m\e[93m
请选择您要执行的任务：
\e[0m"
echo "1. 安装"
echo "2. 更新"
echo -e "\e[1m\e[31m3. 解除安装（不保存数据）\e[0m"
echo -e "\e[1m\e[32m0. 返回菜单\e[0m"

read -p "请输入：" choice

if [[ $choice == "1" ]]; then
  echo -e "\e[1m\e[34mY. 确认安装\e[0m"
  echo -e "\e[1m\e[31mN. 取消安装\e[0m"
  read -p "请输入：" yn_choice
elif [[ $choice == "2" ]]; then
  echo -e "\e[1m\e[34mY. 确认更新\e[0m"
  echo -e "\e[1m\e[31mN. 取消更新\e[0m"
  read -p "请输入：" yn2_choice
elif [[ $choice == "3" ]]; then
  echo -e "\e[1m\e[34mY. 确认解除安装\e[0m"
  echo -e "\e[1m\e[31mN. 取消解除安装\e[0m"
  read -p "请输入：" yn3_choice
elif [[ $choice == "0" ]]; then
  sudo ./xray-zh-hant-store.sh
else
  echo -e "\e[1m\e[31m错误：无效选项\e[0m"
  read -n 1 -p "按任意键，回到菜单"
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
      echo "Docker 已安装"
    fi
      mkdir -p /root/data/xray-shell/docker/rocket-chat
      cd /root/data/xray-shell/docker/rocket-chat
      echo "
version: '3'
services:
  mongodb:
    image: 'mongo:latest'
    container_name: 'mongodb'
    command: mongod --replSet rs5 --oplogSize 256
    volumes:
      - /root/data/xray-shell/docker/rocket-chat/mongodb:/data/db" >> docker-compose.yml
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

    read -n 1 -p "按任意键以继续"
    sudo ./${script_name}
    ;;
  [Nn])
    sudo ./${script_name}
    ;;
esac
  
case $yn2_choice in
  [Yy])
    cd /root/data/xray-shell/docker/rocket-chat
    docker-compose down
    mkdir -p /root/data/xray-shell-bak/docker/rocket-chat
    cp /root/data/xray-shell/docker/rocket-chat /root/data/xray-shell-bak/docker/rocket-chat
    docker-compose pull registry.rocket.chat/rocketchat/rocket.chat
    docker-compose up -d

    read -n 1 -p "按任意键以继续"
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
    cd /root/data/xray-shell/docker/rocket-chat
    docker-compose down
    rm -rf /root/data/xray-shell/docker/rocket-chat
    cd

    read -n 1 -p "按任意键以继续"
    sudo ./${script_name}
    ;;
  [Nn])
    sudo ./${script_name}
    ;;
esac
