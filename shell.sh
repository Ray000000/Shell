#!/bin/bash

clear
echo "
    _/      _/  _/_/_/                        
     _/  _/    _/    _/    _/_/_/  _/    _/        ______   _    _   ______  ______  _       
      _/      _/_/_/    _/    _/  _/    _/        / |      | |  | | | |     | |     | |      
   _/  _/    _/    _/  _/    _/  _/    _/         '------. | |--| | | |---- | |---- | |   _  
_/      _/  _/    _/    _/_/_/    _/_/_/           ____|_/ |_|  |_| |_|____ |_|____ |_|__|_| 
                                     _/       
                                _/_/"

echo "請選擇您要執行的任務："
echo "1. 列出當前目錄中的檔案"
echo "2. 打開終端"
echo "3. Exit"

# 讀取用戶輸入

read choice

# 根據用戶選擇執行操作

case $choice in
  1)
    ls
    ;;
  2)
    gnome-terminal
    ;;
  3)
    exit
    ;;
  *)
    echo "Error: Ineffective choices"
    ;;
esac

#!/bin/bash

first_menu_options=(
  "1. English"
  "2. 繁體中文"
  "3. 简体中文"
)

second_menu_options=(
  "1. 檔案管理"
  "2. 程式管理"
  "3. 網路管理"
)

echo "Choose your language:"
for option in "${first_menu_options[@]}"; do
  echo "$option"
done
read choice

case $choice in
  1)
    echo "Please select the action you want to perform:"
    for option in "${second_menu_options[@]}"; do
      echo "$option"
    done
    read second_choice

    case $second_choice in
      1)
        # 執行檔案管理
        echo "執行檔案管理"
        ;;
      2)
        # 執行程式管理
        echo "執行程式管理"
        ;;
      3)
        # 執行網路管理
        echo "執行網路管理"
        ;;
      *)
        echo "Error: Ineffective choices"
        ;;
    esac
    ;;
  2)
    echo "請選擇您要執行的操作："
    for option in "${second_menu_options[@]}"; do
      echo "$option"
    done
    read second_choice

    case $second_choice in
      1)
        # 執行檔案管理
        echo "執行檔案管理"
        ;;
      2)
        # 執行程式管理
        echo "執行程式管理"
        ;;
      3)
        # 執行網路管理
        echo "執行網路管理"
        ;;
      *)
        echo "錯誤：無效選擇"
        ;;
    esac
    ;;
  3)
    echo "请选择您要执行的操作："
    for option in "${second_menu_options[@]}"; do
      echo "$option"
    done
    read second_choice

    case $second_choice in
      1)
        # 執行檔案管理
        echo "執行檔案管理"
        ;;
      2)
        # 執行程式管理
        echo "執行程式管理"
        ;;
      3)
        # 執行網路管理
        echo "執行網路管理"
        ;;
      *)
        echo "错误：无效选择"
        ;;
    esac
    ;;
  *)
    echo "Error: Ineffective choices"
    ;;
esac
