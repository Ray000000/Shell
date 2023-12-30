#!/bin/bash
clear

script_name="${0##*/}"

update_message=$(curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/xray-update-message.sh | awk '/echo -e ".*"/ {print}')
if [[ -n "$update_message" ]]; then
  eval "$update_message"
fi

script_urls=(
  "https://raw.githubusercontent.com/Ray000000/Shell/main/main/xray-en.sh"
  "https://raw.githubusercontent.com/Ray000000/Shell/main/main/xray-zh-hant.sh"
  "https://raw.githubusercontent.com/Ray000000/Shell/main/main/xray-zh-hans.sh"
)
local_dir="./xray-shell"
mkdir -p "${local_dir}"
chmod +x "${local_dir}"

echo -e "\e[1m\e[34m
    _/      _/  _/_/_/                        
     _/  _/    _/    _/    _/_/_/  _/    _/        ______   _    _   ______  ______  _       
      _/      _/_/_/    _/    _/  _/    _/        / |      | |  | | | |     | |     | |      
   _/  _/    _/    _/  _/    _/  _/    _/         '------. | |--| | | |---- | |---- | |   _  
_/      _/  _/    _/    _/_/_/    _/_/_/           ____|_/ |_|  |_| |_|____ |_|____ |_|__|_| 
                                     _/       
                                _/_/ \e[0m"

echo -e "\e[1m\e[93m
Choose your language:
\e[0m"

for ((i=0; i<${#script_urls[@]}; i++)); do
  case $i in
    0) option="English";;
    1) option="繁體中文";;
    2) option="简体中文";;
  esac
  echo "$((i+1)). $option"
done
echo -e "\e[1m\e[32m0. Exit\e[0m"

read -p "Please input: " choice

if [[ $choice -ge 1 && $choice -le ${#script_urls[@]} ]]; then
  selected_script="${script_urls[$((choice-1))]}"
  script_name=$(basename "${selected_script}")
  curl -sS "${selected_script}" -o "${local_dir}/${script_name}"

  chmod +x "${local_dir}/${script_name}"

  "${local_dir}/${script_name}"

elif [[ $choice == "0" ]]; then
  exit
else
  echo -e "\e[1m\e[31mError: Ineffective choices\e[0m"
  read -n 1 -p "Press any key to return to the menu."
  sudo ./${script_name}
fi
