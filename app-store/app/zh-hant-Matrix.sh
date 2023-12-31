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

echo -e "\e[1m\e[93m〔Matrix - Element〕\e[0m"
echo "
Matrix 是一個開放原始碼的即時通訊協議，它不依賴於任何單一實體。這意味著它更難被審查或關閉，而且更安全。Matrix 可以用於個人聊天、群組聊天、文件共享和音訊/視訊通話。

以下是 Matrix 的一些具體優點：

* 去中心化：Matrix 網路由許多不同的伺服器組成，這使得它更難被審查或關閉。
* 安全性：Matrix 使用端到端加密來保護用戶的隱私。
* 可擴展性：Matrix 網路可以輕鬆擴展以容納更多的用戶和數據。

Matrix 是一個功能強大的即時通訊協議，具有許多優點。它是一種安全和可擴展的聊天服務，可以用於各種用途。"
echo -e "\e[1m\e[34m----------------------------------------\e[0m"

external_ip=$(curl -s ipv4.ip.sb)
echo -e "Martix 網址（安裝完成後可用）：
http://$external_ip:8010"
echo -e "Element 網址（安裝完成後可用）：
http://$external_ip:8009"
echo -e "建議使用 Nginx Proxy Manager 設定反向代理"
echo -e "\e[1m\e[34m----------------------------------------\e[0m"

echo -e "快速腳本：
sudo apt install curl
mkdir -p ${local_dir0} && chmod +x ${local_dir0}
curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/app-store/app/${script_name} -o ${local_dir0}/${script_name} && chmod +x ${local_dir0}/${script_name} && ${local_dir0}/${script_name}"
echo -e "\e[1m\e[34m----------------------------------------\e[0m"

echo "官方網站：
https://matrix.org/
https://element.io/"
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
      read -p "請輸入欲使用的網址：" choice1
      mkdir -p ${dir0}/matrix
      cd ${dir0}/matrix
      sudo docker run -it --rm \
      -v ${dir0}/matrix/data:/data \
      -e SYNAPSE_SERVER_NAME=$choice1 \
      -e SYNAPSE_REPORT_STATS=yes \
      matrixdotorg/synapse:latest generate
      cd ${dir0}/matrix/data
      echo "
enable_registration: true
enable_registration_without_verification: true" >> homeserver.yaml
      cd ${dir0}/matrix
      echo "
version: '3.3'
services:
  synapse:
      image: 'matrixdotorg/synapse:latest'
      container_name: matrix
      ports:
        - '8010:8008'
      volumes:
        - ${dir0}/matrix/data:/data
      environment:
        VIRTUAL_HOST: '$choice1'
        VIRTUAL_PORT: 8008
        LETSENCRYPT_HOST: '$choice1'
        SYNAPSE_SERVER_NAME: '$choice1'
        SYNAPSE_REPORT_STATS: 'yes'
  element-web:
      image: 'vectorim/element-web'
      container_name: element-web
      ports:
        - '8009:80'" >> docker-compose.yml
    docker-compose up -d
    docker update --restart=always matrix element-web
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
    cd ${dir0}/matrix
    docker-compose down
    mkdir -p ${dir1}/matrix
    cp ${dir1}/matrix ${dir0}/matrix
    docker-compose pull matrixdotorg/synapse vectorim/element-web
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
    docker stop matrix element-web
    docker rm matrix element-web
    cd ${dir0}/matrix
    docker-compose down
    rm -rf ${dir0}/matrix
    cd

    read -n 1 -p "按任意按鍵以繼續"
    sudo ${local_dir0}/${script_name}
    ;;
  [Nn])
    sudo ${local_dir0}/${script_name}
    ;;
esac
