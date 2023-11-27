#!/bin/bash

# This script is for installing chronograf 1.10.1

sudo apt update -y

sudo apt upgrade -y

sudo dpkg -i chronograf_1.10.1_amd64.deb

sudo systemctl enable chronograf.service

sudo systemctl start chronograf.service
