pigrains:
  file.managed:
    - template: jinja
    - makedirs: True
    - mode: 755
    - name: /etc/salt/minion.d/grains
    - source: salt://splitpoint/pi/grains
    - replaceTrue: False

aptupdate:
  cmd.run:
    - name: apt update

installvlans:
  cmd.run:
    - name: apt install vlan -y

installsnmp:
  cmd.run:
    - name: apt install snmp -y

schedulerminion:
  file.managed:
    - template: jinja
    - makedirs: True
    - mode: 755
    - name: /etc/salt/minion.d/_schedule.conf
    - source: salt://splitpoint/reappropriate/grain/_schedule.conf

cleanedStamp:
  cmd.run: 
    - name: echo "Splitpoint Solutions Pty Ltd, Installed $(date)" > /etc/motd

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

FORTINETCORE642mib:
  file.managed:
    - name: /usr/share/snmp/mibs/FORTINET-CORE-MIB.mib
    - source: salt://splitpoint/prom-probe/FORTINET-CORE-6.4.2.mib

FORTINETFORTINET642mib:
  file.managed:
    - name: /usr/share/snmp/mibs/FORTINET-FORTIGATE-MIB.mib
    - source: salt://splitpoint/prom-probe/FORTINET-FORTINET-6.4.2.mib