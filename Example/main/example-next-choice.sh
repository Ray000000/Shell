# {#!/bin/bash} for start
#!/bin/bash
clear

echo "Your Title"
echo "A message"

echo "1. Option1"
echo "2. Option2"
echo "3. Option3"
echo "0. Option-Exit"

read -p "Please input:" choice
# The {choice}             |
case $choice in #<<________|
  1)
    sudo apt update -y && apt full-upgrade -y && apt upgrade -y && apt autoremove -y && apt autoclean -y
    lsb_release -d
    read -n 1 -p "Press any key to return to the menu."
    # Reload
    sudo ./example.sh
    ;;
  2)
    cat /proc/cpuinfo | grep 'model name' | head -n1
    cat /proc/meminfo | grep MemTotal
    df -h
    read -n 1 -p "Press any key to return to the menu."
    # Reload
    sudo ./example.sh
    ;;
  3)
    curl -sS -O https://ray000000.github.io/Shell/file/zh-hant/xray-zh-hant-store.sh && chmod +x xray-zh-hant-store.sh && sudo ./xray-zh-hant-store.sh
    ;;
  00)
    echo -e "A message"

    echo "1. Option"
    echo "2. Option"
    echo "3. Option"
    echo "4. Option"
    echo "5. Option"
    echo "6. Option"
    echo "0. Option-Back"

    read -p "A message" next_choice
    # The {next_choice}          |
    case $next_choice in #<<_____|
      1)
        ls
        ;;
      2)
        cat file.txt
        ;;
      3)
        touch new_file.txt
        ;;
      4)
        rm file.txt
        ;;
      5)
        zip file.zip file.txt
        ;;
      6)
        unzip file.zip
        ;;
      0)
        sudo ./xray-zh-hant.sh
        ;;
      *)
        echo -e "\e[1m\e[31m錯誤：無效選項\e[0m"
        read -n 1 -p "Press any key to return to the menu."
        # Reload
        sudo ./example.sh
        ;;
    esac
    ;;
  
  0)
    exit
    ;;
  *)
    echo -e "A message"
    read -n 1 -p "Press any key to return to the menu."
    # Reload
    sudo ./example.sh
    ;;
esac
