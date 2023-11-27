#!/bin/bash

# This script is for automating the build of mivu server

sudo apt update -y

sudo apt upgrade -y

sudo sh first_script.sh

sudo sh salt.sh

sudo sh grafana.sh

sudo sh influxdb.sh

sudo sh chronograf.sh

sudo apt update && sudo apt install openvpn -y

sudo systemctl enable openvpn@client

sudo systemctl start openvpn@client

sudo ./install.sh

sudo sh code-server.sh