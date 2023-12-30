#!/bin/bash

script_name="${0##*/}"

clear
echo -e "\e[1m\e[93m〔Docker〕\e[0m"
echo "
Docker 是一种开源软件平台，可让您快速地建立、测试和部署应用程序。Docker 将软件封装到名为容器的标准化单位，其中包含程序库、系统工具、代码和执行所需的所有项目。使用 Docker，您可以快速地部署应用程序到各种环境并加以扩展，而且知道代码可以运行。
Docker 容器是一种轻量级的虚拟化解决方案，它们比传统的虚拟机更小、更快、更易于管理。容器共享主机的操作系统内核，这使得它们可以更有效地使用资源。
Docker 有许多优点，包括：

* 可移植性：容器可以运行在任何支持 Linux 的环境中。
* 效率：容器共享主机的操作系统内核，这使得它们可以更有效地使用资源。
* 可扩展性：容器可以轻松地扩展和缩减，以满足需求。
* 安全性：容器可以隔离彼此，这有助于防止安全漏洞的传播。

Docker 被广泛使用于各种行业，包括开发、运营和安全。它已成为现代软件开发和部署的关键工具。"
echo "----------------------------------------"
echo "官方网站：
https://www.docker.com/"
echo -e "\e[1m\e[93m
请选择您要执行的任务：
\e[0m"
echo "1.  安装"
echo "2.  更新"
echo "3.  解除安装"
echo -e "\e[1m\e[31m4.  解除安装（不保存数据）\e[0m"
echo "5.  查看版本"
echo "6.  简易操作"
echo "00. 设置快捷方式"
echo -e "\e[1m\e[32m0. 返回菜单\e[0m"

read -p "请输入：" choice
#--------------------------------------------------choice-------------------------------------------------------#
if [[ $choice == "1" ]]; then
  echo -e "\e[1m\e[34mY. 确认安装\e[0m"
  echo -e "\e[1m\e[31mN. 取消安装\e[0m"
  read -p "请输入：" yn_choice
elif [[ $choice == "2" ]]; then
  sudo apt-get update -y && sudo apt-get upgrade docker-ce -y && sudo apt-get upgrade docker-compose -y
  read -n 1 -p "按任意键以继续"
  sudo ./${script_name}
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
  sudo ./${script_name}
elif [[ $choice == "6" ]]; then
  echo -e "\e[1m\e[93m
请选择您要执行的操作：
\e[0m"
  echo "1.  启动容器　｜　6.  自启容器"
  echo "2.  重启容器　｜　7.  拉取镜像"
  echo "3.  暂停容器　｜　8.  删除镜像"
  echo -e "4.  停止容器　｜　9.  查看日志　｜　\e[1m\e[34m00. 快速启用\e[0m"
  echo -e "5.  删除容器　｜　10. 交互模式　｜　\e[1m\e[32m0. 返回\e[0m"

  read -p "请输入：" next_choice
elif [[ $choice == "00" ]]; then
  read -p "请输入快捷键：" choice1
  echo "alias $choice1='curl -sS -O https://ray000000.github.io/Shell/file/zh-hant/app/xray-zh-hant-docker.sh && chmod +x xray-zh-hant-docker.sh && sudo ./xray-zh-hant-docker.sh'" >> ~/.bashrc
  source ~/.bashrc
  read -n 1 -p "按任意键以继续"
  sudo ./${script_name}
elif [[ $choice == "0" ]]; then
  sudo ./xray-zh-hant-store.sh
else
  echo -e "\e[1m\e[31m错误：无效选项\e[0m"
  read -n 1 -p "按任意键，回到菜单"
  sudo ./${script_name}
fi
#--------------------------------------------------choice-------------------------------------------------------#
#--------------------------------------------------next_choice--------------------------------------------------#
  if [[ $next_choice == "1" ]]; then
    echo -e "\e[1m\e[93m您的容器如下：\e[0m"
    docker ps -a
    read -p "请输入启动的容器名称：" choice_docker_start
    docker start $choice_docker_start

    read -n 1 -p "按任意键以继续"
    sudo ./${script_name}

  elif [[ $next_choice == "2" ]]; then
    echo -e "\e[1m\e[93m您的容器如下：\e[0m"
    docker ps -a
    read -p "请输入重启的容器名称：" choice_docker_restart
    docker restart $choice_docker_restart

    read -n 1 -p "按任意键以继续"
    sudo ./${script_name}

  elif [[ $next_choice == "3" ]]; then
    echo -e "\e[1m\e[93m您的容器如下：\e[0m"
    docker ps -s
    read -p "请输入暂停的容器名称：" choice_docker_pause
    docker pause $choice_docker_pause

    read -n 1 -p "按任意键以继续"
    sudo ./${script_name}

  elif [[ $next_choice == "4" ]]; then
    echo -e "\e[1m\e[93m您的容器如下：\e[0m"
    docker ps -s
    read -p "请输入停止的容器名称：" choice_docker_stop
    docker stop $choice_docker_stop

    read -n 1 -p "按任意键以继续"
    sudo ./${script_name}

  elif [[ $next_choice == "5" ]]; then
    echo -e "\e[1m\e[93m您的容器如下：\e[0m"
    docker ps -a
    read -p "请输入删除的容器名称：" choice_docker_rm
    docker rm $choice_docker_rm

    read -n 1 -p "按任意键以继续"
    sudo ./${script_name}

  elif [[ $next_choice == "6" ]]; then
    echo -e "\e[1m\e[93m
请选择您要执行的任务：
      \e[0m"
    echo -e "\e[1m\e[34m1. 开启开机自启\e[0m"
    echo -e "\e[1m\e[31m2. \e[1m\e[31m关闭开机自启\e[0m"
    echo -e "\e[1m\e[32m0. 返回\e[0m"
    read -p "请输入：" next_choice2
  elif [[ $next_choice == "7" ]]; then
    echo -e "\e[1m\e[93m您的镜像列表如下：\e[0m"
    docker image ls
    read -p "请输入拉取的镜像名称：" choice_docker_pull
    docker pull $choice_docker_pull

    read -n 1 -p "按任意键以继续"
    sudo ./${script_name}

  elif [[ $next_choice == "8" ]]; then
    echo -e "\e[1m\e[93m您的镜像列表如下：\e[0m"
    docker image ls
    read -p "请输入删除的镜像名称：" choice_docker_irm
    docker image rm -f $choice_docker_irm

    read -n 1 -p "按任意键以继续"
    sudo ./${script_name}

  elif [[ $next_choice == "9" ]]; then
    echo -e "\e[1m\e[93m您的镜像列表如下：\e[0m"
    docker image ls
    read -p "请输入查看日志的容器名称：" choice_docker_logs
    docker logs $choice_docker_logs

    read -n 1 -p "按任意键以继续"
    sudo ./${script_name}

  elif [[ $next_choice == "10" ]]; then
    echo -e "\e[1m\e[93m您的镜像列表如下：\e[0m"
    docker image ls
    read -p "请输入进入交互模式的容器名称：" choice_docker_exce
    read -p "请输入容器交互模式的指令：" choice_docker_exce_input
    docker exec -it $choice_docker_exce ./$choice_docker_exce $choice_docker_exce_input

    read -n 1 -p "按任意键以继续"
    sudo ./${script_name}
  

  elif [[ $next_choice == "00" ]]; then
    read -p "1. 请输入创建容器的名称：" choice_docker_run_name
    read -p "2. 请输入创建容器的镜像 (格式: ubuntu:15.10)：" choice_docker_run_image
    read -p "3. 请输入创建容器的通讯端口号：" choice_docker_run_port
    read -p "4. 请输入创建容器的参数 (Ex: i=交互式操作, t=终端, d=背景运行，可以用 itd 来运行 3 项)：" choice_docker_run
    docker run -$choice_docker_run --name $choice_docker_run_name -p $choice_docker_run_port $choice_docker_run_image

    read -n 1 -p "按任意键以继续"
    sudo ./${script_name}

  elif [[ $next_choice == "0" ]]; then
    sudo ./${script_name}

  else
    echo -e "\e[1m\e[31m错误：无效选项\e[0m"
    read -n 1 -p "按任意键以继续"
    sudo ./${script_name}
  fi
#--------------------------------------------------next_choice--------------------------------------------------#
#--------------------------------------------------next_choice2-------------------------------------------------#
    if [[ $next_choice2 == "1" ]]; then
      echo -e "\e[1m\e[93m您的容器如下：\e[0m"
      docker ps -a
      read -p "请输入开启开机自启容器的名称：" choice_docker_auto_restart_on
      docker update --restart=always $choice_docker_auto_restart_on

      read -n 1 -p "按任意键以继续"
      sudo ./${script_name}
    elif [[ $next_choice2 == "2" ]]; then
      echo -e "\e[1m\e[93m您的容器如下：\e[0m"
      docker ps -a
      read -p "请输入关闭开机自启容器的名称：" choice_docker_auto_restart_off
      docker update --restart=no $choice_docker_auto_restart_off

      read -n 1 -p "按任意键以继续"
      sudo ./${script_name}
    elif [[ $next_choice2 == "0" ]]; then
      sudo ./${script_name}
    else
      echo -e "\e[1m\e[31m错误：无效选项\e[0m"
      read -n 1 -p "按任意键以继续"
      sudo ./${script_name}
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

    read -n 1 -p "按任意键以继续"
    sudo ./${script_name}
    ;;
  [Nn])
    sudo ./${script_name}
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

    read -n 1 -p "按任意键以继续"
    sudo ./${script_name}
    ;;
  [Nn])
    sudo ./${script_name}
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

    read -n 1 -p "按任意键以继续"
    sudo ./${script_name}
    ;;
  [Nn])
    sudo ./${script_name}
    ;;
esac