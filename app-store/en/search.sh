#!/bin/bash
clear

script_name="${0##*/}"
language="en"

update_message=$(curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/xray-update-message.sh | awk '/echo -e ".*"/ {print}')
if [[ -n "${update_message}" ]]; then
  eval "${update_message}"
fi

dir="./xray-shell/app-store/app"
local_dir0="./xray-shell/app-store/${language}"
local_dir1="app-store/app/${language}"
local_dir2="./xray-shell/app-store/app/${language}"

if [ ! -d "${dir}" ]; then
  mkdir -p ${dir}
  chmod +x ${dir}
else
  chmod +x ${dir}
fi
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
_/      _/  _/    _/    _/_/_/    _/_/_/           ____|_/ |_|  |_| |_|____ |_|____ |_|__|_|   { English Version }
                                     _/       
                                _/_/ \e[0m"

echo -e "\e[1m\e[93m
Please enter the keyword for the application you want to search:
\e[0m"

read -p "Search:
" search_term

app_list_url="https://raw.githubusercontent.com/Ray000000/Shell/main/app-store/app.txt"
app_list=($(curl -sS "${app_list_url}"))
app_list_processed=()

for app in "${app_list[@]}"; do
  if echo "${app}" | grep -qi "$search_term"; then
    app_list_processed+=("${app}")
  fi
done

if [ "${#app_list_processed[@]}" -eq 0 ]; then
  echo -e "\e[1m\e[31mNo relevant applications found\e[0m"
  read -n 1 -p "Press any key to continue"
  sudo "${local_dir0}/${script_name}"
fi

app_list_processed_sorted=($(echo "${app_list_processed[@]}" | tr ' ' '\n' | sort))

echo -e "\e[1m\e[34mSearch results are as follows:
\e[0m"
for i in "${!app_list_processed_sorted[@]}"; do
  echo "$((i+1)). ${app_list_processed_sorted[i]}"
done
echo -e "\e[1m\e[32m0. Exit\e[0m"
  
read -p "Please enter: " choice

if [[ "$choice" == "0" ]]; then
  exit
elif (( choice > 0 && choice <= ${#app_list_processed_sorted[@]} )); then
  selected_app="${app_list_processed_sorted[choice-1]}"
  curl -sS "https://raw.githubusercontent.com/Ray000000/Shell/main/${local_dir1}-${selected_app}.sh" -o "${local_dir2}-${selected_app}.sh" && chmod +x "${local_dir2}-${selected_app}.sh" && sudo "${local_dir2}-${selected_app}.sh"
else
  echo -e "\e[1m\e[31mError: Invalid option\e[0m"
  read -n 1 -p "Press any key to continue"
  sudo "${local_dir0}/${script_name}"
fi
