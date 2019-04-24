#!/bin/bash
#Author: Andre Luiz Alves de Souza
#DATE: 04/2019
#OBBJECTIVE: INSTALL ANSIBLE ON A MANAGER HOST AND CONFIGURE A MANAGED
#HOST.

HEADER_VAR="###############################################################"
BLANK_VAR=" "

echo "$HEADER_VAR"
echo "$BLANK_VAR "
echo "STEP: Install SSH"
echo "$BLANK_VAR"
echo "$HEADER_VAR"

#SSH Instalation
apt install -y ssh
if [ $? -eq 0 ]; then
        SSH_VAR="SSH installed"

else
        echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
        echo "Problemas instalando o SSH - Favor verificar" 
        echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
        exit
fi

echo "$HEADER_VAR"
echo "$BLANK_VAR "
echo "STEP: DISABLE UBUNTU FIREWALL"
echo "$BLANK_VAR"
echo "$HEADER_VAR"

#Disabling Ubuntu Firewall
ufw disable
if [ $? -eq 0 ]; then
        IPTABLES_VAR="IPTABLES disabled"
else
        
        echo "Problemas desabilitando o IPTABLES - Favor verificar"
        exit
fi

echo "$HEADER_VAR"
echo "$BLANK_VAR "
echo "STEP: GENERATE SSH KEY PAIR"
echo "$BLANK_VAR"
echo "$HEADER_VAR"

#Generating SSH Keys
(ls /root/.ssh/id_rsa && ls /root/.ssh/id_rsa.pub) >> /dev/null
if [ $? != 0 ]; then
	ssh-keygen
else
	echo "SSH keys alread exist."
fi

if [ $? -eq 0 ]; then
        SSHKEYS_VAR="Keys Successfull generated"
else
        
        echo "Problems creating ssh keys"
        exit
fi

#Adding hosts file entries - Optional
read -p "Do you want to add hosts file entries ? If Yes, type 1: (If you have consistent DNS name resolution, you dont need to edit hosts file)." ANSWARE_VAR
if [ $ANSWARE_VAR -eq 1 ]; then
	read -p "Please, insert the hostname of your k8s node :" MASTER_VAR
        read -p "Please, insert the ip address of you k8s node :" MASTERIP_VAR
        echo "$MASTERIP_VAR   $MASTER_VAR" >> /etc/hosts
	if [ $? -eq 0 ]; then
		FILEHOSTS_VAR = "Entrada adicionada com sucesso."
	else
		echo "Problems adding entries to /etc/hosts file."
	fi
fi

#Copying SSH Keys
read -p "Do you want to copy your SSH Keys to the K82 Server? If Yes, type 1: " ANSWARE_VAR
if [ $ANSWARE_VAR -eq 1 ]; then
	read -p "Please, enter the sudo enabled user :" USER_VAR
	read -p "Please, enter the hostaname of you k8s node :" K8S_VAR
	ssh-copy-id -i ~/.ssh/id_rsa.pub $USER_VAR@$K8S_VAR
	if [ $? -eq 0 ]; then
		$SSHCOPY_VAR = "SSH Keys copied."
	else
		echo "Problemas copiando chave SSH. Favor verificar"
		exit
	fi
fi

#Adding ansible repository
echo "$HEADER_VAR"
echo "$BLANK_VAR "
echo "STEP: ADD ANSIBLE REPOSITORY"
echo "$BLANK_VAR"
echo "$HEADER_VAR"

apt-add-repository -y ppa:ansible/ansible
apt update


#Installing ansible
echo "$HEADER_VAR"
echo "$BLANK_VAR "
echo "STEP: INSTALL ANSIBLE"
echo "$BLANK_VAR"
echo "$HEADER_VAR"
apt install -y ansible
if [ $? -eq 0 ]; then
	$ANSIBLE_VAR = "Ansible successfully installed."
else
	echo "Problemas instalando ansible. Favor verificar."
	exit
fi

echo "RESULTS:"
echo "$SSH_VAR"
echo "$IPTABLES_VAR"
echo "$SSHKEYS_VAR"
echo "$FILEHOSTS_VAR"
echo "$SSHCOPY_VAR"
echo "$ANSIBLE_VAR"

