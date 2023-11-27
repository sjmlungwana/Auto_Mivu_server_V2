#!/bin/bash

sudo apt update -y

sudo apt upgrade -y

sudo salt server-minion state.apply packages.sls