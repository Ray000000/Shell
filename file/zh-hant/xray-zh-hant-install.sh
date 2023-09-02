#!/bin/bash

# 檢查是否有 root 權限
if [[ $EUID -ne 0 ]]; then
  echo "請以 root 身份執行"
  exit 1
fi

# 檢查是否已安裝 dd
if ! command -v dd > /dev/null; then
  echo "dd 工具未安裝"
  exit 1
fi

# 檢查是否已安裝 wget
if ! command -v wget > /dev/null; then
  echo "wget 工具未安裝"
  exit 1
fi

# 檢查是否已安裝 parted
if ! command -v parted > /dev/null; then
  echo "parted 工具未安裝"
  exit 1
fi

# 檢查是否已安裝 cfdisk
if ! command -v cfdisk > /dev/null; then
  echo "cfdisk 工具未安裝"
  exit 1
fi

# 選擇要安裝的系統
echo "請選擇要安裝的系統："
echo "1. Debian"
echo "2. Ubuntu"
echo "3. 退出"
read -p "選擇(1-3): " system

# 下載系統鏡像
if [[ $system -eq 1 ]]; then
  distro="debian"
  image="https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-11.7.0-amd64-netinst.iso"
elif [[ $system -eq 2 ]]; then
  distro="ubuntu"
  image="https://releases.ubuntu.com/22.04/ubuntu-22.04.3-live-server-amd64.iso"
else
  exit 0
fi

echo "正在下載系統鏡像..."
wget -O $image $image

# 準備磁碟
echo "正在準備磁碟..."
parted /dev/sda mklabel gpt
parted /dev/sda mkpart primary ext4 0% 50%
parted /dev/sda mkpart primary ext4 50% 100%
mkfs.ext4 /dev/sda1
mkfs.ext4 /dev/sda2

# 安裝系統
if [[ $system -eq 1 ]]; then
  echo "正在安裝 Debian..."
  dd if=$image of=/dev/sda1 bs=4M
  echo "請按任意鍵繼續安裝..."
  read -p ""
  init 3
elif [[ $system -eq 2 ]]; then
  echo "正在安裝 Ubuntu..."
  dd if=$image of=/dev/sda2 bs=4M
  echo "請按任意鍵繼續安裝..."
  read -p ""
  init 3
fi