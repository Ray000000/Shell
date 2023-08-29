# {#!/bin/bash} for start
#!/bin/bash
clear

echo "Your Title"
echo "Choose your language:"

echo "1. Option1"
echo "2. Option2"
echo "3. Option3"
echo "0. Option-Exit"

read -p "Please input:" choice

case $choice in
  1)
    #code
    #example:
    sudo apt install pppoeconf
    ;;
  2)
    ;;
  3)
    ;;
  # Exit
  0)
    exit
    ;;
  # Options that don't exist
  *)
    echo -e "A message"
    read -n 1 -p "Press any key to return to the menu."
    # Reload
    sudo ./example.sh
    ;;
# End
esac
