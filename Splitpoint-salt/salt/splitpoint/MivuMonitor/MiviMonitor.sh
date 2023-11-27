#!/bin/bash
/usr/bin/telegraf -config /etc/MivuMonitor/telegraf.conf -config-directory /etc/MivuMonitor/telegraf.d $TELEGRAF_OPTS &