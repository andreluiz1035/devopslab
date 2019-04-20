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
echo "STEP: SUDO WITHOUT PASWWORD"
echo "$BLANK_VAR"
echo "$HEADER_VAR"

sed  -i '/%sudo/a %sudo   ALL=(ALL:ALL) NOPASSWD:ALL' /etc/sudoers

if [ $? -eq 0 ]; then
        SUDO_VAR="SUDO FREE"
else
        echo "@@@@@@@@@@@@@@@@@@@@@"
	echo "Problemas com sudo"
        echo "@@@@@@@@@@@@@@@@@@@@@"
	exit
fi

echo "$HEADER_VAR"
echo "$BLANK_VAR "
echo "STEP: INSTALL PYTHON2"
echo "$BLANK_VAR"
echo "$HEADER_VAR"


apt install -y python-minimal

if [ $? -eq 0 ]; then
        PYTHON_VAR="PYTHON INSTALLED"
else
        echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
	echo "Problemas para instalar o Python 2. Favor verificar"
        echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
	exit
fi

echo "$BLANK_VAR"
echo "OUTPUT:"
echo "$BLANK_VAR"
echo "$SSH_VAR"
echo "$IPTABLES_VAR"
echo "$SUDO_VAR"
echo "$PYTHON_VAR"










