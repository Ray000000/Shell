#!/bin/bash

script_name="${0##*/}"

clear
echo -e "\e[1m\e[93m〔Matrix - Element〕\e[0m"
echo "
Matrix 是一个开放原始码的即时通讯协议，它不依赖于任何单一实体。这意味着它更难被审查或关闭，而且更安全。Matrix 可以用于个人聊天、群组聊天、文件共享和音频/视频通话。

以下是 Matrix 的一些具体优点：

* 去中心化：Matrix 网络由许多不同的服务器组成，这使得它更难被审查或关闭。
* 安全性：Matrix 使用端到端加密来保护用户的隐私。
* 可扩展性：Matrix 网络可以轻松扩展以容纳更多的用户和数据。

Matrix 是一个功能强大的即时通讯协议，具有许多优点。它是一种安全和可扩展的聊天服务，可以用于各种用途。"
external_ip=$(curl -s ipv4.ip.sb)
echo -e "Martix 网址（安装完成后可用）：
http://$external_ip:8010"
echo -e "Element 网址（安装完成后可用）：
http://$external_ip:8009"
echo -e "建议使用 Nginx Proxy Manager 设置反向代理"
echo "----------------------------------------"
echo "官方网站：
https://matrix.org/
https://element.io/"
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
      read -p "请输入要使用的网址：" choice1
      mkdir -p /root/data/xray-shell/docker/matrix
      cd /root/data/xray-shell/docker/matrix
      sudo docker run -it --rm \
      -v /root/data/xray-shell/docker/matrix/data:/data \
      -e SYNAPSE_SERVER_NAME=$choice1 \
      -e SYNAPSE_REPORT_STATS=yes \
      matrixdotorg/synapse:latest generate
      cd /root/data/xray-shell/docker/matrix/data
      echo "
enable_registration: true
enable_registration_without_verification: true" >> homeserver.yaml
      cd /root/data/xray-shell/docker/matrix
      echo "
version: '3.3'
services:
  synapse:
      image: 'matrixdotorg/synapse:latest'
      container_name: matrix
      ports:
        - '8010:8008'
      volumes:
        - /root/data/xray-shell/docker/matrix/data:/data
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
  
    read -n 1 -p "按任意键以继续"
    sudo ./${script_name}
    ;;
  [Nn])
    sudo ./${script_name}
    ;;
esac
  
case $yn2_choice in
  [Yy])
    cd /root/data/xray-shell/docker/matrix
    docker-compose down
    mkdir -p /root/data/xray-shell-bak/docker/matrix
    cp /root/data/xray-shell/docker/matrix /root/data/xray-shell-bak/docker/matrix
    docker-compose pull matrixdotorg/synapse vectorim/element-web
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
    docker stop matrix element-web
    docker rm matrix element-web
    cd /root/data/xray-shell/docker/matrix
    docker-compose down
    rm -rf /root/data/xray-shell/docker/matrix
    cd

    read -n 1 -p "按任意键以继续"
    sudo ./${script_name}
    ;;
  [Nn])
    sudo ./${script_name}
    ;;
esac
