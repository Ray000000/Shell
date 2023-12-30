#!/bin/bash

clear
echo -e "\e[1m\e[93m〔Docker〕\e[0m"
echo "
Docker 是一种开源软体平台，可让您快速地建立、测试和部署应用程式。Docker 将软体封装到名为容器的标准化单位，其中包含程式库、系统工具、程式码和执行时间等执行软体所需的所有项目。使用Docker，您可以将应用程式快速地部署到各种环境并加以扩展，而且知道程式码可以执行。
Docker 容器是一种轻量级的虚拟化解决方案，它们比传统的虚拟机器更小、更快、更易于管理。容器共享主机的作业系统内核，这使得它们可以更有效地使用资源。
Docker 有许多优点，包括：
*可移植性：容器可以运行在任何支援 Linux 的环境中。
*效率：容器共享主机的作业系统内核，这使得它们可以更有效地使用资源。
*可扩展性：容器可以轻松地扩展和缩减，以满足需求。
*安全性：容器可以隔离彼此，这有助于防止安全漏洞的传播。
Docker 被广泛使用于各种行业，包括开发、运营和安全。它已成为现代软体开发和部署的关键工具。"
echo "----------------------------------------"
echo "官方网站：
https://www.docker.com/"
echo -e "\e[1m\e[93m
请选择您要执行的任务：
\e[0m"
echo "1. 安装"
echo "2. 更新"
echo "3. 解除安装"
echo -e "\e[1m\e[31m4. 解除安装（不保存资料）\e[0m"
echo "5. 查看版本"
echo -e "\e[1m\e[32m0. 回到菜单\e[0m"

read -p "请输入：" choice

if [[ $choice == "1" ]]; then
  echo -e "\e[1m\e[34mY. 确认安装\e[0m"
  echo -e "\e[1m\e[31mN. 取消安装\e[0m"
  read -p "请输入：" yn_choice
elif [[ $choice == "2" ]]; then
  sudo apt-get update -y && sudo apt-get upgrade docker-ce -y && sudo apt-get upgrade docker-compose -y
  read -n 1 -p "按任意键以继续"
  sudo ./xray-zh-hans-docker.sh
elif [[ $choice == "3" ]]; then
  echo -e "\e[1m\e[34mY. 确认解除安装\e[0m"
  echo -e "\e[1m\e[31mN. 取消解除安装\e[0m"
  read -p "请输入：" yn2_choice
elif [[ $choice == "4" ]]; then
  echo -e "\e[1m\e[34mY. 确认解除安装\e[0m"
  echo -e "\e[1m\e[31mN. 取消解除安装\e[0m"
  read -p "请输入：" yn3_choice
elif [[ $choice == "5" ]]; then
  docker --version
  docker-compose --version
  read -n 1 -p "按任意键以继续"
  sudo ./xray-zh-hans-docker.sh
elif [[ $choice == "0" ]]; then
  sudo ./xray-zh-hans-store.sh
else
  echo -e "\e[1m\e[31m错误：无效选项\e[0m"
  read -n 1 -p "按任意按键，回到菜单"
  sudo ./xray-zh-hans-docker.sh
fi

case $yn_choice in
  [Yy])
    if [ -f "/etc/debian_version" ]; then
      DEBIAN_FRONTEND=noninteractive apt update -y
      DEBIAN_FRONTEND=noninteractive apt full-upgrade -y
      DEBIAN_FRONTEND=noninteractive apt upgrade -y
      DEBIAN_FRONTEND=noninteractive apt autoremove -y
      DEBIAN_FRONTEND=noninteractive apt autoclean -y
      DEBIAN_FRONTEND=noninteractive apt-get install -y curl wget sudo nano htop socat neofetch
    fi
    if [ -f "/etc/redhat-release" ]; then
      yum -y update
      yum -y install curl wget sudo nano htop socat neofetch
    fi
    curl -fsSL https://get.docker.com | sh
    curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose

    read -n 1 -p "按任意键以继续"
    sudo ./xray-zh-hans-docker.sh
    ;;
  [Nn])
    sudo ./xray-zh-hans-docker.sh
    ;;
esac
  
case $yn2_choice in
  [Yy])
    sudo apt-get remove docker -y
    sudo apt-get remove docker-ce -y
    sudo apt-get purge docker-ce -y
    sudo rm -rf /var/lib/docker
    sudo rm /usr/local/bin/docker-compose

    read -n 1 -p "按任意键以继续"
    sudo ./xray-zh-hans-docker.sh
    ;;
  [Nn])
    sudo ./xray-zh-hans-docker.sh
    ;;
esac

case $yn3_choice in
  [Yy])
    docker rm $(docker ps -a -q) && docker rmi $(docker images -q) && docker network prune
    sudo apt-get remove docker -y
    sudo apt-get remove docker-ce -y
    sudo apt-get purge docker-ce -y
    sudo rm -rf /var/lib/docker
    sudo rm /usr/local/bin/docker-compose

    read -n 1 -p "按任意键以继续"
    sudo ./xray-zh-hans-docker.sh
    ;;
  [Nn])
    sudo ./xray-zh-hans-docker.sh
    ;;
esac
