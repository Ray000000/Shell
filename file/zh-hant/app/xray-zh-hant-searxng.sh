#!/bin/bash

script_name="${0##*/}"

clear
echo -e "\e[1m\e[93m〔SearXNG〕\e[0m"
echo "
SearXNG 是一個免費的網路元搜尋引擎，它匯集了來自多個搜尋服務的結果。

SearXNG 的優點包括：

* 免費
* 安全
* 功能強大

SearXNG 適合：

* 注重隱私的使用者
* 想要搜索多個來源結果的使用者
SearXNG 可以用來：

* 搜索網頁、圖片、視頻等
* 過濾搜索結果
* 排序搜索結果
* 保存搜索結果
* 分享搜索結果

SearXNG 的使用方法非常簡單，只需輸入關鍵字即可。"
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
      mkdir -p /root/data/xray-shell/docker/searxng
      cd /root/data/xray-shell/docker/searxng
      echo "
version: '3'

services:
  searxng:
    image: 'searxng/searxng:latest'
    container_name: 'searxng'
    ports:
      - '8089:8080'
    volumes:
      - './searxng:/etc/searxng'
    environment:
      - BASE_URL=http://localhost:8089/
      - INSTANCE_NAME=SearXNG" >> docker-compose.yml
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
    cd /root/data/xray-shell/docker/searxng
    docker-compose down
    cp /root/data/xray-shell/docker/searxng /root/data/xray-shell-bak/docker/searxng
    docker-compose pull searxng/searxng
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
    cd /root/data/xray-shell/docker/searxng
    docker-compose down
    rm -rf /root/data/xray-shell/docker/searxng
    cd

    read -n 1 -p "按任意按鍵以繼續"
    sudo ./${script_name}
    ;;
  [Nn])
    sudo ./${script_name}
    ;;
esac
