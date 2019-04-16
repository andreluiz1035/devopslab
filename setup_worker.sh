#!/bin/bash

echo "########################################################################################"
echo "  "
echo "STEP: Install SSH"
echo "  "
echo "########################################################################################"

apt install -y ssh
if [ $? -eq 0 ]; then
	echo "SSH installed"
else
	echo "Problemas instalando o SSH - Favor verificar" 
	exit
fi

echo "#########################################################################################"
echo "  "
echo "STEP: Disable Ubuntu Firewall"
echo "  "
echo "#########################################################################################"

ufw disable
if [ $? -eq 0 ]; then
	echo "IPTABLES disabled"
else
	echo "Problemas desabilitando o IPTABLES - Favor verificar"
	exit
fi

