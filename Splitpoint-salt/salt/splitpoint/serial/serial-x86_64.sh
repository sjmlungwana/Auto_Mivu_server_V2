#!/bin/bash
echo admin,serial=$(dmidecode -s system-uuid | grep -Po '^(\d+)') count=1