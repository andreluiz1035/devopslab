#!/bin/bash
read -p "Please, enter the sudo enabled user name, on the kubernetes node  : " USERNAME_VAR

read -p "Please, enter the hostname of the kubernetes node  : " NODENAME_VAR

ssh-copy-id -i ~/.ssh/id_rsa.pub $USERNAME_VAR@$NODENAME_VAR

