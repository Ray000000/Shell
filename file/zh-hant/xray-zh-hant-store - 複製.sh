#!/bin/bash

script_name="${0##*/}"
echo "${script_name} started: $(date)" >> ./xray-log.txt

clear

update_message=$(curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/xray-update-message.sh | awk '/echo -e ".*"/ {print}')

if [[ -n "$update_message" ]]; then
  eval "$update_message"
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
請選擇您要安裝應用程式：
\e[0m"

# List all available apps from xray-hant-app.txt
app_list=$(curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/file/zh-hant/xray-hant-app.txt)

# Display the app list with numbers
index=1
while IFS= read -r app; do
  echo "$index. $app"
  ((index++))
done <<< "$app_list"

echo -e "\e[1m\e[32m0. Exit\e[0m"

read -p "請輸入：" choice

if [[ $choice == "0" ]]; then
  exit
fi

# Get the selected app name
selected_app=$(echo "$app_list" | sed -n "${choice}p")

# Execute the selected app
curl -sS -O "https://raw.githubusercontent.com/Ray000000/Shell/main/file/zh-hant/app/xray-zh-hant-${selected_app}" && chmod +x "xray-zh-hant-${selected_app}" && sudo "./xray-zh-hant-${selected_app}"

echo "${script_name} ended: $(date)" >> ./xray-log.txt
