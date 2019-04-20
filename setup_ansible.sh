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

read -p "Qual seu nome" oi
echo $oi



