#!/bin/bash

clear
echo -e "\e[1m\e[34m
    _/      _/  _/_/_/                        
     _/  _/    _/    _/    _/_/_/  _/    _/        ______   _    _   ______  ______  _       
      _/      _/_/_/    _/    _/  _/    _/        / |      | |  | | | |     | |     | |      
   _/  _/    _/    _/  _/    _/  _/    _/         '------. | |--| | | |---- | |---- | |   _  
_/      _/  _/    _/    _/_/_/    _/_/_/           ____|_/ |_|  |_| |_|____ |_|____ |_|__|_|   〔繁體中文版〕
                                     _/       
                                _/_/ \e[0m"

echo -e "\e[1m\e[93m
請選擇您要執行的任務：
\e[0m"
echo "1. 檢測並更新系統"
echo "2. 系統資訊"
echo "3. 應用商店"
echo "00. 進階選項"
echo -e "\e[1m\e[32m0. Exit\e[0m"

read -p "請輸入：" choice

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
    os_info="Unknown"
  fi
fi

if [[ $choice == "1" ]]; then
  commands1=(
    "sudo apt update -y && apt full-upgrade -y && apt upgrade -y && apt autoremove -y && apt autoclean -y"
    "lsb_release -d"
  )
  total_commands1=${#commands1[@]}
    for ((i = 0; i < total_commands1; i++)); do
      command1="${commands1[i]}"
      eval $command1

      percentage1=$(( (i + 1) * 100 / total_commands1 ))
      completed1=$(( percentage1 / 2 ))
      remaining1=$(( 50 - completed1 ))
      progressBar1="["
      for ((j = 0; j < completed1; j++)); do
        progressBar1+="#"
      done
      for ((j = 0; j < remaining1; j++)); do
        progressBar1+="."
      done
      progressBar1+="]"
      echo -ne "\r[$percentage1%] $progressBar1"
    done
  echo

  read -n 1 -p "按任意按鍵以繼續"
  sudo ./xray-zh-hant.sh
elif [[ $choice == "2" ]]; then
  echo -e "\e[1m\e[93m您的系統資訊如下：\e[0m"
  echo "作業系統：$os_info"
  echo "核心版本：$(uname -r)"
  echo "CPU 型號：$cpu_info
  "
  echo "IPv4 位置：$(curl -s ipv4.ip.sb)"
  echo "IPv6 位置：$(curl -s ipv6.ip.sb)"
  df -h

  read -n 1 -p "按任意按鍵以繼續"
  sudo ./xray-zh-hant.sh
elif [[ $choice == "3" ]]; then
  curl -sS -O https://ray000000.github.io/Shell/file/zh-hant/xray-zh-hant-store.sh && chmod +x xray-zh-hant-store.sh && sudo ./xray-zh-hant-store.sh
elif [[ $choice == "00" ]]; then
  echo -e "\e[1m\e[93m
請選擇您要執行的任務：
    \e[0m"
  echo "1. 查看系統日誌"
  echo "2. 查看用戶和群組"
  echo "3. 修改系統語言"
  echo "log. 更新紀錄"
  echo -e "\e[1m\e[32m0. 返回上一級菜單\e[0m"
  read -p "請輸入：" next_choice

  if [[ $next_choice == "1" ]]; then
    echo -e "\e[1m\e[93m您的系統日誌如下：\e[0m"
    cat /var/log/syslog
    read -n 1 -p "按任意按鍵以繼續"
    sudo ./xray-zh-hant.sh
  elif [[ $next_choice == "2" ]]; then
    echo -e "\e[1m\e[93m您的所有用戶資訊如下：\e[0m"
    cat /etc/passwd
    echo -e "\e[1m\e[93m您的所有群組資訊如下：\e[0m"
    cat /etc/group
    read -n 1 -p "按任意按鍵以繼續"
    sudo ./xray-zh-hant.sh
  elif [[ $next_choice == "3" ]]; then
    export LANG=zh_TW.UTF-8
  elif [[ $next_choice == "log" ]]; then
    curl -sS -O https://ray000000.github.io/Shell/xray-update-log.sh && chmod +x xray-update-log.sh && sudo ./xray-update-log.sh
  elif [[ $next_choice == "0" ]]; then
    sudo ./xray-zh-hant.sh
  else
    echo -e "\e[1m\e[31m錯誤：無效選項\e[0m"
    read -n 1 -p "按任意按鍵以繼續"
    sudo ./xray-zh-hant.sh
  fi

elif [[ $choice == "0" ]]; then
  exit
else
  echo -e "\e[1m\e[31m錯誤：無效選項\e[0m"
  read -n 1 -p "按任意按鍵以繼續"
  sudo ./xray-zh-hant.sh
fi