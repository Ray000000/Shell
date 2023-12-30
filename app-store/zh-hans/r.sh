#!/bin/bash
clear

script_name="${0##*/}"
deplay_name="${script_name%.sh}"
deplay_name_upper=$(echo "${deplay_name}" | tr 'a-z' 'A-Z')
language="zh-cn"

update_message=$(curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/xray-update-message.sh | awk '/echo -e ".*"/ {print}')
if [[ -n "${update_message}" ]]; then
  eval "${update_message}"
fi

local_dir0="app-store/app/xray-${language}"
local_dir1="./xray-shell/app-store/app"
local_dir2="./xray-shell/app-store/${language}"

if [ ! -d "${local_dir1}" ]; then
  mkdir -p "${local_dir1}"
  chmod +x "${local_dir1}"
else
  chmod +x "${local_dir1}"
fi

echo -e "\e[1m\e[34m
    _/      _/  _/_/_/                        
     _/  _/    _/    _/    _/_/_/  _/    _/        ______   _    _   ______  ______  _       
      _/      _/_/_/    _/    _/  _/    _/        / |      | |  | | | |     | |     | |      
   _/  _/    _/    _/  _/    _/  _/    _/         '------. | |--| | | |---- | |---- | |   _  
_/      _/  _/    _/    _/_/_/    _/_/_/           ____|_/ |_|  |_| |_|____ |_|____ |_|__|_|   〔简体中文版〕
                                     _/       
                                _/_/ \e[0m"

echo -e "\e[1m\e[93m
以下是以 [${deplay_name_upper}${deplay_name}] 开头的应用程序：
\e[0m"

app_list_url="https://raw.githubusercontent.com/Ray000000/Shell/main/app-store/${language}/app.txt"
app_list_raw=$(curl -sS "${app_list_url}" | grep -E "^xray-${language}-[${deplay_name_upper}${deplay_name}].*\.sh$")

if [[ -z "${app_list_raw}" ]]; then
  echo -e "\e[1m\e[31m找不到相关应用程序\e[0m"
else
  index=1
  while IFS= read -r app; do
    display_name=$(echo "${app}" | sed -E "s/xray-${language}-(.*)\.sh/\1/")
    echo "$index. ${display_name}"
    ((index++))
  done <<< "${app_list_raw}"
  echo -e "\e[1m\e[32m0. Exit\e[0m"
  
  read -p "请输入：" choice
  
  if ! [[ "${choice}" =~ ^[0-9]+$ ]]; then
    echo -e "\e[1m\e[31m错误：无效选项\e[0m"
    read -n 1 -p "按任意键以继续"
    sudo "${local_dir2}/${script_name}"
  fi

  if [[ "${choice}" == "0" ]]; then
    exit
  elif (( choice > 0 && choice <= index - 1 )); then
    selected_app=$(echo "${app_list_raw}" | sed -n "${choice}p" | sed -E "s/xray-${language}-(.*)\.sh/\1/")
    curl -sS "https://raw.githubusercontent.com/Ray000000/Shell/main/${local_dir0}-${selected_app}.sh" -o "./xray-shell/${local_dir0}-${selected_app}.sh" && chmod +x "./xray-shell/${local_dir0}-${selected_app}.sh" && sudo "./xray-shell/${local_dir0}-${selected_app}.sh"
  else
    echo -e "\e[1m\e[31m错误：无效选项\e[0m"
    read -n 1 -p "按任意键以继续"
    sudo "${local_dir2}/${script_name}"
  fi
fi
