#!/bin/bash
clear

script_name="${0##*/}"
language="zh-hant"

update_message=$(curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/xray-update-message.sh | awk '/echo -e ".*"/ {print}')
if [[ -n "${update_message}" ]]; then
  eval "${update_message}"
fi

local_dir0="./xray-shell/app-store/${language}"
local_dir1="app-store/app/${language}"
local_dir2="./xray-shell/app-store/app/${language}"

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

echo -e "\e[1m\e[93m
請輸入您想搜尋的應用程式關鍵字：
\e[0m"

read -p "搜尋：" search_term

app_list_url="https://raw.githubusercontent.com/Ray000000/Shell/main/app-store/app.txt"
app_list=($(curl -sS "${app_list_url}"))
app_list_processed=()

for app in "${app_list[@]}"; do
  if echo "${app}" | grep -qi "$search_term"; then
    app_list_processed+=("${app}")
  fi
done

if [ "${#app_list_processed[@]}" -eq 0 ]; then
  echo -e "\e[1m\e[31m查無相關應用程式\e[0m"
  read -n 1 -p "按任意按鍵以繼續"
  sudo "${local_dir0}/${script_name}"
fi

app_list_processed_sorted=($(echo "${app_list_processed[@]}" | tr ' ' '\n' | sort))

echo -e "\e[1m\e[34m搜尋結果如下：
\e[0m"
for i in "${!app_list_processed_sorted[@]}"; do
  echo "$((i+1)). ${app_list_processed_sorted[i]}"
done
echo -e "\e[1m\e[32m0. Exit\e[0m"
  
read -p "請輸入：" choice

if [[ "${choice}" == "0" ]]; then
  exit
elif (( choice > 0 && choice <= ${#app_list_processed_sorted[@]} )); then
  selected_app="${app_list_processed_sorted[choice-1]}"
  curl -sS "https://raw.githubusercontent.com/Ray000000/Shell/main/${local_dir1}-${selected_app}.sh" -o "${local_dir2}-${selected_app}.sh" && chmod +x "${local_dir2}-${selected_app}.sh" && sudo "${local_dir2}-${selected_app}.sh"
else
  echo -e "\e[1m\e[31m錯誤：無效選項\e[0m"
  read -n 1 -p "按任意按鍵以繼續"
  sudo "${local_dir0}/${script_name}"
fi
