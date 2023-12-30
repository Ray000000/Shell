#!/bin/bash

script_name="${0##*/}"

clear
echo -e "\e[1m\e[93m〔Alist〕\e[0m"
echo "
Alist 是一个开源的文件列表程序，可以将本地或远程的文件以网页的形式展示出来。它支持多种存储方式，包括本地存储、FTP、SFTP、WebDAV 等。你可以在网页上浏览、下载或分享文件。

Alist 的优点包括：

* 开源：你可以自由下载、使用和修改 Alist。
* 易用：使用 Alist 非常简单，只需添加文件即可。
* 功能强大：Alist 支持多种存储方式、浏览、下载、分享、搜索、权限管理等功能。

Alist 是一个非常实用的文件列表程序。它可以帮助您轻松管理您的文件。"
external_ip=$(curl -s ipv4.ip.sb)
password_file="/root/data/xray-shell/docker/alist/password.txt"
if [ -f "$password_file" ]; then
    alist_password=$(cat "$password_file")
fi
echo -e "Alist 网址（安装完成后可用）：
http://$external_ip:5244"
echo -e "Alist 登录账号：admin"
echo -e "Alist 登录密码：$alist_password"
echo -e "建议使用 Nginx Proxy Manager 设置反向代理"
echo "----------------------------------------"
echo "官方网站：
https://alist.nn.ci/"
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
      read -p "请输入欲使用的密码：" choice1
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
  
    read -n 1 -p "按任意键以继续"
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
    docker stop alist
    docker rm alist
    cd /root/data/xray-shell/docker/alist
    docker-compose down
    rm -rf /root/data/xray-shell/docker/alist
    cd

    read -n 1 -p "按任意键以继续"
    sudo ./${script_name}
    ;;
  [Nn])
    sudo ./${script_name}
    ;;
esac
