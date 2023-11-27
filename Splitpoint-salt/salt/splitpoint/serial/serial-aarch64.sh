#!/bin/bash
echo admin,serial=$(cat /proc/cpuinfo | grep Serial | cut -d ' ' -f 2) count=1