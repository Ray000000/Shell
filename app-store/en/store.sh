#!/bin/bash
clear

script_name="${0##*/}"
language="en"

update_message=$(curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/xray-update-message.sh | awk '/echo -e ".*"/ {print}')
if [[ -n "${update_message}" ]]; then
  eval "${update_message}"
fi

dir0="app-store/${language}"
dir1="./xray-shell/${dir0}"

if [ ! -d "${dir1}" ]; then
  mkdir -p "${dir1}"
  chmod +x "${dir1}"
else
  chmod +x "${dir1}"
fi

echo -e "\e[1m\e[34m
    _/      _/  _/_/_/                        
     _/  _/    _/    _/    _/_/_/  _/    _/        ______   _    _   ______  ______  _       
      _/      _/_/_/    _/    _/  _/    _/        / |      | |  | | | |     | |     | |      
   _/  _/    _/    _/  _/    _/  _/    _/         '------. | |--| | | |---- | |---- | |   _  
_/      _/  _/    _/    _/_/_/    _/_/_/           ____|_/ |_|  |_| |_|____ |_|____ |_|__|_|   {English Version}
                                     _/       
                                _/_/ \e[0m"

echo -e "\e[1m\e[93m
Please choose the initial letter of the application you want to install:
\e[0m"
echo "1.  A　　　　　14. N"
echo "2.  B　　　　　15. O"
echo "3.  C　　　　　16. P"
echo "4.  D　　　　　17. Q"
echo "5.  E　　　　　18. R"
echo "6.  F　　　　　19. S"
echo "7.  G　　　　　20. T"
echo "8.  H　　　　　21. U"
echo "9.  I　　　　　22. V"
echo "10. J　　　　　23. W"
echo "11. K　　　　　24. X"
echo "12. L　　　　　25. Y"
echo "13. M　　　　　26. Z"
echo "00. Search"
echo -e "\e[1m\e[32m0. Exit\e[0m"

read -p "Please enter: " choice

if [[ "${choice}" == "1" ]]; then
  curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/${dir0}/a.sh -o ${dir1}/a.sh && chmod +x ${dir1}/a.sh && sudo ${dir1}/a.sh
elif [[ "${choice}" == "2" ]]; then
  curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/${dir0}/b.sh -o ${dir1}/b.sh && chmod +x ${dir1}/b.sh && sudo ${dir1}/b.sh
elif [[ "${choice}" == "3" ]]; then
  curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/${dir0}/c.sh -o ${dir1}/c.sh && chmod +x ${dir1}/c.sh && sudo ${dir1}/c.sh
elif [[ "${choice}" == "4" ]]; then
  curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/${dir0}/d.sh -o ${dir1}/d.sh && chmod +x ${dir1}/d.sh && sudo ${dir1}/d.sh
elif [[ "${choice}" == "5" ]]; then
  curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/${dir0}/e.sh -o ${dir1}/e.sh && chmod +x ${dir1}/e.sh && sudo ${dir1}/e.sh
elif [[ "${choice}" == "6" ]]; then
  curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/${dir0}/f.sh -o ${dir1}/f.sh && chmod +x ${dir1}/f.sh && sudo ${dir1}/f.sh
elif [[ "${choice}" == "7" ]]; then
  curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/${dir0}/g.sh -o ${dir1}/g.sh && chmod +x ${dir1}/g.sh && sudo ${dir1}/g.sh
elif [[ "${choice}" == "8" ]]; then
  curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/${dir0}/h.sh -o ${dir1}/h.sh && chmod +x ${dir1}/h.sh && sudo ${dir1}/h.sh
elif [[ "${choice}" == "9" ]]; then
  curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/${dir0}/i.sh -o ${dir1}/i.sh && chmod +x ${dir1}/i.sh && sudo ${dir1}/i.sh
elif [[ "${choice}" == "10" ]]; then
  curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/${dir0}/j.sh -o ${dir1}/j.sh && chmod +x ${dir1}/j.sh && sudo ${dir1}/j.sh
elif [[ "${choice}" == "11" ]]; then
  curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/${dir0}/k.sh -o ${dir1}/k.sh && chmod +x ${dir1}/k.sh && sudo ${dir1}/k.sh
elif [[ "${choice}" == "12" ]]; then
  curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/${dir0}/l.sh -o ${dir1}/l.sh && chmod +x ${dir1}/l.sh && sudo ${dir1}/l.sh
elif [[ "${choice}" == "13" ]]; then
  curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/${dir0}/m.sh -o ${dir1}/m.sh && chmod +x ${dir1}/m.sh && sudo ${dir1}/m.sh
elif [[ "${choice}" == "14" ]]; then
  curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/${dir0}/n.sh -o ${dir1}/n.sh && chmod +x ${dir1}/n.sh && sudo ${dir1}/n.sh
elif [[ "${choice}" == "15" ]]; then
  curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/${dir0}/o.sh -o ${dir1}/o.sh && chmod +x ${dir1}/o.sh && sudo ${dir1}/o.sh
elif [[ "${choice}" == "16" ]]; then
  curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/${dir0}/p.sh -o ${dir1}/p.sh && chmod +x ${dir1}/p.sh && sudo ${dir1}/p.sh
elif [[ "${choice}" == "17" ]]; then
  curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/${dir0}/q.sh -o ${dir1}/q.sh && chmod +x ${dir1}/q.sh && sudo ${dir1}/q.sh
elif [[ "${choice}" == "18" ]]; then
  curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/${dir0}/r.sh -o ${dir1}/r.sh && chmod +x ${dir1}/r.sh && sudo ${dir1}/r.sh
elif [[ "${choice}" == "19" ]]; then
  curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/${dir0}/s.sh -o ${dir1}/s.sh && chmod +x ${dir1}/s.sh && sudo ${dir1}/s.sh
elif [[ "${choice}" == "20" ]]; then
  curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/${dir0}/t.sh -o ${dir1}/t.sh && chmod +x ${dir1}/t.sh && sudo ${dir1}/t.sh
elif [[ "${choice}" == "21" ]]; then
  curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/${dir0}/u.sh -o ${dir1}/u.sh && chmod +x ${dir1}/u.sh && sudo ${dir1}/u.sh
elif [[ "${choice}" == "22" ]]; then
  curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/${dir0}/v.sh -o ${dir1}/v.sh && chmod +x ${dir1}/v.sh && sudo ${dir1}/v.sh
elif [[ "${choice}" == "23" ]]; then
  curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/${dir0}/w.sh -o ${dir1}/w.sh && chmod +x ${dir1}/w.sh && sudo ${dir1}/w.sh
elif [[ "${choice}" == "24" ]]; then
  curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/${dir0}/x.sh -o ${dir1}/x.sh && chmod +x ${dir1}/x.sh && sudo ${dir1}/x.sh
elif [[ "${choice}" == "25" ]]; then
  curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/${dir0}/y.sh -o ${dir1}/y.sh && chmod +x ${dir1}/y.sh && sudo ${dir1}/y.sh
elif [[ "${choice}" == "26" ]]; then
  curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/${dir0}/z.sh -o ${dir1}/z.sh && chmod +x ${dir1}/z.sh && sudo ${dir1}/z.sh

elif [[ "${choice}" == "00" ]]; then
  curl -sS https://raw.githubusercontent.com/Ray000000/Shell/main/${dir0}/search.sh -o ${dir1}/search.sh && chmod +x ${dir1}/search.sh && sudo ${dir1}/search.sh
elif [[ "${choice}" == "0" ]]; then
  exit
else
  echo -e "\e[1m\e[31mError: Ineffective choices\e[0m"
  read -n 1 -p "Press any key to return to the menu."
  sudo ${dir1}/${script_name}
fi
