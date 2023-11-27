MivuMonitor-default-conf:
  file.managed:
    - makedirs: True
    - mode: 666
    - name: /etc/MivuMonitor/telegraf.conf
    - source: salt://splitpoint/MivuMonitor/telegraf.conf

MivuMonitor-basic-conf:
  file.managed:
    - template: jinja
    - makedirs: True
    - mode: 666
    - name: /etc/MivuMonitor/telegraf.d/basic.conf
    - source: salt://splitpoint/MivuMonitor/basic.conf

MivuMonitor-service:
  file.managed:
    - makedirs: True
    - mode: 666
    - name: /etc/systemd/system/MivuMonitor.service
    - source: salt://splitpoint/MivuMonitor/MivuMonitor.service


MivuMonitor-sh:
  file.managed:
    - makedirs: True
    - mode: 776
    - name: /usr/local/bin/MivuMonitor.sh
    - source: salt://splitpoint/MivuMonitor/MiviMonitor.sh

MivuMonitor-restarter:
  cmd.wait:
    - name: systemctl restart MivuMonitor
    - watch:
      - file: /etc/MivuMonitor/telegraf.d/basic.conf

MivuMonitor-restart:
  service.running:
    - name: MivuMonitor
    - enable: True
