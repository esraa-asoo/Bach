#!/usr/bin/env bash

check_user_root_priv(){
users = $(groups $USER)
if grep -q 'wheel' <<< "$users" || [ $EUID -eq 0 ] || grep "$USER" "/etc/sudores"
then
    echo "User has root privilages."
    else
    echo "User does not have root privilages."
    fi
}

change_ssh_pot(){
  echo " Pleas, enter the new ssh port to change: "
  read port
  sed -i "s/#port 22/port $port/g" /etc/ssh/sshd_config
  echo " ssh port changed to $port "
}
disable_root_log(){
sed -i "s/permitRootLogin yes/permitRootLogin no/g" /etc/ssh/sshd_config
systemctl reload sshd
}

add_user(){
  echo"Enter the name of the user that you want to add: "
  read user
  if [ grep -q "$user" <<< $(grep "$user" /etc/passwd) ]
  then
      echo $(grep "$user" /etc/passwd)
      else
      echo "Do you want to add user to sudoers: [y/n]"
      read anser
   if ["$anser" == "y"] || [ $anser == "yes" ]
    then
     echo "$user ALL =(ALL) ALL " >> /etc/sudores
     echo "$user is sudoer now..."
  else
     echo "$user is not sudoer..."
     fi
   fi
}

backup(){
 echo "* * * * * tar -czf /etc/homedir.tar.gz $HOME " > "$HOME/backup.txt"
   crontab "$HOME/backup.txt"
}
