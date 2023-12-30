#!/bin/bash
clear

script_name="${0##*/}"
local_dir0="./xray-shell/app-store/app"
mkdir -p ${local_dir0}
chmod +x ${local_dir0}

echo -e "\e[1m\e[93m〔Cloudreve〕\e[0m"
echo "
Cloudreve 是一个开源的云盘系统，支持多家云存储，可以让你快速搭建起一个私有或公用的网盘系统。它支持多种文件管理和分享功能，也支持多种安全功能。

Cloudreve 的优点包括：

* 开源、免费
* 功能强大，支持多种文件管理和分享功能
* 安全，支持多种安全功能

Cloudreve 适合需要搭建私有或公用网盘系统的人使用。"
logs=$(docker exec -it cloudreve ./cloudreve --database-script ResetAdminPassword)
password=$(echo "$logs" | awk '/Initial admin user password changed to:/ {gsub("to:", ""); print $NF}')
external_ip=$(curl -s ipv4.ip.sb)
aria2_rpc_file="/root/data/xray-shell/file/aria2_rpc.txt"
echo -e "Cloudreve 网址（安装完成后可用）：
http://$external_ip:5212"
echo -e "Cloudreve 账号：admin@cloudreve.org"
echo -e "Cloudreve 临时密码：$password"
echo -e "\e[1m\e[93m请登录后设置密码！\e[0m"
echo -e "建议使用 AriaNG 设置 RPC"
echo -e "建议使用 Nginx Proxy Manager 设置反向代理"
echo "----------------------------------------"
echo "官方网站：
https://cloudreve.org/"
echo -e "\e[1m\e[93m
请选择您要执行的任务：
\e[0m"
echo "1. 安装"
echo "2. 更新"
echo -e "\e[1m\e[31m3. 解除安装（不保存数据）\e[0m"
echo -e "\e[1m\e[32m0. 回到菜单\e[0m"

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
      read -p "请输入 aria2 的 RPC Token：" choice1
      mkdir -vp /root/data/xray-shell/docker/cloudreve/{uploads,avatar} \
      && touch /root/data/xray-shell/docker/cloudreve/conf.ini \
      && touch /root/data/xray-shell/docker/cloudreve/cloudreve.db \
      && mkdir -p /root/data/xray-shell/docker/cloudreve/aria2/config \
      && mkdir -p /root/data/xray-shell/docker/cloudreve/data/aria2 \
      && chmod -R 777 /root/data/xray-shell/docker/cloudreve/data/aria2
      cd /root/data/xray-shell/docker/cloudreve
      echo "
version: '3.8'
services:
  cloudreve:
    container_name: 'cloudreve'
    image: 'cloudreve/cloudreve:latest'
    restart: unless-stopped
    ports:
      - '5212:5212'
    volumes:
      - /root/data/xray-shell/docker/cloudreve/temp_data:/data
      - /root/data/xray-shell/docker/cloudreve/uploads:/cloudreve/uploads
      - /root/data/xray-shell/docker/cloudreve/conf.ini:/cloudreve/conf.ini
      - /root/data/xray-shell/docker/cloudreve/cloudreve.db:/cloudreve/cloudreve.db
      - /root/data/xray-shell/docker/cloudreve/avatar:/cloudreve/avatar
    depends_on:
      - aria2-pro
  aria2-pro:
    container_name: aria2-pro
    image: 'p3terx/aria2-pro'
    restart: unless-stopped
    environment:
      - RPC_SECRET=$choice1
      - RPC_PORT=6800
    volumes:
      - /root/data/xray-shell/docker/cloudreve/aria2/config:/config
      - /root/data/xray-shell/docker/cloudreve/aria2/temp_data:/data
volumes:
  temp_data:
    driver: local
    driver_opts:
      type: none
      device: $PWD/data
      o: bind" >> docker-compose.yml
    docker-compose up -d
    docker update --restart=always cloudreve aria2-pro
    echo "$choice1" > /root/data/xray-shell/file/aria2_rpc.txt
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
    cd /root/data/xray-shell/docker/cloudreve
    docker-compose down
    mkdir -p /root/data/xray-shell-bak/docker/cloudreve
    cp /root/data/xray-shell/docker/cloudreve /root/data/xray-shell-bak/docker/cloudreve
    docker-compose pull cloudreve/cloudreve p3terx/aria2-pro
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
    docker stop cloudreve aria2-pro
    docker rm cloudreve aria2-pro
    cd /root/data/xray-shell/docker/cloudreve
    docker-compose down
    rm -rf /root/data/xray-shell/docker/cloudreve
    cd

    read -n 1 -p "按任意键以继续"
    sudo ./${script_name}
    ;;
  [Nn])
    sudo ./${script_name}
    ;;
esac
