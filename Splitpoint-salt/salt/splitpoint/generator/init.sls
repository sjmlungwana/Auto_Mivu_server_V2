{% set cpuarch = salt['grains.get']('cpuarch') %}
{% set snmp = salt['grains.get']('snmp') %}

snmp_exporter-deb:
  file.managed:
    - makedirs: True
    - mode: 755
    - name: /usr/bin/snmp_exporter
    - source: salt://splitpoint/prom-probe/snmp_exporter-{{ cpuarch }}
    - replace: False
snmp_exporter-generator-panix-abs:
  file.absent:
    - name: /usr/local/bin/generator
snmp_exporter-generator-deb:
  file.managed:
    - makedirs: True
    - mode: 755
    - name: /usr/local/bin/generator
    - source: salt://splitpoint/prom-probe/generator-{{ cpuarch }}
    - replace: False
generator_exporter_yaml:
  file.managed:
    - template: jinja
    - makedirs: True
    - mode: 666
    - name: /etc/snmp_exporter/generator.yml
    - source: salt://splitpoint/prom-probe/generator.yml

generator-yaml-generate:
  cmd.run:
    - name: generator generate
    - cwd: /etc/snmp_exporter/

snmp_exporter-service:
  file.managed:
    - template: jinja
    - makedirs: True
    - mode: 755
    - name: /etc/systemd/system/snmp_exporter.service
    - source: salt://splitpoint/prom-probe/snmp_exporter.service

snmp_exporter-start:
  service.running:
    - enable: True
    - reload: False
    - name: snmp_exporter

daemon-reload-prom:
  cmd.run:
    - name: systemctl daemon-reload

snmp_exporter-restart:
  cmd.run:
    - name: systemctl restart snmp_exporter
    - onchanges:
      - cmd: generator-yaml-generate
