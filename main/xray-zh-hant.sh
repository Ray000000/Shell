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
  commands=(
    "if [ -f "/etc/debian_version" ]; then"
      "DEBIAN_FRONTEND=noninteractive apt update -y"
      "DEBIAN_FRONTEND=noninteractive apt full-upgrade -y"
      "DEBIAN_FRONTEND=noninteractive apt upgrade -y"
      "DEBIAN_FRONTEND=noninteractive apt autoremove -y"
      "DEBIAN_FRONTEND=noninteractive apt autoclean -y"
      "DEBIAN_FRONTEND=noninteractive apt-get install -y curl wget sudo nano htop socat neofetch"
    "fi"
    "if [ -f "/etc/redhat-release" ]; then"
      "yum -y update"
      "yum -y install curl wget sudo nano htop socat neofetch"
    "fi"
  )

  total_commands=${#commands[@]}

    for ((i = 0; i < total_commands; i++)); do
      command="${commands[i]}"
      eval $command
        percentage=$(( (i + 1) * 100 / total_commands ))
        completed=$(( percentage / 2 ))
        remaining=$(( 50 - completed ))
        progressBar="["
        for ((j = 0; j < completed; j++)); do
          progressBar+="#"
        done
        for ((j = 0; j < remaining; j++)); do
          progressBar+="-"
        done
        progressBar+="]"
        echo -ne "\r\e[1m\e[93m\e[1m\e[32m[$percentage%]\e[0m $progressBar\e[0m"
      done

      echo

  clear
  sudo neofetch

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
  echo "3. 安裝系統"
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
    curl -sS -O https://ray000000.github.io/Shell/file/zh-hant/xray-zh-hant-install.sh && chmod +x xray-zh-hant-install.sh && sudo ./xray-zh-hant-install.sh
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