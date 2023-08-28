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
        echo "無效選擇"
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
        echo "無效選擇"
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
        echo "無效選擇"
        ;;
    esac
    ;;
  *)
    echo "Error: Ineffective choices"
    ;;
esac
