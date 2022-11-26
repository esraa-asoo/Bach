#!/usr/bin/env bash
source ./ssh_config.sh
source ./library.sh

while true
do
	g=$(groups $USER)
	if grep -q 'wheel' <<< "$g" || [ "$EUID" -eq 0 ] || [ "$(whoami)" == root ] || grep "$USER" "/etc/sudoers";
	then
           menu $1 $2 $3
		read n
		case "$n" in
			1) change_ssh_port "$1";;
			2) Disable_root_Login;;
			3) firewall_selinux "$1";;
			4) Audit_group;;
			5) User_add "$2" "$3";;
			6) Reports_create;;
			7) Supdate;;
			8) EPEL;;
			9) Fail2ban;;
			10) Report_backup;;
                        11) add_manager;;
                        12) sync;;
			[^q]) echo "Wrong choice choose Correct option please ...q to quit...";;
			q) exit
		esac
	else
   	echo "Only root user or sudoer user can run the script..."
	exit 1
	fi
done
