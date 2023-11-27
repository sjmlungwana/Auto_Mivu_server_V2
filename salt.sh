#!/bin/bash

sudo apt update -y

sudo wget -O bootstrap-salt.sh https://bootstrap.saltproject.io

sudo sh bootstrap-salt.sh -M git v3004.1

pip uninstall jinja2 -y

pip install jinja2==3.0

sudo systemctl stop salt-minion

sudo cat master-conf.txt >> /etc/salt/master

sudo echo 'server-minion' > /etc/salt/minion_id

sudo cp minion /etc/salt/

sudo cp _schedule.conf /etc/salt/minion.d/

sudo cat etc-hosts.txt > /etc/hosts

sudo systemctl restart salt-minion

sudo systemctl restart salt-master

sudo sleep 10

sudo salt-key -a server-minion -y