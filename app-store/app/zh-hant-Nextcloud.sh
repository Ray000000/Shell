#!/bin/bash
clear

script_name="${0##*/}"
language="zh-hant"

dir0="/root/xray-shell/app-store/app"
dir1="/root//xray-shell/app-store/app-bak"
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

echo -e "\e[1m\e[93m〔Nextcloud〕\e[0m"
echo "
Cloudreve 是一個開源的雲盤系統，支持多家雲存儲，可以讓你快速搭建起一個私有或公用的網盤系統。它支持多種文件管理和分享功能，也支持多種安全功能。

Cloudreve 的優點包括：

* 開源、免費
* 功能強大，支持多種文件管理和分享功能
* 安全，支持多種安全功能

Cloudreve 適合需要搭建私有或公用網盤系統的人使用。"
echo -e "\e[1m\e[34m----------------------------------------\e[0m"

logs=$(docker exec -it cloudreve ./cloudreve --database-script ResetAdminPassword)
password=$(echo "$logs" | awk '/Initial admin user password changed to:/ {gsub("to:", ""); print $NF}')
external_ip=$(curl -s ipv4.ip.sb)
echo -e "Cloudreve 網址（安裝完成後可用）：
http://$external_ip:8090"
echo -e "Cloudreve 帳號：admin@cloudreve.org"
echo -e "Cloudreve 臨時密碼：$password"
echo -e "\e[1m\e[93m請登入後設定密碼！\e[0m"
echo -e "建議使用 AriaNG 設定 RPC"
echo -e "建議使用 Nginx Proxy Manager 設定反向代理"
echo -e "\e[1m\e[34m----------------------------------------\e[0m"

echo -e "快速腳本：
sudo apt install curl
mkdir -p ${local_dir0} && chmod +x ${local_dir0}
curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/app-store/app/${script_name} -o ${local_dir0}/${script_name} && chmod +x ${local_dir0}/${script_name} && ${local_dir0}/${script_name}"
echo -e "\e[1m\e[34m----------------------------------------\e[0m"

echo "官方網站：
https://alist.nn.ci/"
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
      read -p "請輸入您的網址：" choice1
      mkdir -p ${dir0}/nextcloud
      cd ${dir0}/nextcloud
      echo "
version: '3'

services:
  nextcloud:
    image: nextcloud
    ports:
      - 8083:80
    environment:
      - NEXTCLOUD_ADMIN_USER=admin
      - NEXTCLOUD_ADMIN_PASSWORD=admin_password
      - SQLITE_DATABASE=/var/www/html/data/nextcloud.db
    volumes:
      - nextcloud:/var/www/html

volumes:
  nextcloud:" >> docker-compose.yml
    docker-compose up -d
    docker update --restart=always nextcloud_aio_mastercontainer
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
    cd ${dir0}/nextcloud
    docker-compose down
    mkdir -p ${dir1}/nextcloud
    cp ${dir0}/nextcloud ${dir1}/nextcloud
    docker-compose pull nextcloud/all-in-one
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
    docker stop nextcloud
    docker rm nextcloud
    cd ${dir0}/nextcloud
    docker-compose down
    rm -rf ${dir0}/nextcloud
    cd

    read -n 1 -p "按任意按鍵以繼續"
    sudo ${local_dir0}/${script_name}
    ;;
  [Nn])
    sudo ${local_dir0}/${script_name}
    ;;
esac
