#!/bin/bash

clear
echo -e "\e[1m\e[93m〔Docker〕\e[0m"
echo "
Docker 是一種開源軟體平台，可讓您快速地建立、測試和部署應用程式。Docker 將軟體封裝到名為容器的標準化單位，其中包含程式庫、系統工具、程式碼和執行時間等執行軟體所需的所有項目。使用Docker，您可以將應用程式快速地部署到各種環境並加以擴展，而且知道程式碼可以執行。
Docker 容器是一種輕量級的虛擬化解決方案，它們比傳統的虛擬機器更小、更快、更易於管理。容器共享主機的作業系統內核，這使得它們可以更有效地使用資源。
Docker 有許多優點，包括：
*可移植性：容器可以運行在任何支援 Linux 的環境中。
*效率：容器共享主機的作業系統內核，這使得它們可以更有效地使用資源。
*可擴展性：容器可以輕鬆地擴展和縮減，以滿足需求。
*安全性：容器可以隔離彼此，這有助於防止安全漏洞的傳播。
Docker 被廣泛使用於各種行業，包括開發、運營和安全。它已成為現代軟體開發和部署的關鍵工具。"
echo "----------------------------------------"
echo "官方網站：
https://www.docker.com/"
echo -e "\e[1m\e[93m
請選擇您要執行的任務：
\e[0m"
echo "1. 安裝"
echo "2. 更新"
echo "3. 解除安裝"
echo -e "\e[1m\e[31m4. 解除安裝（不保存資料）\e[0m"
echo "5. 查看版本"
echo "6. 簡易操作"
echo "00. 設定快捷方式"
echo -e "\e[1m\e[32m0. 回到菜單\e[0m"

read -p "請輸入：" choice
#--------------------------------------------------choice-------------------------------------------------------#
if [[ $choice == "1" ]]; then
  echo -e "\e[1m\e[34mY. 確認安裝\e[0m"
  echo -e "\e[1m\e[31mN. 取消安裝\e[0m"
  read -p "請輸入：" yn_choice
elif [[ $choice == "2" ]]; then
  sudo apt-get update -y && sudo apt-get upgrade docker-ce -y && sudo apt-get upgrade docker-compose -y
  read -n 1 -p "按任意按鍵以繼續"
  sudo ./xray-zh-hant-docker.sh
elif [[ $choice == "3" ]]; then
  echo -e "\e[1m\e[34mY. 確認解除安裝\e[0m"
  echo -e "\e[1m\e[31mN. 取消解除安裝\e[0m"
  read -p "請輸入：" yn2_choice
elif [[ $choice == "4" ]]; then
  echo -e "\e[1m\e[34mY. 確認解除安裝\e[0m"
  echo -e "\e[1m\e[31mN. 取消解除安裝\e[0m"
  read -p "請輸入：" yn3_choice
elif [[ $choice == "5" ]]; then
  docker --version
  docker-compose --version
  read -n 1 -p "按任意按鍵以繼續"
  sudo ./xray-zh-hant-docker.sh
elif [[ $choice == "6" ]]; then
  echo -e "\e[1m\e[93m
請選擇您要執行的操作：
\e[0m"
  echo "1. 啟動容器　｜　6. 自啟容器"
  echo "2. 重啟容器　｜　7. 拉取鏡像"
  echo "3. 暫停容器　｜　8. 刪除鏡像"
  echo -e "4. 停止容器　｜　\e[1m\e[34m9. 快速啟用\e[0m"
  echo -e "5. 刪除容器　｜　\e[1m\e[32m0. 返回\e[0m"

  read -p "請輸入：" next_choice
elif [[ $choice == "00" ]]; then
  read -p "請輸入快捷鍵：" choice1
  echo "alias $choice1='curl -sS -O https://raw.githubusercontent.com/Ray000000/Shell/file/zh-hant/app/xray-zh-hant-docker.sh && chmod +x xray-zh-hant-docker.sh && sudo ./xray-zh-hant-docker.sh'" >> ~/.bashrc
  source ~/.bashrc
  read -n 1 -p "按任意按鍵以繼續"
  sudo ./xray-zh-hant-docker.sh
elif [[ $choice == "0" ]]; then
  sudo ./xray-zh-hant-store-d.sh
else
  echo -e "\e[1m\e[31m錯誤：無效選項\e[0m"
  read -n 1 -p "按任意按鍵，回到菜單"
  sudo ./xray-zh-hant-docker.sh
fi
#--------------------------------------------------choice-------------------------------------------------------#
#--------------------------------------------------next_choice--------------------------------------------------#
  if [[ $next_choice == "1" ]]; then
    echo -e "\e[1m\e[93m您的容器如下：\e[0m"
    docker ps -a
    read -p "請輸入啟動容器的名稱：" choice_docker_start
    docker start $choice_docker_start

    read -n 1 -p "按任意按鍵以繼續"
    sudo ./xray-zh-hant-docker.sh

  elif [[ $next_choice == "2" ]]; then
    echo -e "\e[1m\e[93m您的容器如下：\e[0m"
    docker ps -a
    read -p "請輸入重啟容器的名稱：" choice_docker_restart
    docker restart $choice_docker_restart

    read -n 1 -p "按任意按鍵以繼續"
    sudo ./xray-zh-hant-docker.sh

  elif [[ $next_choice == "3" ]]; then
    echo -e "\e[1m\e[93m您的容器如下：\e[0m"
    docker ps -s
    read -p "請輸入暫停容器的名稱：" choice_docker_pause
    docker pause $choice_docker_pause

    read -n 1 -p "按任意按鍵以繼續"
    sudo ./xray-zh-hant-docker.sh

  elif [[ $next_choice == "4" ]]; then
    echo -e "\e[1m\e[93m您的容器如下：\e[0m"
    docker ps -s
    read -p "請輸入停止容器的名稱：" choice_docker_stop
    docker stop $choice_docker_stop

    read -n 1 -p "按任意按鍵以繼續"
    sudo ./xray-zh-hant-docker.sh

  elif [[ $next_choice == "5" ]]; then
    echo -e "\e[1m\e[93m您的容器如下：\e[0m"
    docker ps -a
    read -p "請輸入刪除容器的名稱：" choice_docker_rm
    docker rm $choice_docker_rm

    read -n 1 -p "按任意按鍵以繼續"
    sudo ./xray-zh-hant-docker.sh

  elif [[ $next_choice == "6" ]]; then
    echo -e "\e[1m\e[93m
請選擇您要執行的任務：
      \e[0m"
    echo -e "\e[1m\e[34m1. 開啟開機自啟\e[0m"
    echo -e "\e[1m\e[31m2. \e[1m\e[31m關閉開機自啟\e[0m"
    echo -e "\e[1m\e[32m0. 返回\e[0m"
    read -p "請輸入：" next_choice2
  elif [[ $next_choice == "7" ]]; then
    echo -e "\e[1m\e[93m您的鏡像列表如下：\e[0m"
    docker image ls
    read -p "請輸入拉取鏡像的名稱：" choice_docker_pull
    docker pull $choice_docker_pull

    read -n 1 -p "按任意按鍵以繼續"
    sudo ./xray-zh-hant-docker.sh

  elif [[ $next_choice == "8" ]]; then
    echo -e "\e[1m\e[93m您的鏡像列表如下：\e[0m"
    docker image ls
    read -p "請輸入刪除鏡像的名稱：" choice_docker_irm
    docker image rm -f $choice_docker_irm

    read -n 1 -p "按任意按鍵以繼續"
    sudo ./xray-zh-hant-docker.sh

  elif [[ $next_choice == "9" ]]; then
    read -p "1. 請輸入創建容器的名稱：" choice_docker_run_name
    read -p "2. 請輸入創建容器的鏡像 (格式: ubuntu:15.10)：" choice_docker_run_image
    read -p "3. 請輸入創建容器的通訊端口號：" choice_docker_run_port
    read -p "4. 請輸入創建容器的參數 (Ex: i=交互式操作, t=終端, d=背景運行，可以用 itd 來運行 3 項)：" choice_docker_run
    docker run -$choice_docker_run --name $choice_docker_run_name -p $choice_docker_run_port $choice_docker_run_image

    read -n 1 -p "按任意按鍵以繼續"
    sudo ./xray-zh-hant-docker.sh

  elif [[ $next_choice == "0" ]]; then
    sudo ./xray-zh-hant-docker.sh

  else
    echo -e "\e[1m\e[31m錯誤：無效選項\e[0m"
    read -n 1 -p "按任意按鍵以繼續"
    sudo ./xray-zh-hant-docker.sh
  fi
#--------------------------------------------------next_choice--------------------------------------------------#
#--------------------------------------------------next_choice2-------------------------------------------------#
    if [[ $next_choice2 == "1" ]]; then
      echo -e "\e[1m\e[93m您的容器如下：\e[0m"
      docker ps -a
      read -p "請輸入開啟開機自啟容器的名稱：" choice_docker_auto_restart_on
      docker update --restart=always $choice_docker_auto_restart_on

      read -n 1 -p "按任意按鍵以繼續"
      sudo ./xray-zh-hant-docker.sh
    elif [[ $next_choice2 == "2" ]]; then
      echo -e "\e[1m\e[93m您的容器如下：\e[0m"
      docker ps -a
      read -p "請輸入關閉開機自啟容器的名稱：" choice_docker_auto_restart_off
      docker update --restart=no $choice_docker_auto_restart_off

      read -n 1 -p "按任意按鍵以繼續"
      sudo ./xray-zh-hant-docker.sh
    elif [[ $next_choice2 == "0" ]]; then
      sudo ./xray-zh-hant-docker.sh
    else
      echo -e "\e[1m\e[31m錯誤：無效選項\e[0m"
      read -n 1 -p "按任意按鍵以繼續"
      sudo ./xray-zh-hant-docker.sh
    fi
#--------------------------------------------------next_choice2--------------------------------------------------#
#--------------------------------------------------yn_choice----------------------------------------------------#
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
    systemctl start docker
    systemctl enable docker

    read -n 1 -p "按任意按鍵以繼續"
    sudo ./xray-zh-hant-docker.sh
    ;;
  [Nn])
    sudo ./xray-zh-hant-docker.sh
    ;;
esac
#--------------------------------------------------yn2_choice---------------------------------------------------#
case $yn2_choice in
  [Yy])
    sudo apt-get remove docker -y
    sudo apt-get remove docker-ce -y
    sudo apt-get purge docker-ce -y
    sudo rm -rf /var/lib/docker
    sudo rm /usr/local/bin/docker-compose

    read -n 1 -p "按任意按鍵以繼續"
    sudo ./xray-zh-hant-docker.sh
    ;;
  [Nn])
    sudo ./xray-zh-hant-docker.sh
    ;;
esac
#--------------------------------------------------yn3_choice---------------------------------------------------#
case $yn3_choice in
  [Yy])
    docker rm $(docker ps -a -q) && docker rmi $(docker images -q) && docker network prune
    sudo apt-get remove docker -y
    sudo apt-get remove docker-ce -y
    sudo apt-get purge docker-ce -y
    sudo rm -rf /var/lib/docker
    sudo rm /usr/local/bin/docker-compose

    read -n 1 -p "按任意按鍵以繼續"
    sudo ./xray-zh-hant-docker.sh
    ;;
  [Nn])
    sudo ./xray-zh-hant-docker.sh
    ;;
esac