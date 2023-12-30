#!/bin/bash
clear

script_name="${0##*/}"
language="en"

update_message=$(curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/xray-update-message.sh | awk '/echo -e ".*"/ {print}')
if [[ -n "${update_message}" ]]; then
  eval "${update_message}"
fi

local_dir0="./xray-shell/app-store/${language}"
local_dir1="./xray-shell/language"
if [ ! -d "${local_dir0}" ]; then
  mkdir -p ${local_dir0}
  chmod +x ${local_dir0}
else
  chmod +x ${local_dir0}
fi

echo -e "\e[1m\e[34m
    _/      _/  _/_/_/                        
     _/  _/    _/    _/    _/_/_/  _/    _/        ______   _    _   ______  ______  _       
      _/      _/_/_/    _/    _/  _/    _/        / |      | |  | | | |     | |     | |      
   _/  _/    _/    _/  _/    _/  _/    _/         '------. | |--| | | |---- | |---- | |   _  
_/      _/  _/    _/    _/_/_/    _/_/_/           ____|_/ |_|  |_| |_|____ |_|____ |_|__|_|   [English Version]
                                     _/       
                                _/_/ \e[0m"

echo -e "\e[1m\e[93m
Please choose the task you want to perform:
\e[0m"
echo "1. Check and update the system"
echo "2. System information"
echo "3. App store"
echo "4. Allow root login"
echo "5. Set up Shell shortcut"
echo "00. Advanced options"
echo -e "\e[1m\e[32m0. Exit\e[0m"

read -p "Enter your choice: " choice

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

case $choice in
  1)
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
    clear
    sudo neofetch
    read -n 1 -p "Press any key to continue"
    sudo ${local_dir1}/${script_name}
    ;;
  2)
    echo -e "\e[1m\e[93mYour system information is as follows:\e[0m"
    echo "Operating System: $os_info"
    echo "Kernel Version: $(uname -r)"
    echo "CPU Model: $cpu_info
    "
    echo "IPv4 Address: $(curl -s ipv4.ip.sb)"
    echo "IPv6 Address: $(curl -s ipv6.ip.sb)"
    df -h
    read -n 1 -p "Press any key to continue"
    sudo ${local_dir1}/${script_name}
    ;;
  3)
    curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/app-store/${language}/store.sh -o ${local_dir0}/store.sh && chmod +x ${local_dir0}/store.sh && sudo ${local_dir0}/store.sh
    ;;
  4)
    echo "
PermitRootLogin yes
PasswordAuthentication yes" >> /etc/ssh/sshd_config
    /etc/init.d/ssh restart
    ;;
  5)
    read -p "Enter the shortcut key: " choice1
    echo "alias $choice1='curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/language/${script_name} -o ${local_dir1}/${script_name} && chmod +x ${local_dir1}/${script_name} && sudo ${local_dir1}/${script_name}'" >> ~/.bashrc
    sleep 1
    source ~/.bashrc
    ;;
  00)
    echo -e "\e[1m\e[93m
Please choose the task you want to perform:
    \e[0m"
    echo "1. View system logs"
    echo "2. View users and groups"
    echo -e "\e[1m\e[32m0. Back\e[0m"
    read -p "Enter your choice: " next_choice

    case $next_choice in
      1)
        echo -e "\e[1m\e[93mYour system logs are as follows:\e[0m"
        cat /var/log/syslog
        read -n 1 -p "Press any key to continue"
        sudo ${local_dir1}/${script_name}
        ;;
      2)
        echo -e "\e[1m\e[93mAll your user information is as follows:\e[0m"
        cat /etc/passwd
        echo -e "\e[1m\e[93mAll your group information is as follows:\e[0m"
        cat /etc/group
        read -n 1 -p "Press any key to continue"
        sudo ${local_dir1}/${script_name}
        ;;
      0)
        sudo ${local_dir1}/${script_name}
        ;;
      *)
        echo -e "\e[1m\e[31mError: Invalid option\e[0m"
        read -n 1 -p "Press any key to continue"
        sudo ${local_dir1}/${script_name}
        ;;
    esac
    ;;
  0)
    exit
    ;;
  *)
    echo -e "\e[1m\e[31mError: Invalid option\e[0m"
    read -n 1 -p "Press any key to continue"
    sudo ${local_dir1}/${script_name}
    ;;
esac