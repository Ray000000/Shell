#!/bin/bash

clear
echo -e "\e[1m\e[34m
    _/      _/  _/_/_/                        
     _/  _/    _/    _/    _/_/_/  _/    _/        ______   _    _   ______  ______  _       
      _/      _/_/_/    _/    _/  _/    _/        / |      | |  | | | |     | |     | |      
   _/  _/    _/    _/  _/    _/  _/    _/         '------. | |--| | | |---- | |---- | |   _  
_/      _/  _/    _/    _/_/_/    _/_/_/           ____|_/ |_|  |_| |_|____ |_|____ |_|__|_|   〔简体中文版〕
                                     _/       
                                _/_/ \e[0m"

echo -e "\e[1m\e[93m
请选择您要执行的任务：
\e[0m"
echo "1. 检查并更新系统"
echo "2. 系统信息"
echo "3. 应用商店"
echo "00. 高级选项"
echo -e "\e[1m\e[32m0. 退出\e[0m"

read -p "请输入：" choice

if [ "$(uname -m)" == "x86_64" ]; then
  cpu_info=$(cat /proc/cpuinfo | grep 'model name' | uniq | sed -e 's/model name[[:space:]]*: //')
else
  cpu_info=$(lscpu | grep 'Model name' | sed -e 's/Model name[[:space:]]*: //')
fi

os_info=$(lsb_release -ds 2>/dev/null)

if [ -z "$os_info" ]; then
  if [ -f "/etc/os-release" ]; then
    os_info=$(source /etc/os-release && echo "$PRETTY_NAME")
  elif [ -f "/etc/debian_version" ]; then
    os_info="Debian $(cat /etc/debian_version)"
  elif [ -f "/etc/redhat-release" ]; then
    os_info=$(cat /etc/redhat-release)
  else
    os_info="未知"
  fi
fi

if [[ $choice == "1" ]]; then
  sudo apt update -y && apt full-upgrade -y && apt upgrade -y && apt autoremove -y && apt autoclean -y && apt-get install -y curl wget sudo nano htop socat neofetch
  clear
  sudo neofetch

  read -n 1 -p "按任意键以继续"
  sudo ./xray-zh-hans.sh
elif [[ $choice == "2" ]]; then
  echo -e "\e[1m\e[93m您的系统信息如下：\e[0m"
  echo "操作系统：$os_info"
  echo "内核版本：$(uname -r)"
  echo "CPU 型号：$cpu_info
  "
  echo "IPv4 位置：$(curl -s ipv4.ip.sb)"
  echo "IPv6 位置：$(curl -s ipv6.ip.sb)"
  df -h

  read -n 1 -p "按任意键以继续"
  sudo ./xray-zh-hans.sh
elif [[ $choice == "3" ]]; then
  curl -sS -O https://ray000000.github.io/Shell/file/zh-hans/xray-zh-hans-store.sh && chmod +x xray-zh-hans-store.sh && sudo ./xray-zh-hans-store.sh
elif [[ $choice == "00" ]]; then
  echo -e "\e[1m\e[93m
请选择您要执行的任务：
\e[0m"
  echo "1. 查看系统日志"
  echo "2. 查看用户和组"
  echo "3. 修改系统语言"
  echo "log. 更新记录"
  echo -e "\e[1m\e[32m0. 返回上一级菜单\e[0m"
  read -p "请输入：" next_choice

  if [[ $next_choice == "1" ]]; then
    echo -e "\e[1m\e[93m您的系统日志如下：\e[0m"
    cat /var/log/syslog
    read -n 1 -p "按任意键以继续"
    sudo ./xray-zh-hans.sh
  elif [[ $next_choice == "2" ]]; then
    echo -e "\e[1m\e[93m您的所有用户信息如下：\e[0m"
    cat /etc/passwd
    echo -e "\e[1m\e[93m您的所有组信息如下：\e[0m"
    cat /etc/group
    read -n 1 -p "按任意键以继续"
    sudo ./xray-zh-hans.sh
  elif [[ $next_choice == "3" ]]; then
    export LANG=zh_CN.UTF-8
  elif [[ $next_choice == "log" ]]; then
    curl -sS -O https://ray000000.github.io/Shell/xray-update-log.sh && chmod +x xray-update-log.sh && sudo ./xray-update-log.sh
  elif [[ $next_choice == "0" ]]; then
    sudo ./xray-zh-hans.sh
  else
    echo -e "\e[1m\e[31m错误：无效选项\e[0m"
    read -n 1 -p "按任意键以继续"
    sudo ./xray-zh-hans.sh
  fi

elif [[ $choice == "0" ]]; then
  exit
else
  echo -e "\e[1m\e[31m错误：无效选项\e[0m"
  read -n 1 -p "按任意键以继续"
  sudo ./xray-zh-hans.sh
fi
