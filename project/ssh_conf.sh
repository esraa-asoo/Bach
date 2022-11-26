#!/usr/bin/env bash


change_port(){
	sed -i "s/#Port 22/Port $1/g" /etc/ssh/sshd_config
	echo "ssh Port Changed to $1"
}

disable_root(){
	echo -e "Modifying Deafult ssh Configuration...\ "
	sed -i "s/PermitRootLogin yes/PermitRootLogin no/g" /etc/ssh/sshd_config
	echo -e "Remote Login using root credintioal will be denied...\  "
}

firewall_selin(){
	echo "selinux configuring..."
	semanage port -a -t ssh_port_t -p tcp $1
	echo "Allow $1 port through Firewall"
	firewall-cmd --permanent --zone=public --add-port=$1/tcp
	firewall-cmd --reload
}
