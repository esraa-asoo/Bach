#!/usr/bin/env bash

audit(){
    groupadd -g 20000 -f Audit
    echo "Audits added Successfuly..."
}

user_add(){
    exist=$(grep "^$1" /etc/passwd)
	if grep -q "$1" <<< "$exist"
  then
		echo "$1 exist"
	else
        pass=$(perl -e 'print crypt($ARGV[0], "sprint")' $2)
        useradd -m -p "$pass" "$1" -g Audit 
		check_add=$(grep "^$1" /etc/passwd)
        if grep -q "$1" <<< "$check_add"
        then
		echo "$1 Added to the system"
        else
        echo "Failed to add user..."
        fi
	fi
}

reports_create(){
    		mkdir -p ~/reports 
        touch ~/reports/2021{1..12}{1..31}.xls
    		echo "Reports Created successfully..."
   		echo "Config permission of Reports..."
    		chmod 660 ~/reports/*
}

update(){
	echo "Updating System..."
	yum -y "update"
}

EPEl(){
	echo "EPEL Package enabled..."
	yum install "epel-release"
}

fail2ban(){
	echo "Fail2ban installing..."
       	yum install "fail2ban"
	      systemctl enable "fail2ban" 
       	systemctl start "fail2ban"	
}

backup_rep(){
    mkdir -p ~/backups
	echo "00 1 * * 1-4 tar -czf ~/backups/reports-$(date +%U)-$(date +%w).tar.gz ~/reports" > " ~/repbackup.txt"
	crontab "~/repbackup.txt"
}

add_manager(){
    useradd -u 30000 manager
    if [ $? -eq 0 ]
    then
	    echo "Manager has been added..."
    else
	    echo "faild to add manager..."
    fi
}

sync(){
	f="~/reports/*"
	f1="~/manager/audit/reports"
	mkdir -p ~/manager/audit
	mkdir -p ~/manager/audit/reports
	echo "00 2 * * 1-4 sync $f $f1" > "/tmp/sync.txt"
  crontab "/tmp/sync.txt"
	echo "$USER crontab updated"
}

menu(){
    echo "PLease Choose An option(press q to exit)"
    echo "1- Change ssh port to $1"
    echo "2- Disable root Login"
    echo "3- config Firewall and SELINUX to allow port $1"
    echo "4- Add Audit Group"
    echo "5- Add user($2) and encrypt password($3)"
    echo "6- Create Reports"
    echo "7- System Update"
    echo "8- Enable EPEL Repo"
    echo "9- install fail2ban"
    echo "10- Backup Reports dir"
    echo "11- add manager to the system"
    echo "12- Syncronize Reports with manager"
}
