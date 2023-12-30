#!/bin/bash

script_name="${0##*/}"

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
請輸入您想搜尋的應用程式關鍵字：
\e[0m"

read -p "搜尋：" search_term

app_list_url="https://raw.githubusercontent.com/Ray000000/Shell/main/file/zh-hant/xray-zh-hant-app.txt"
app_list_raw=$(curl -sS "$app_list_url")
app_list_processed=$(echo "$app_list_raw" | sed 's/xray-zh-hant-\(.*\)\.sh/\1/' | grep -i "$search_term")

if [[ -z "$app_list_processed" ]]; then
  echo -e "\e[1m\e[31m找不到相關應用程式\e[0m"
  read -n 1 -p "按任意按鍵以繼續"
  sudo ./xray-shell/${script_name}
fi

echo -e "\e[1m\e[34m搜尋結果：\e[0m"

index=1
while IFS= read -r app; do
  echo "$index. $app"
  ((index++))
done <<< "$app_list_processed"

echo -e "\e[1m\e[32m0. Exit\e[0m"

read -p "請輸入：" choice

case $choice in
  0)
    exit
    ;;
  [1-9]|10|log)
    selected_app=$(echo "$app_list_processed" | sed -n "${choice}p")
    ;;
  *)
    echo -e "\e[1m\e[31m錯誤：無效選項\e[0m"
    read -n 1 -p "按任意按鍵以繼續"
    sudo ./xray-shell/zh-hant/${script_name}
    ;;
esac

curl -sS -O "https://raw.githubusercontent.com/Ray000000/Shell/main/file/zh-hant/app/xray-zh-hant-${selected_app}.sh" && chmod +x "xray-zh-hant-${selected_app}.sh" && sudo "./xray-zh-hant-${selected_app}.sh"
