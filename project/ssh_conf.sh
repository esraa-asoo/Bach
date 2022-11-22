#!/usr/bin/env bash


change_port(){
	sed -i "s/#Port 22/Port $u/g" /etc/ssh/sshd_config
	echo "ssh Port Changed to $u"
}

disable_root(){
	echo -e "Modifying Deafult ssh Configuration...\ "
	sed -i "s/PermitRootLogin yes/PermitRootLogin no/g" /etc/ssh/sshd_config
	echo -e "Remote Login using root credintioal will be denied...\  "
}

firewall_selin(){
	echo "selinux configuring..."
	semanage port -a -t ssh_port_t -p tcp $u
	echo "Allow $u port through Firewall"
	firewall-cmd --permanent --zone=public --add-port=$u/tcp
	firewall-cmd --reload
}
