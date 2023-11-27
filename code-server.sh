#!/bin/bash

sudo apt update -y

sudo apt upgrade -y

sudo curl -fsSL https://code-server.dev/install.sh | sh

sudo apt update -y

sudo sleep 5

sudo code-server

sudo cp config.yaml ~/.config/code-server/

sudo systemctl start code-server@root