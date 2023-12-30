#!/bin/bash

script_name="${0##*/}"

clear
echo -e "\e[1m\e[93m〔AriaNG〕\e[0m"
echo "
AriaNG 是一个让你在网页上管理下载的工具。

它可以用来：

* 添加、删除、暂停、恢复、修改下载任务
* 查看下载进度、速度、完成时间等信息
* 设置下载配置，例如下载目录、代理、速度限制等

AriaNG 适合：

* 个人使用
* 企业使用

以下是一些常见的使用场景：

* 在多个设备上管理下载
* 使用 Aria2 的多种功能
* 在企业内部加速下载

如果你符合其中任何一个条件，那么 AriaNG 是一个不错的选择。"
echo "----------------------------------------"
echo "第三方网站：
https://github.com/P3TERX/aria2.sh"
echo -e "\e[1m\e[93m
请选择您要执行的任务：
\e[0m"
echo "1. 使用"
echo -e "\e[1m\e[32m0. 回到菜单\e[0m"

read -p "请输入：" choice

if [[ $choice == "1" ]]; then
  echo -e "\e[1m\e[34mY. 确认使用\e[0m"
  echo -e "\e[1m\e[31mN. 取消使用\e[0m"
  read -p "请输入：" yn_choice
elif [[ $choice == "0" ]]; then
  sudo ./xray-zh-hant-store.sh
else
  echo -e "\e[1m\e[31m错误：无效选项\e[0m"
  read -n 1 -p "按任意键，回到菜单"
  sudo ./${script_name}
fi

case $yn_choice in
  [Yy])
    apt install sudo wget curl ca-certificates
    wget -N git.io/aria2.sh && chmod +x aria2.sh
    ./aria2.sh

    read -n 1 -p "按任意键以继续"
    sudo ./${script_name}
    ;;
  [Nn])
    sudo ./${script_name}
    ;;
esac
