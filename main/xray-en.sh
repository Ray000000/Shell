#!/bin/bash

clear
echo -e "\e[1m\e[34m
    _/      _/  _/_/_/                        
     _/  _/    _/    _/    _/_/_/  _/    _/        ______   _    _   ______  ______  _       
      _/      _/_/_/    _/    _/  _/    _/        / |      | |  | | | |     | |     | |      
   _/  _/    _/    _/  _/    _/  _/    _/         '------. | |--| | | |---- | |---- | |   _  
_/      _/  _/    _/    _/_/_/    _/_/_/           ____|_/ |_|  |_| |_|____ |_|____ |_|__|_|   〔English version〕
                                     _/       
                                _/_/ \e[0m"

echo -e "\e[1m\e[93m
Please select the task you want to perform:
\e[0m"
echo "1. Check and update the system"
echo "2. System information"
echo "3. Application store"
echo "00. Advanced options"
echo -e "\e[1m\e[32m0. Exit\e[0m"

read -p "Please input: " choice

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
  sudo apt update -y && apt full-upgrade -y && apt upgrade -y && apt autoremove -y && apt autoclean -y && apt-get install curl wget sudo nano htop socat neofetch -y
  clear
  sudo neofetch

  read -n 1 -p "Press any key to continue."
  sudo ./xray-en.sh
elif [[ $choice == "2" ]]; then
  echo -e "\e[1m\e[93mYour system information is as follows:\e[0m"
  echo "Operating system: $os_info"
  echo "Kernelversion: $(uname -r)"
  echo "CPU model: $cpu_info
  "
  echo "IPv6 location: $(curl -s ipv4.ip.sb)"
  echo "IPv6 location: $(curl -s ipv6.ip.sb)"
  df -h

  read -n 1 -p "Press any key to continue."
  sudo ./xray-en.sh
elif [[ $choice == "3" ]]; then
  curl -sS -O https://ray000000.github.io/Shell/file/en/xray-en-store.sh && chmod +x xray-en-store.sh && sudo ./xray-en-store.sh
elif [[ $choice == "00" ]]; then
  echo -e "\e[1m\e[93m
Please select the task you want to perform:
    \e[0m"
  echo "1. View system logs"
  echo "2. View users and groups"
  echo "3. Modify system language"
  echo "log. Update log"
  echo -e "\e[1m\e[32m0. Return to the previous menu\e[0m"
  read -p "Please input: " next_choice

  if [[ $next_choice == "1" ]]; then
    echo -e "\e[1m\e[93mYour system logs are as follows:\e[0m"
    cat /var/log/syslog
    read -n 1 -p "Press any key to continue."
    sudo ./xray-en.sh
  elif [[ $next_choice == "2" ]]; then
    echo -e "\e[1m\e[93mYour users are as follows:\e[0m"
    cat /etc/passwd
    echo -e "\e[1m\e[93mYour groups are as follows:\e[0m"
    cat /etc/group
    read -n 1 -p "Press any key to continue."
    sudo ./xray-en.sh
  elif [[ $next_choice == "3" ]]; then
    export LANG=en_US.UTF-8
  elif [[ $next_choice == "log" ]]; then
    curl -sS -O https://ray000000.github.io/Shell/xray-update-log.sh && chmod +x xray-update-log.sh && sudo ./xray-update-log.sh
  elif [[ $next_choice == "0" ]]; then
    sudo ./xray-en.sh
  else
    echo -e "\e[1m\e[31mError: Ineffective choices\e[0m"
    read -n 1 -p "Press any key to continue."
    sudo ./xray-en.sh
  fi

elif [[ $choice == "0" ]]; then
  exit
else
  echo -e "\e[1m\e[31mError: Ineffective choices\e[0m"
  read -n 1 -p "Press any key to continue."
  sudo ./xray-en.sh
fi
