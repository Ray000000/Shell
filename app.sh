#!/bin/bash
clear
echo -e "\e[1m\e[93m〔----- # Application Name # -----〕\e[0m"
echo "
----- # Application Introduction and Help # -----"

# The dividing line
echo "----------------------------------------"

# Official Website:
# https://example.com/
echo "Official Website and Developer Help"
echo -e "\e[1m\e[93m
Which operations do you want to perform:
\e[0m"
echo "1. Install"
echo "2. Update"
echo "3. Uninstall"
echo -e "\e[1m\e[31m4. Uninstall and erase all data\e[0m"
echo "5. View Version"
echo -e "\e[1m\e[32m0. Back\e[0m"

read -p "Please input:" choice

if [[ $choice == "1" ]]; then
    echo -e "\e[1m\e[34mY. Confirm install\e[0m"
    echo -e "\e[1m\e[31mN. Cancel install\e[0m"
    read -p "Please input:" yn_choice
elif [[ $choice == "2" ]]; then
  sudo apt-get update -y && sudo apt-get upgrade docker-ce -y && sudo apt-get upgrade docker-compose -y
  read -n 1 -p "Press any key to continue."
  sudo ./app.sh
elif [[ $choice == "3" ]]; then
  echo -e "\e[1m\e[34mY. Confirm uninstall\e[0m"
  echo -e "\e[1m\e[31mN. Cancel uninstall\e[0m"
  read -p "Please input:" yn2_choice
elif [[ $choice == "4" ]]; then
  echo -e "\e[1m\e[34mY. Confirm uninstall\e[0m"
  echo -e "\e[1m\e[31mN. Cancel uninstall\e[0m"
  read -p "Please input:" yn3_choice
elif [[ $choice == "5" ]]; then
  docker --version
  docker-compose --version
  read -n 1 -p "Press any key to continue."
  sudo ./app.sh
elif [[ $choice == "0" ]]; then
  sudo ./app.sh
else
  echo -e "\e[1m\e[31mError: Ineffective choices\e[0m"
  read -n 1 -p "Press any key to return to the menu."
  sudo ./app.sh
fi

case $yn_choice in
  [Yy])
    commands=(
          "docker exec php apt update > /dev/null 2>&1"
          "docker exec php apt install -y libmariadb-dev-compat libmariadb-dev libzip-dev libmagickwand-dev imagemagick > /dev/null 2>&1"
          "docker exec php docker-php-ext-install mysqli pdo_mysql zip exif gd intl bcmath opcache > /dev/null 2>&1"
          "docker exec php pecl install imagick > /dev/null 2>&1"
          "docker exec php sh -c 'echo \"extension=imagick.so\" > /usr/local/etc/php/conf.d/imagick.ini' > /dev/null 2>&1"
          "docker exec php pecl install redis > /dev/null 2>&1"
          "docker exec php sh -c 'echo \"extension=redis.so\" > /usr/local/etc/php/conf.d/docker-php-ext-redis.ini' > /dev/null 2>&1"
          "docker exec php sh -c 'echo \"upload_max_filesize=50M \\n post_max_size=50M\" > /usr/local/etc/php/conf.d/uploads.ini' > /dev/null 2>&1"
          "docker exec php sh -c 'echo \"memory_limit=256M\" > /usr/local/etc/php/conf.d/memory.ini' > /dev/null 2>&1"
          "docker exec php sh -c 'echo \"max_execution_time=1200\" > /usr/local/etc/php/conf.d/max_execution_time.ini' > /dev/null 2>&1"
          "docker exec php sh -c 'echo \"max_input_time=600\" > /usr/local/etc/php/conf.d/max_input_time.ini' > /dev/null 2>&1"

          "docker exec php74 apt update > /dev/null 2>&1"
          "docker exec php74 apt install -y libmariadb-dev-compat libmariadb-dev libzip-dev libmagickwand-dev imagemagick > /dev/null 2>&1"
          "docker exec php74 docker-php-ext-install mysqli pdo_mysql zip gd intl bcmath opcache > /dev/null 2>&1"
          "docker exec php74 pecl install imagick > /dev/null 2>&1"
          "docker exec php74 sh -c 'echo \"extension=imagick.so\" > /usr/local/etc/php/conf.d/imagick.ini' > /dev/null 2>&1"
          "docker exec php74 pecl install redis > /dev/null 2>&1"
          "docker exec php74 sh -c 'echo \"extension=redis.so\" > /usr/local/etc/php/conf.d/docker-php-ext-redis.ini' > /dev/null 2>&1"
          "docker exec php74 sh -c 'echo \"upload_max_filesize=50M \\n post_max_size=50M\" > /usr/local/etc/php/conf.d/uploads.ini' > /dev/null 2>&1"
          "docker exec php74 sh -c 'echo \"memory_limit=256M\" > /usr/local/etc/php/conf.d/memory.ini' > /dev/null 2>&1"
          "docker exec php74 sh -c 'echo \"max_execution_time=1200\" > /usr/local/etc/php/conf.d/max_execution_time.ini' > /dev/null 2>&1"
          "docker exec php74 sh -c 'echo \"max_input_time=600\" > /usr/local/etc/php/conf.d/max_input_time.ini' > /dev/null 2>&1"
      )

    total_commands=${#commands[@]}

    for ((i = 0; i < total_commands; i++)); do
      command="${commands[i]}"
      eval $command
        percentage=$(( (i + 1) * 100 / total_commands ))
        completed=$(( percentage / 2 ))
        remaining=$(( 50 - completed ))
        progressBar="["
        for ((j = 0; j < completed; j++)); do
          progressBar+="#"
        done
        for ((j = 0; j < remaining; j++)); do
          progressBar+="-"
        done
        progressBar+="]"
        echo -ne "\r\e[1m\e[93m\e[1m\e[32m[$percentage%]\e[0m $progressBar\e[0m"
      done

      echo

    read -n 1 -p "Press any key to continue."
    sudo ./app.sh
    ;;
  [Nn])
    sudo ./app.sh
    ;;
esac
  
case $yn2_choice in
  [Yy])
    sudo apt-get remove docker -y
    sudo apt-get remove docker-ce -y
    sudo apt-get purge docker-ce -y
    sudo rm -rf /var/lib/docker
    sudo rm /usr/local/bin/docker-compose

    read -n 1 -p "Press any key to continue."
    sudo ./app.sh
    ;;
  [Nn])
    sudo ./app.sh
    ;;
esac

case $yn3_choice in
  [Yy])
    docker rm $(docker ps -a -q) && docker rmi $(docker images -q) && docker network prune
    sudo apt-get remove docker -y
    sudo apt-get remove docker-ce -y
    sudo apt-get purge docker-ce -y
    sudo rm -rf /var/lib/docker
    sudo rm /usr/local/bin/docker-compose

    read -n 1 -p "Press any key to continue."
    sudo ./app.sh
    ;;
  [Nn])
    sudo ./app.sh
    ;;
esac
