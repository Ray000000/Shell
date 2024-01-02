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
local_dir3="./xray-shell/app-store/app-bak/cloudreve"

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
if [ ! -d "${local_dir3}" ]; then
  mkdir -p ${local_dir3}
  chmod +x ${local_dir3}
else
  chmod +x ${local_dir3}
fi

curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/app-store/app/${script_name} -o ${local_dir0}/${script_name} && chmod +x ${local_dir0}/${script_name}
curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/app-store/${language}/store.sh -o ${local_dir_lang}/store.sh && chmod +x ${local_dir_lang}/store.sh

echo -e "\e[1m\e[93m〔Cloudreve〕\e[0m"
echo "
Cloudreve 是一個開源的雲盤系統，支持多家雲存儲，可以讓你快速搭建起一個私有或公用的網盤系統。它支持多種文件管理和分享功能，也支持多種安全功能。

Cloudreve 的優點包括：

* 開源、免費
* 功能強大，支持多種文件管理和分享功能
* 安全，支持多種安全功能

Cloudreve 適合需要搭建私有或公用網盤系統的人使用。"
echo -e "\e[1m\e[34m----------------------------------------\e[0m"

logs=$(./cloudreve --database-script ResetAdminPassword)
password=$(echo "$logs" | awk '/Initial admin user password changed to:/ {gsub("to:", ""); print $NF}')
external_ip=$(curl -s ipv4.ip.sb)
aria2_rpc_file="${local_dir2}/aria2_rpc.txt"
echo -e "Cloudreve 網址（安裝完成後可用）：
http://$external_ip:5212"
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
https://cloudreve.org/"
echo -e "\e[1m\e[93m
請選擇您要執行的任務：
\e[0m"
echo "1. 安裝"
echo -e "\e[1m\e[31m2. 解除安裝（不保存資料）\e[0m"
echo -e "\e[1m\e[32m0. Back\e[0m"

read -p "請輸入：" choice

if [[ $choice == "1" ]]; then
  echo -e "\e[1m\e[34mY. 確認安裝\e[0m"
  echo -e "\e[1m\e[31mN. 取消安裝\e[0m"
  read -p "請輸入：" yn_choice
elif [[ $choice == "2" ]]; then
  echo -e "\e[1m\e[34mY. 確認解除安裝\e[0m"
  echo -e "\e[1m\e[31mN. 取消解除安裝\e[0m"
  read -p "請輸入：" yn2_choice
elif [[ $choice == "0" ]]; then
  sudo ${local_dir_lang}/store.sh
else
  echo -e "\e[1m\e[31m錯誤：無效選項\e[0m"
  read -n 1 -p "按任意按鍵，回到菜單"
  sudo ${local_dir0}/${script_name}
fi

case $yn_choice in
  [Yy])
    sudo wget https://github.com/cloudreve/Cloudreve/releases/download/3.8.3/cloudreve_3.8.3_linux_amd64.tar.gz
    tar -zxvf cloudreve_3.8.3_linux_amd64.tar.gz
    chmod +x ./cloudreve
    systemctl stop cloudreve
    rm -rf /usr/lib/systemd/system/cloudreve.service
    echo "
[Unit]
Description=Cloudreve
Documentation=https://docs.cloudreve.org
After=network.target
After=mysqld.service
Wants=network.target

[Service]
WorkingDirectory=/root
ExecStart=/root/cloudreve
Restart=on-abnormal
RestartSec=5s
KillMode=mixed

StandardOutput=null
StandardError=syslog

[Install]
WantedBy=multi-user.target" >> /usr/lib/systemd/system/cloudreve.service
    systemctl daemon-reload
    systemctl start cloudreve
    systemctl enable cloudreve
    systemctl start cloudreve
    sudo apt install -y libvips-tools ffmpeg
    rm -rf cloudreve_3.8.3_linux_amd64.tar.gz
    ./cloudreve
  
    read -n 1 -p "按任意按鍵以繼續"
    sudo ${local_dir0}/${script_name}
    ;;
  [Nn])
    sudo ${local_dir0}/${script_name}
    ;;
esac

case $yn2_choice in
  [Yy])
    cd
    systemctl stop cloudreve
    rm -rf /usr/lib/systemd/system/cloudreve.service
    cd

    read -n 1 -p "按任意按鍵以繼續"
    sudo ${local_dir0}/${script_name}
    ;;
  [Nn])
    sudo ${local_dir0}/${script_name}
    ;;
esac
