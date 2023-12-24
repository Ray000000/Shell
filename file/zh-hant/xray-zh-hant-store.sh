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
請選擇您要安裝應用程式的首字母：
\e[0m"
echo "1. A"
echo "2. B"
echo "3. C"
echo "4. D"
echo "5. E"
echo "6. F"
echo "7. G"
echo "8. H"
echo "9. I"
echo "10. J"
echo "11. K"
echo "12. L"
echo "13. M"
echo "14. N"
echo "15. O"
echo "16. P"
echo "17. Q"
echo "18. R"
echo "19. S"
echo "20. T"
echo "21. U"
echo "22. V"
echo "23. W"
echo "24. X"
echo "25. Y"
echo "26. Z"
echo "log. 日誌"
echo -e "\e[1m\e[32m0. Exit\e[0m"

read -p "請輸入：" choice

if [[ $choice == "1" ]]; then
  curl -sS -O https://ray000000.github.io/Shell/file/zh-hant/xray-zh-hant-store-a.sh && chmod +x xray-zh-hant-store-a.sh && sudo ./xray-zh-hant-store-a.sh
elif [[ $choice == "2" ]]; then
  curl -sS -O https://ray000000.github.io/Shell/file/zh-hant/xray-zh-hant-store-b.sh && chmod +x xray-zh-hant-store-b.sh && sudo ./xray-zh-hant-store-b.sh
elif [[ $choice == "3" ]]; then
  curl -sS -O https://ray000000.github.io/Shell/file/zh-hant/xray-zh-hant-store-c.sh && chmod +x xray-zh-hant-store-c.sh && sudo ./xray-zh-hant-store-c.sh
elif [[ $choice == "4" ]]; then
  curl -sS -O https://ray000000.github.io/Shell/file/zh-hant/xray-zh-hant-store-d.sh && chmod +x xray-zh-hant-store-d.sh && sudo ./xray-zh-hant-store-d.sh
elif [[ $choice == "5" ]]; then
  curl -sS -O https://ray000000.github.io/Shell/file/zh-hant/xray-zh-hant-store-e.sh && chmod +x xray-zh-hant-store-e.sh && sudo ./xray-zh-hant-store-e.sh
elif [[ $choice == "6" ]]; then
  curl -sS -O https://ray000000.github.io/Shell/file/zh-hant/xray-zh-hant-store-f.sh && chmod +x xray-zh-hant-store-f.sh && sudo ./xray-zh-hant-store-f.sh
elif [[ $choice == "7" ]]; then
  curl -sS -O https://ray000000.github.io/Shell/file/zh-hant/xray-zh-hant-store-g.sh && chmod +x xray-zh-hant-store-g.sh && sudo ./xray-zh-hant-store-g.sh
elif [[ $choice == "8" ]]; then
  curl -sS -O https://ray000000.github.io/Shell/file/zh-hant/xray-zh-hant-store-h.sh && chmod +x xray-zh-hant-store-h.sh && sudo ./xray-zh-hant-store-h.sh
elif [[ $choice == "9" ]]; then
  curl -sS -O https://ray000000.github.io/Shell/file/zh-hant/xray-zh-hant-store-i.sh && chmod +x xray-zh-hant-store-i.sh && sudo ./xray-zh-hant-store-i.sh
elif [[ $choice == "10" ]]; then
  curl -sS -O https://ray000000.github.io/Shell/file/zh-hant/xray-zh-hant-store-j.sh && chmod +x xray-zh-hant-store-j.sh && sudo ./xray-zh-hant-store-j.sh
elif [[ $choice == "11" ]]; then
  curl -sS -O https://ray000000.github.io/Shell/file/zh-hant/xray-zh-hant-store-k.sh && chmod +x xray-zh-hant-store-k.sh && sudo ./xray-zh-hant-store-k.sh
elif [[ $choice == "12" ]]; then
  curl -sS -O https://ray000000.github.io/Shell/file/zh-hant/xray-zh-hant-store-l.sh && chmod +x xray-zh-hant-store-l.sh && sudo ./xray-zh-hant-store-l.sh
elif [[ $choice == "13" ]]; then
  curl -sS -O https://ray000000.github.io/Shell/file/zh-hant/xray-zh-hant-store-m.sh && chmod +x xray-zh-hant-store-m.sh && sudo ./xray-zh-hant-store-m.sh
elif [[ $choice == "14" ]]; then
  curl -sS -O https://ray000000.github.io/Shell/file/zh-hant/xray-zh-hant-store-n.sh && chmod +x xray-zh-hant-store-n.sh && sudo ./xray-zh-hant-store-n.sh
elif [[ $choice == "15" ]]; then
  curl -sS -O https://ray000000.github.io/Shell/file/zh-hant/xray-zh-hant-store-o.sh && chmod +x xray-zh-hant-store-o.sh && sudo ./xray-zh-hant-store-o.sh
elif [[ $choice == "16" ]]; then
  curl -sS -O https://ray000000.github.io/Shell/file/zh-hant/xray-zh-hant-store-p.sh && chmod +x xray-zh-hant-store-p.sh && sudo ./xray-zh-hant-store-p.sh
elif [[ $choice == "17" ]]; then
  curl -sS -O https://ray000000.github.io/Shell/file/zh-hant/xray-zh-hant-store-q.sh && chmod +x xray-zh-hant-store-q.sh && sudo ./xray-zh-hant-store-q.sh
elif [[ $choice == "18" ]]; then
  curl -sS -O https://ray000000.github.io/Shell/file/zh-hant/xray-zh-hant-store-r.sh && chmod +x xray-zh-hant-store-r.sh && sudo ./xray-zh-hant-store-r.sh
elif [[ $choice == "19" ]]; then
  curl -sS -O https://ray000000.github.io/Shell/file/zh-hant/xray-zh-hant-store-s.sh && chmod +x xray-zh-hant-store-s.sh && sudo ./xray-zh-hant-store-s.sh
elif [[ $choice == "20" ]]; then
  curl -sS -O https://ray000000.github.io/Shell/file/zh-hant/xray-zh-hant-store-t.sh && chmod +x xray-zh-hant-store-t.sh && sudo ./xray-zh-hant-store-t.sh
elif [[ $choice == "21" ]]; then
  curl -sS -O https://ray000000.github.io/Shell/file/zh-hant/xray-zh-hant-store-u.sh && chmod +x xray-zh-hant-store-u.sh && sudo ./xray-zh-hant-store-u.sh
elif [[ $choice == "22" ]]; then
  curl -sS -O https://ray000000.github.io/Shell/file/zh-hant/xray-zh-hant-store-v.sh && chmod +x xray-zh-hant-store-v.sh && sudo ./xray-zh-hant-store-v.sh
elif [[ $choice == "23" ]]; then
  curl -sS -O https://ray000000.github.io/Shell/file/zh-hant/xray-zh-hant-store-w.sh && chmod +x xray-zh-hant-store-w.sh && sudo ./xray-zh-hant-store-w.sh
elif [[ $choice == "24" ]]; then
  curl -sS -O https://ray000000.github.io/Shell/file/zh-hant/xray-zh-hant-store-x.sh && chmod +x xray-zh-hant-store-x.sh && sudo ./xray-zh-hant-store-x.sh
elif [[ $choice == "25" ]]; then
  curl -sS -O https://ray000000.github.io/Shell/file/zh-hant/xray-zh-hant-store-y.sh && chmod +x xray-zh-hant-store-y.sh && sudo ./xray-zh-hant-store-y.sh
elif [[ $choice == "26" ]]; then
  curl -sS -O https://ray000000.github.io/Shell/file/zh-hant/xray-zh-hant-store-z.sh && chmod +x xray-zh-hant-store-z.sh && sudo ./xray-zh-hant-store-z.sh

elif [[ $choice == "log" ]]; then
  curl -sS -O https://ray000000.github.io/Shell/file/zh-hant/xray-zh-hant-store-log.sh && chmod +x xray-zh-hant-store-log.sh && sudo ./xray-zh-hant-store-log.sh

elif [[ $choice == "0" ]]; then
  exit
else
  echo -e "\e[1m\e[31m錯誤：無效選項\e[0m"
  read -n 1 -p "按任意按鍵以繼續"
  sudo ./xray-zh-hant-store.sh
fi
echo "${script_name} ended: $(date)" >> ./xray-log.txt