#!/bin/bash

script_name="${0##*/}"

clear
echo -e "\e[1m\e[93m〔AriaNG〕\e[0m"
echo "
AriaNG 是讓你在網頁上管理下載的工具。

它可以用來：

* 添加、刪除、暫停、恢復、修改下載任務
* 查看下載進度、速度、完成時間等信息
* 設置下載配置，例如下載目錄、代理、速度限制等

AriaNG 適合：

* 個人使用
* 企業使用

以下是一些常見的使用場景：

* 在多個設備上管理下載
* 使用 Aria2 的多種功能
* 在企業內部加速下載

如果你符合其中任何一個條件，那麼 AriaNG 是一個不錯的選擇。。
\e[1m\e[34m注意：此版本非官方，請小心使用！\e[0m"
echo "----------------------------------------"
echo "第三方網站：
https://github.com/P3TERX/aria2.sh"
echo -e "\e[1m\e[93m
請選擇您要執行的任務：
\e[0m"
echo "1. 使用"
echo -e "\e[1m\e[32m0. 回到菜單\e[0m"

read -p "請輸入：" choice

if [[ $choice == "1" ]]; then
  echo -e "\e[1m\e[34mY. 確認使用\e[0m"
  echo -e "\e[1m\e[31mN. 取消使用\e[0m"
  read -p "請輸入：" yn_choice
elif [[ $choice == "0" ]]; then
  sudo ./xray-zh-hant-store.sh
else
  echo -e "\e[1m\e[31m錯誤：無效選項\e[0m"
  read -n 1 -p "按任意按鍵，回到菜單"
  sudo ./${script_name}
fi

case $yn_choice in
  [Yy])
    apt install sudo wget curl ca-certificates
    wget -N git.io/aria2.sh && chmod +x aria2.sh
    ./aria2.sh

    read -n 1 -p "按任意按鍵以繼續"
    sudo ./${script_name}
    ;;
  [Nn])
    sudo ./${script_name}
    ;;
esac
