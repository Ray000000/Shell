#!/bin/bash
clear

script_name="${0##*/}"
language="zh-hant"
deplay_name="${script_name%.sh}"
deplay_name_upper=$(echo "${deplay_name}" | tr 'a-z' 'A-Z')

update_message=$(curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/xray-update-message.sh | awk '/echo -e ".*"/ {print}')
if [[ -n "${update_message}" ]]; then
  eval "${update_message}"
fi

local_dir0="./xray-shell/app-store/app/${language}"
local_dir1="app-store/app/${language}"
local_dir2="./xray-shell/${language}"

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
_/      _/  _/    _/    _/_/_/    _/_/_/           ____|_/ |_|  |_| |_|____ |_|____ |_|__|_|   〔繁體中文版〕
                                     _/       
                                _/_/ \e[0m"

echo -e "\e[1m\e[93m以下是以 [${deplay_name_upper}${deplay_name}] 開頭的應用程式：
\e[0m"

app_list_url="https://raw.githubusercontent.com/Ray000000/Shell/main/app-store/app.txt"
app_list=($(curl -sS "${app_list_url}" | grep -E "^(${deplay_name_upper}|${deplay_name})"))

if [ "${#app_list[@]}" -eq 0 ]; then
  echo -e "\e[1m\e[31m查無相關應用程式\e[0m"
  read -n 1 -p "按任意按鍵以繼續"
  sudo "${local_dir2}/${script_name}"
fi

for i in "${!app_list[@]}"; do
  echo "$((i+1)). ${app_list[i]}"
done
echo -e "\e[1m\e[32m0. Exit\e[0m"

read -p "請輸入：" choice

if [[ "${choice}" == "0" ]]; then
  exit
elif (( choice > 0 && choice <= ${#app_list[@]} )); then
  selected_app="${app_list[choice-1]}"
  curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/${local_dir1}-${selected_app}.sh -o ${local_dir0}-${selected_app}.sh && chmod +x ${local_dir0}-${selected_app}.sh && sudo ${local_dir0}-${selected_app}.sh
else
  echo -e "\e[1m\e[31m錯誤：無效選項\e[0m"
  read -n 1 -p "按任意按鍵以繼續"
  sudo "${local_dir2}/${script_name}"
fi
