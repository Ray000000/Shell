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

echo -e "\e[1m\e[93m〔qBittorrent〕\e[0m"
echo "
qBittorrent 是一個開源、自由的 BitTorrent 客戶端，支持 Windows、macOS、Linux 等多個平台。它是 µTorrent 的一個分支，具有 µTorrent 的所有功能，並且增加了一些新的功能和改進。
qBittorrent 的主要功能包括：

* 支持 BitTorrent、Magnet URI 和 HTTP/HTTPS 下載。
* 支持多種文件格式，包括音頻、視頻、文檔等。
* 支持 RSS 訂閱，可以自動下載新發布的文件。
* 支持 BT 種子文件的搜索。
* 支持 BitTorrent 協議的所有功能，包括 DHT、PEX、UPnP 等。

qBittorrent 的優點包括：

* 開源：qBittorrent 是開源的，你可以自由下載、使用和修改 qBittorrent。
* 免費：qBittorrent 是免費的，你可以免費使用 qBittorrent。
* 輕量級：qBittorrent 的體積小，運行速度快。
* 安全：qBittorrent 不包含任何廣告或間諜軟件。

qBittorrent 是一個非常優秀的 BitTorrent 客戶端，它功能強大、使用簡單，是下載 BitTorrent 文件的理想選擇。"
echo -e "\e[1m\e[34m----------------------------------------\e[0m"

container_id=$(docker ps -qf "name=qbittorrent")
logs=$(docker logs "$container_id")
password=$(echo "$logs" | awk '/A temporary password is provided for this session:/ {gsub("to:", ""); print $NF}')
external_ip=$(curl -s ipv4.ip.sb)
echo -e "qBittorrent 網址（安裝完成後可用）：
http://$external_ip:8080"
echo -e "qBittorrent 帳號：admin"
echo -e "qBittorrent 臨時密碼：$password"
echo -e "qBittorrent 檔案下載位置：
${local_dir0}/qbittorrent/downloads"
echo -e "\e[1m\e[93m請登入後設定密碼！\e[0m"
echo -e "建議使用 Nginx Proxy Manager 設定反向代理"
echo -e "\e[1m\e[34m----------------------------------------\e[0m"

echo -e "快速腳本：
sudo apt install curl
mkdir -p ${local_dir0} && chmod +x ${local_dir0}
curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/app-store/app/${script_name} -o ${local_dir0}/${script_name} && chmod +x ${local_dir0}/${script_name} && ${local_dir0}/${script_name}"
echo -e "\e[1m\e[34m----------------------------------------\e[0m"

echo "官方網站：
https://www.qbittorrent.org/"
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
      mkdir -p ${dir0}/qbittorrent
      cd ${dir0}/qbittorrent
      echo "
version: '3'
services:
  qbittorrent:
    image: 'lscr.io/linuxserver/qbittorrent:latest'
    container_name: 'qbittorrent'
    restart: unless-stopped
    volumes:
      - ${dir0}/qbittorrent/config:/config
      - ${dir0}/qbittorrent/downloads:/downloads
    ports:
      - '8080:8080'
      - '6881:6881'
      - '6881:6881/udp'
    environment:
      PUID: 1000
      PGID: 1000
      TZ: Etc/UTC
      WEBUI_PORT: '8080'" >> docker-compose.yml
    docker-compose up -d
    docker update --restart=always qbittorrent
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
    cd ${dir0}/qbittorrent
    docker-compose down
    mkdir -p ${dir1}/qbittorrent
    cp ${dir1}/qbittorrent ${dir0}/qbittorrent
    docker-compose pull lscr.io/linuxserver/qbittorrent
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
    docker stop qbittorrent
    docker rm qbittorrent
    cd ${dir0}/qbittorrent
    docker-compose down
    rm -rf ${dir0}/qbittorrent
    cd

    read -n 1 -p "按任意按鍵以繼續"
    sudo ${local_dir0}/${script_name}
    ;;
  [Nn])
    sudo ${local_dir0}/${script_name}
    ;;
esac