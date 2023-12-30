#!/bin/bash

script_name="${0##*/}"

clear
echo -e "\e[1m\e[93m〔SearXNG〕\e[0m"
echo "
SearXNG 是一个免费的网络元搜索引擎，它汇集了来自多个搜索服务的结果。

SearXNG 的优点包括：

* 免费
* 安全
* 功能强大

SearXNG 适合：

* 注重隐私的使用者
* 想要搜索多个来源结果的使用者

SearXNG 可以用来：

* 搜索网页、图片、视频等
* 过滤搜索结果
* 排序搜索结果
* 保存搜索结果
* 分享搜索结果

SearXNG 的使用方法非常简单，只需输入关键字即可。"
external_ip=$(curl -s ipv4.ip.sb)
echo -e "SearXNG 网址（安装完成后可用）：
http://$external_ip:8089"
echo -e "建议使用 Nginx Proxy Manager 设置反向代理"
echo "----------------------------------------"
echo "官方网站：
https://docs.searxng.org/"
echo -e "\e[1m\e[93m
请选择您要执行的任务：
\e[0m"
echo "1. 安装"
echo "2. 更新"
echo -e "\e[1m\e[31m3. 解除安装（不保存数据）\e[0m"
echo -e "\e[1m\e[32m0. 返回菜单\e[0m"

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
  
    read -n 1 -p "按任意键以继续"
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
    mkdir -p /root/data/xray-shell-bak/docker/searxng
    cp /root/data/xray-shell/docker/searxng /root/data/xray-shell-bak/docker/searxng
    docker-compose pull searxng/searxng
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
    docker stop searxng
    docker rm searxng
    cd /root/data/xray-shell/docker/searxng
    docker-compose down
    rm -rf /root/data/xray-shell/docker/searxng
    cd

    read -n 1 -p "按任意键以继续"
    sudo ./${script_name}
    ;;
  [Nn])
    sudo ./${script_name}
    ;;
esac
