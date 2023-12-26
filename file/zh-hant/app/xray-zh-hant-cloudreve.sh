#!/bin/bash

script_name="${0##*/}"

clear
echo -e "\e[1m\e[93m〔Cloudreve〕\e[0m"
echo "
Alist 是一個開源的文件列表程序，支持多種存儲，包括本地存儲、FTP、SFTP、WebDAV 等。它可以幫助你將本地或遠程的文件以網頁的形式展示出來，方便你瀏覽、下載或分享。

Alist 的功能包括：

*支持多種存儲：Alist 支持多種存儲，包括本地存儲、FTP、SFTP、WebDAV 等。你可以將本地的文件或遠程的文件添加到 Alist，並以網頁的形式展示出來。
*支持瀏覽、下載、分享：Alist 支持瀏覽、下載、分享文件。你可以在網頁上瀏覽文件，並下載或分享文件。
*支持搜索：Alist 支持搜索文件。你可以根據文件名、文件類型等條件搜索文件。
*支持權限管理：Alist 支持權限管理。你可以根據用戶或組設置文件的訪問權限。
Alist 的優點包括：

*開源：Alist 是開源的，你可以自由下載、使用和修改 Alist。
*易用：Alist 的使用非常簡單，只需添加文件，然後即可在網頁上瀏覽、下載或分享文件。
*功能強大：Alist 支持多種存儲、瀏覽、下載、分享、搜索、權限管理等功能。"
container_id=$(docker ps -qf "name=cloudreve")
logs=$(docker logs -f "$container_id")
password=$(echo "$logs" | awk '/Admin password:/ {print $NF}')
external_ip=$(curl -s ipv4.ip.sb)
aria2_rpc_file="/root/data/xray-shell/file/aria2_rpc.txt"
echo -e "Cloudreve 網址（安裝完成後可用）：
http://$external_ip:5212"
echo -e "Cloudreve 帳號：admin@cloudreve.org"
echo -e "Cloudreve 密碼：$password"
echo -e "建議使用 AriaNG 設定 RPC"
echo -e "建議使用 Nginx Proxy Manager 設定反向代理"
echo "----------------------------------------"
echo "官方網站：
https://alist.nn.ci/"
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
      read -p "請輸入 aria2 的 RPC Token：" choice1
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
  
    read -n 1 -p "按任意按鍵以繼續"
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
    cp /root/data/xray-shell/docker/cloudreve /root/data/xray-shell-bak/docker/cloudreve
    docker-compose pull cloudreve/cloudreve p3terx/aria2-pro
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
    docker stop cloudreve aria2-pro
    docker rm cloudreve aria2-pro
    cd /root/data/xray-shell/docker/cloudreve
    docker-compose down
    rm -rf /root/data/xray-shell/docker/cloudreve
    cd

    read -n 1 -p "按任意按鍵以繼續"
    sudo ./${script_name}
    ;;
  [Nn])
    sudo ./${script_name}
    ;;
esac
