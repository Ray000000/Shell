#!/bin/bash

clear
echo -e "\e[1m\e[93m〔Matrix - Element〕\e[0m"
echo "
Matrix 是一個開放原始碼的即時通訊協議，由 New Vector 公司開發。它是一個去中心化的協議，這意味著它不依賴於任何單一實體來運作。相反，Matrix 網路由許多不同的伺服器組成，這些伺服器相互連接。

Matrix 具有許多優點，包括：
*去中心化：Matrix 網路不依賴於任何單一實體，這使得它更難被審查或關閉。
*安全性：Matrix 使用端到端加密來保護用戶的隱私。
*可擴展性：Matrix 網路可以輕鬆擴展以容納更多的用戶和數據。

Matrix 可以用於各種用途，包括：
*個人聊天
*群組聊天
*文件共享
*音訊和視訊通話

Matrix 有許多不同的客戶端，可在桌上型電腦、行動裝置和網頁上使用。
以下是 Matrix 的一些具體功能：
*聊天：Matrix 可以用於與其他用戶進行一對一聊天。
*群組聊天：Matrix 可以用於與多個用戶進行群聊。
*文件共享：Matrix 可以用於共享文件。
*音訊和視訊通話：Matrix 可以用於進行音訊和視訊通話。
Matrix 是一個功能強大的即時通訊協議，具有許多優點。它是一種去中心化的、安全的和可擴展的聊天服務，可以用於各種用途。"
external_ip=$(curl -s ipv4.ip.sb)
echo -e "Martix 網址（安裝完成後可用）：
http://$external_ip:8010"
echo -e "Element 網址（安裝完成後可用）：
http://$external_ip:8009"
echo -e "建議使用 Nginx Proxy Manager 設定反向代理"
echo "----------------------------------------"
echo "官方網站：
https://matrix.org/
https://element.io/"
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
  sudo ./xray-zh-hant-matrix.sh
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
      read -p "請輸入網址：" choice1
      mkdir -p /root/data/docker/matrix
      cd /root/data/docker/matrix
      sudo docker run -it --rm \
      -v /root/data/docker/matrix/data:/data \
      -e SYNAPSE_SERVER_NAME=$choice1 \
      -e SYNAPSE_REPORT_STATS=yes \
      matrixdotorg/synapse:latest generate
      cd /root/data/docker/matrix/data
      echo "
enable_registration: true
enable_registration_without_verification: true" >> homeserver.yaml
      cd /root/data/docker/matrix
      echo "
version: '3.3'
services:
  synapse:
      image: 'matrixdotorg/synapse:latest'
      container_name: 'matrix'
      ports:
        - 8010:8008
      volumes:
        - './data:/data'
      environment:
        VIRTUAL_HOST: '$choice1'
        VIRTUAL_PORT: 8008
        LETSENCRYPT_HOST: '$choice1'
        SYNAPSE_SERVER_NAME: '$choice1'
        SYNAPSE_REPORT_STATS: 'yes'
  element-web:
      image: 'vectorim/element-web'
      container_name: 'element-web'
      ports:
        - '8009:80'" >> docker-compose.yml
    docker-compose up -d
    docker update --restart=always matrix
    docker update --restart=always element-web
    cd
  
    read -n 1 -p "按任意按鍵以繼續"
    sudo ./xray-zh-hant-matrix.sh
    ;;
  [Nn])
    sudo ./xray-zh-hant-matrix.sh
    ;;
esac
  
case $yn2_choice in
  [Yy])
    cd /root/data/docker/matrix
    docker-compose down
    cp /root/data/docker/matrix /root/data/docker/matrix.bak
    docker-compose pull
    docker-compose up -d

    read -n 1 -p "按任意按鍵以繼續"
    sudo ./xray-zh-hant-matrix.sh
    ;;
  [Nn])
    sudo ./xray-zh-hant-matrix.sh
    ;;
esac

case $yn3_choice in
  [Yy])
    cd
    docker stop matrix element-web
    docker rm matrix element-web
    cd /root/data/docker/matrix
    docker-compose down
    rm -rf /root/data/docker/matrix
    cd

    read -n 1 -p "按任意按鍵以繼續"
    sudo ./xray-zh-hant-matrix.sh
    ;;
  [Nn])
    sudo ./xray-zh-hant-matrix.sh
    ;;
esac
