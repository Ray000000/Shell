#!/bin/bash

script_name="${0##*/}"

clear
echo -e "\e[1m\e[93m〔Alist〕\e[0m"
echo "
Alist 是一個開源的文件列表程序，可以將本地或遠程的文件以網頁的形式展示出來。它支持多種存儲方式，包括本地存儲、FTP、SFTP、WebDAV 等。你可以在網頁上瀏覽、下載或分享文件。

Alist 的優點包括：

* 開源：你可以自由下載、使用和修改 Alist。
* 易用：使用 Alist 非常簡單，只需添加文件即可。
* 功能強大：Alist 支持多種存儲方式、瀏覽、下載、分享、搜索、權限管理等功能。

Alist 是一個非常實用的文件列表程序。它可以幫助您輕鬆管理您的文件。"
external_ip=$(curl -s ipv4.ip.sb)
password_file="/root/data/xray-shell/docker/alist/password.txt"
if [ -f "$password_file" ]; then
    alist_password=$(cat "$password_file")
fi
echo -e "Alist 網址（安裝完成後可用）：
http://$external_ip:5244"
echo -e "Alist 登入帳號：admin"
echo -e "Alist 登入密碼：$alist_password"
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
      read -p "請輸入欲使用的密碼：" choice1
      mkdir -p /root/data/xray-shell/docker/alist
      cd /root/data/xray-shell/docker/alist
      echo "
version: '3.3'
services:
    alist:
        restart: always
        volumes:
            - '/root/data/xray-shell/docker/alist:/opt/alist/data'
        ports:
            - '5244:5244'
        environment:
            - PUID=0
            - PGID=0
            - UMASK=022
        container_name: alist
        image: 'xhofe/alist:latest'" >> docker-compose.yml
    docker-compose up -d
    docker update --restart=always alist
    docker exec -it alist ./alist admin set $choice1
    echo "$choice1" > /root/data/xray-shell/docker/alist/password.txt
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
    cd /root/data/xray-shell/docker/alist
    docker-compose down
    mkdir -p /root/data/xray-shell-bak/docker/alist
    cp /root/data/xray-shell/docker/alist /root/data/xray-shell-bak/docker/alist
    docker-compose pull xhofe/alist
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
    docker stop alist
    docker rm alist
    cd /root/data/xray-shell/docker/alist
    docker-compose down
    rm -rf /root/data/xray-shell/docker/alist
    cd

    read -n 1 -p "按任意按鍵以繼續"
    sudo ./${script_name}
    ;;
  [Nn])
    sudo ./${script_name}
    ;;
esac
