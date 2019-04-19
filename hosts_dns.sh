#!/bin/bash

read -p "Please, enter the hostname of the kubernetes node being installed  : " NODENAME_VAR

read -p "Please, enter the ip address of the kubernetes node being installed : " IPADDRESS_VAR

echo "$IPADDRESS_VAR   $NODENAME_VAR   "  >> /etc/hosts


