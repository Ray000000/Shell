#!/bin/bash
clear

script_name="${0##*/}"
language="en"
deploy_name="${script_name%.sh}"
deploy_name_upper=$(echo "${deploy_name}" | tr 'a-z' 'A-Z')

update_message=$(curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/xray-update-message.sh | awk '/echo -e ".*"/ {print}')
if [[ -n "${update_message}" ]]; then
  eval "${update_message}"
fi

local_dir_lang="./xray-shell/app-store/app/${language}"
local_dir0="app-store/app"
local_dir1="./xray-shell/${local_dir0}"
local_dir2="./xray-shell/app-store/${language}"

if [ ! -d "${local_dir1}" ]; then
  mkdir -p ${local_dir1}
  chmod +x ${local_dir1}
else
  chmod +x ${local_dir1}
fi

echo -e "\e[1m\e[34m
    _/      _/  _/_/_/                        
     _/  _/    _/    _/    _/_/_/  _/    _/        ______   _    _   ______  ______  _       
      _/      _/_/_/    _/    _/  _/    _/        / |      | |  | | | |     | |     | |      
   _/  _/    _/    _/  _/    _/  _/    _/         '------. | |--| | | |---- | |---- | |   _  
_/      _/  _/    _/    _/_/_/    _/_/_/           ____|_/ |_|  |_| |_|____ |_|____ |_|__|_|   { English Version }
                                     _/       
                                _/_/ \e[0m"

echo -e "\e[1m\e[93mThe following applications start with [${deploy_name_upper}${deploy_name}]:
\e[0m"

app_list_url="https://raw.githubusercontent.com/Ray000000/Shell/main/app-store/app.txt"
app_list=($(curl -sS "${app_list_url}" | grep -E "^(${deploy_name_upper}|${deploy_name})"))

if [ "${#app_list[@]}" -eq 0 ]; then
  echo -e "\e[1m\e[31mNo relevant applications found\e[0m"
  read -n 1 -p "Press any key to continue"
  sudo "${local_dir2}/${script_name}"
fi

for i in "${!app_list[@]}"; do
  echo "$((i+1)). ${app_list[i]}"
done
echo -e "\e[1m\e[32m0. Exit\e[0m"

read -p "Please enter: " choice

if [[ "${choice}" == "0" ]]; then
  exit
elif (( choice > 0 && choice <= ${#app_list[@]} )); then
  selected_app="${app_list[choice-1]}"
  curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/app-store/app/${language}-${selected_app}.sh -o ${local_dir_lang}-${selected_app}.sh && chmod +x ${local_dir_lang}-${selected_app}.sh && sudo ${local_dir_lang}-${selected_app}.sh
else
  echo -e "\e[1m\e[31mError: Invalid option\e[0m"
  read -n 1 -p "Press any key to continue"
  sudo "${local_dir2}/${script_name}"
fi
