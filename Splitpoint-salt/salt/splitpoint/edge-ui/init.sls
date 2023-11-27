{% set cpuarch = salt['grains.get']('cpuarch') %}
Menu:
  file.managed:
    - mode: 775
    - name: /bin/menu
    - source: salt://splitpoint/edge-ui/menu

installsudoersui:
  cmd.run:
    - name: apt install sudo -y

MenuConf:
  file.managed:
    - mode: 775
    - name: /etc/menu.conf
    - source: salt://splitpoint/edge-ui/menu.conf

ui:
  user.present:
    - fullname: ui
    - shell: /bin/bash /bin/menu
    - groups:
      - root

groupui:
  group.present:
    - name: ui
    - system: True
    - addusers:
      - ui

SudoerstemppassUI:
  cmd.run:
    - name: echo ui:ui | /usr/sbin/chpasswd

Sudoersui:
  cmd.run:
    - name: 'echo "ui ALL=NOPASSWD: ALL" > /etc/sudoers.d/ui'

dialog:
  pkg.installed:
    - sources:
      - dialog: salt://splitpoint/edge-ui/dialog-{{ cpuarch }}.deb

ui-conf:
  file.managed:
    - makedirs: True
    - name: /etc/systemd/system/getty@tty1.service.d/menu.conf
    - source: salt://splitpoint/edge-ui/uiservicefile

ui-conf-serial:
  file.managed:
    - makedirs: True
    - name: /etc/systemd/system/serial-getty@ttyS0.service.d/menu.conf
    - source: salt://splitpoint/edge-ui/uiservicefile

edge-ui-service:
  service.enabled:
    - name: getty@tty1
    - require:
        - file: ui-conf-serial
        - file: ui-conf

daemon-reload:
  cmd.run:
    - name: systemctl daemon-reload

