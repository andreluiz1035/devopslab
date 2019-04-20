#!/bin/bash
#Author: Andre Luiz Alves de Souza

HEADER_VAR="##############################################################################################"
BLANK_VAR=" "

echo "$HEADER_VAR"
echo "$BLANK_VAR "
echo "STEP: Install SSH"
echo "$BLANK_VAR"
echo "$HEADER_VAR"

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

ufw disable
if [ $? -eq 0 ]; then
        IPTABLES_VAR="IPTABLES disabled"
else
        echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
        echo "Problemas desabilitando o IPTABLES - Favor verificar"
        echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
        exit
fi

echo "$HEADER_VAR"
echo "$BLANK_VAR "
echo "STEP: GENERATE SSH KEY PAIR"
echo "$BLANK_VAR"
echo "$HEADER_VAR"


(ls /root/.ssh/id_rsa && ls /root/.ssh/id_rsa.pub) >> /dev/null
if [ $? != 0 ]; then
	ssh-keygen
else
	echo "SSH keys alread exist."
fi

if [ $? -eq 0 ]; then
        SSHKEYS_VAR="Keys Successfull generated"
else
        echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
        echo "Problems creating ssh keys"
        echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
        exit
fi

read -p "Do you want to add hosts file entries ? If Yes, type 1: (If you have consistent DNS name resolution, you dont need to edit hosts file)." ANSWARE_VAR
if [ $ANSWARE_VAR -eq 1 ]; then
	read -p "Please, insert the hostname of your k8s node :" MASTER_VAR
        read -p "Please, insert the ip address of you k8s node :" MASTERIP_VAR
        echo "$MASTERIP_VAR   $MASTER_VAR" >> /etc/hosts
fi


read -p "Do you want to copy your SSH Keys to the K82 Server? If Yes, type 1: " ANSWARE_VAR
if [ $ANSWARE_VAR -eq 1 ]; then
	read -p "Please, enter the sudo enabled user :" USER_VAR
	read -p "Please, enter the hostaname of you k8s node :" K8S_VAR
	ssh-copy-id -i ~/.ssh/id_rsa.pub $USER_VAR@$K8S_VAR
fi

echo "$HEADER_VAR"
echo "$BLANK_VAR "
echo "STEP: ADD ANSIBLE REPOSITORY"
echo "$BLANK_VAR"
echo "$HEADER_VAR"

apt-add-repository ppa:ansible/ansible
apt update

echo "$HEADER_VAR"
echo "$BLANK_VAR "
echo "STEP: INSTALL ANSIBLE"
echo "$BLANK_VAR"
echo "$HEADER_VAR"
apt install -y ansible
if [ $? -eq 0 ]; then
	echo "Ansible instalado com sucesso."
else
	echo "problemas instalando ansible."
fi





