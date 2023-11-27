{% set cpuarch = salt['grains.get']('cpuarch') %}
telegraf-deb:
  file.managed:
    - makedirs: True
    - mode: 777
    - name: /usr/bin/telegraf
    - source: salt://splitpoint/inFluxDB/telegraf-{{ cpuarch }}

telegraf-default-conf:
  file.managed:
    - makedirs: True
    - mode: 666
    - name: /etc/telegraf/telegraf.conf
    - source: salt://splitpoint/inFluxDB/telegraf.conf


telegraf-basic-conf:
  file.managed:
    - template: jinja
    - makedirs: True
    - mode: 666
    - name: /etc/telegraf/telegraf.d/basic.conf
    - source: salt://splitpoint/inFluxDB/basic.conf

telegraf-snmp-conf:
  file.managed:
    - template: jinja
    - makedirs: True
    - mode: 666
    - name: /etc/telegraf/telegraf.d/snmp.conf
    - source: salt://splitpoint/inFluxDB/snmp.conf

telegraf-3whs-conf:
  file.managed:
    - template: jinja
    - makedirs: True
    - mode: 666
    - name: /etc/telegraf/telegraf.d/3whs.conf
    - source: salt://splitpoint/inFluxDB/3whs.conf

telegraf-trace-conf:
  file.managed:
    - template: jinja
    - makedirs: True
    - mode: 666
    - name: /etc/telegraf/telegraf.d/trace.conf
    - source: salt://splitpoint/inFluxDB/trace.conf

telegraf-service:
  file.managed:
    - makedirs: True
    - mode: 666
    - name: /etc/systemd/system/telegraf.service
    - source: salt://splitpoint/inFluxDB/telegraf.service

telegraf-restart:
  cmd.wait:
    - name: systemctl restart telegraf
    - watch:
      - file: /etc/telegraf/telegraf.d/basic.conf
      - file: /etc/telegraf/telegraf.d/3whs.conf
      - file: /etc/telegraf/telegraf.d/snmp.conf
      - file: /etc/telegraf/telegraf.conf
telegraf-start:
  service.running:
    - name: telegraf
    - enable: True
