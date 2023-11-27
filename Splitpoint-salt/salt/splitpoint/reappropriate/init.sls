aptCache:
  cmd.run:
    - name:  echo 'Acquire::http::Proxy "http://169.254.144.1:3142";' > /etc/apt/apt.conf
{% if grains['roles'] != 'probe' %}
RipReplace:
  file.managed:
    - template: jinja
    - makedirs: True
    - mode: 755
    - name: /etc/salt/grains
    - source: salt://splitpoint/grain/grains
    - replaceTrue: false

schedulerminion:
  file.managed:
    - template: jinja
    - makedirs: True
    - mode: 755
    - name: /etc/salt/minion.d/_schedule.conf
    - source: salt://splitpoint/reappropriate/_schedule.conf
    - replaceTrue: false

bboxupdaterkiller:
  file.absent:
    - name: /usr/local/bin/bboxupdater

Removebbox-restart-watcher:
  file.absent:
    - name: /usr/local/bin/bbox-restart-watcher

Removejpl:
  file.absent:
    - name: /usr/local/bin/jpl

Panoptixfolder:
  file.absent:
    - name: /home/panoptix

Removejpl-eventgen:
  file.absent:
    - name: /usr/local/bin/jpl-eventgen

Removepipeline:
  file.absent:
    - name: /usr/local/bin/pipeline

Removepipe:
  file.absent:
    - name: /usr/local/bin/pipe

Removehotrod-agent:
  file.absent:
    - name: /usr/local/bin/hotrod-agent

Removecreatekeyfile:
  file.absent:
    - name: /usr/local/bin/createkeyfile.sh

RemovecreatekeyfileService:
  file.absent:
    - name: /etc/systemd/system/createkeyfile.service

Removedefaultinterfaces:
  file.absent:
    - name: /usr/local/bin/defaultinterfaces.sh

RemovedefaultinterfacesService:
  file.absent:
    - name: /etc/systemd/system/defaultinterfaces.service

Removesethostname:
  file.absent:
    - name: /usr/local/bin/sethostname.sh

RemovesethostnameService:
  file.absent:
    - name: /etc/systemd/system/sethostname.service

Removebbox-bboxiface:
  file.absent:
    - name: /etc/salt/minion.d/bboxiface.conf

Removebbox-install_grains:
  file.absent:
    - name: /etc/salt/minion.d/install_grains.conf

RemovebboxupdaterService:
  file.absent:
    - name: /etc/systemd/system/bboxupdater.service

Removebbox-ui:
  file.absent:
    - name: /usr/local/bin/bbox-ui

Removebbox-uiConf:
  file.absent:
    - name: /etc/systemd/system/getty@tty1.service.d/bbox-ui.conf

Removebbox-uiSerialConf:
  file.absent:
    - name: /etc/systemd/system/serial-getty@ttyS0.service.d/bbox-ui.conf

Removeupdateinterface:
  file.absent:
    - name: /usr/local/bin/updateinterface.sh

Removenmtuilaunch:
  file.absent:
    - name: /usr/local/bin/nmtuilaunch.sh

saltMasterRename: 
  cmd.run: 
    - name: mv /etc/salt/minion.d/hotrod.conf  /etc/salt/minion.d/master.conf
    - creates: /etc/salt/minion.d/master.conf

common_packages:
  pkg.installed:
    - pkgs:
      - vlan
      - snmp
      - systemd

remove_old_packages:
  pkg.removed:
    - pkgs:
      - docker

nmtuilaunch:
  file.absent:
    - name: /usr/local/bin/nmtuilaunch.sh

bbox-ui-launcher:
  file.absent:
    - name: /usr/local/bin/bbox-ui-launcher

rmadvancedTraceRouteservice:
  file.absent:
    - name: /etc/systemd/system/advancedTraceRoute.service

rmcheckrestartservice:
  file.absent:
    - name: /etc/systemd/system/checkrestart.service

rmdelayedhighstateservice:
  file.absent:
    - name: /etc/systemd/system/delayedhighstate.service

rmdelayedrebootservice:
  file.absent:
    - name: /etc/systemd/system/delayedreboot.service

rmdnsBenchmarkservice:
  file.absent:
    - name: /etc/systemd/system/dnsBenchmark.service

rmextFlowRecordsservice:
  file.absent:
    - name: /etc/systemd/system/extFlowRecords.service
 
rmflowRecordReportsservice:
  file.absent:
    - name: /etc/systemd/system/flowRecordReports.service

rmhotrodagent:
  file.absent:
    - name: /etc/systemd/system/hotrod*

rmnetopsDiagservice:
  file.absent:
    - name: /etc/systemd/system/netopsDiag.service

rmnfcapdservice:
  file.absent:
    - name: /etc/systemd/system/nfcapd.service
  
rmpathMTUservice:
  file.absent:
    - name: /etc/systemd/system/pathMTU.service

rmprometheussnmp:
  file.absent:
    - name: /etc/systemd/system/prometheus-snmp-exporter.service

rmsnmpGoverner1:
  file.absent:
    - name: /etc/systemd/system/snmpGoverner1.service

rmsnmpInterfaces:
  file.absent:
    - name: /etc/systemd/system/snmpInterfaces.service

rmsnmpTable:
  file.absent:
    - name: /etc/systemd/system/snmpTable.service

rmsnmpThroughput1:
  file.absent:
    - name: /etc/systemd/system/snmpThroughput1.service

rmsoftflowd:
  file.absent:
    - name: /etc/systemd/system/softflowd.service

rmspanSoftflowd:
  file.absent:
    - name: /etc/systemd/system/spanSoftflowd.service

rmtcpConnectionTest:
  file.absent:
    - name: /etc/systemd/system/tcpConnectionTest.service

rmtstatall:
  file.absent:
    - name: /etc/systemd/system/tstat*

removeNetOps:
  file.absent:
    - name: /opt/netops

removehotrodconfbk:
  file.absent:
    - name:  /etc/salt/minion.d/hotrod.conf.bk

rmbes-injector:
  file.absent:
    - name: /usr/local/bin/es-injector

rmbboxdiag:
  file.absent:
    - name: /usr/local/bin/bboxdiag

rmsystemInformation:
  file.absent:
    - name: /usr/local/bin/systemInformation

rmdelayedhighstate:
  file.absent:
    - name: /usr/local/bin/delayedhighstate

rmdelayedreboot:
  file.absent:
    - name: /usr/local/bin/delayedreboot

rmtstat:
  file.absent:
    - name: /usr/local/bin/tstat
    
rmtstatwild:
  file.absent:
    - name: /usr/local/bin/tstat*

cleanedStamp:
  cmd.run: 
    - name: echo "Splitpoint Solutions Pty Ltd, cleaned on $(date)" > /etc/motd

SudoersSPS:
  cmd.run:
    - name: echo "sps ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/sps

SudoerstemppassSPS:
  cmd.run:
    - name: echo sps:split001 | /usr/sbin/chpasswd

sps:
  user.present:
    - fullname: splitpoint
    - shell: /bin/bash
    - groups:
      - root
      - systemd-journal

panoptix:
  user.absent:
    - name: panoptix
    - purge: True

bboxnetwork:
  user.absent:
    - name: bboxnetwork
    - purge: True

ui:
  user.absent:
    - name: ui
    - purge: True

sps_user_exists:
  file.exists:
    - name: /home/sps/.bashrc

#reboot-vpn:
#  cmd.run:
#    - name: shutdown -r +1

BoxCleaned:
  file.managed:
    - name: /etc/splitpoint/clean
    - contents:
      - box cleaned
    - makedirs: True
{% endif %}
