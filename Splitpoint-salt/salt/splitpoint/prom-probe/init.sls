{% set cpuarch = salt['grains.get']('cpuarch') %}
{% set snmp = salt['grains.get']('snmp') %}
{% set probes = salt['grains.get']('probes') %}
{% if probes is defined and probes|length %}
blackbox-exporter-deb:
  file.managed:
    - makedirs: True
    - mode: 755
    - name: /usr/bin/blackbox_exporter
    - source: salt://splitpoint/prom-probe/blackbox_exporter-{{ cpuarch }}

blackbox_exporter-service:
  file.managed:
    - template: jinja
    - makedirs: True
    - mode: 755
    - name: /etc/systemd/system/blackbox_exporter.service
    - source: salt://splitpoint/prom-probe/blackbox_exporter.service

blackbox_exporter_yaml:
  file.managed:
    - makedirs: True
    - mode: 755
    - name: /etc/blackbox_exporter/blackbox.yml
    - source: salt://splitpoint/prom-probe/blackbox.yml

blackbox_exporter-enable:
  service.enabled:
    - name: blackbox_exporter

blackbox_exporter-start:
  service.running:
    - enable: True
    - reload: True
    - name: blackbox_exporter

{%endif%}

snmp_exporter-deb:
  file.managed:
    - makedirs: True
    - mode: 755
    - name: /usr/bin/snmp_exporter
    - source: salt://splitpoint/prom-probe/snmp_exporter-{{ cpuarch }}

snmp_exporter-generator-deb:
  file.managed:
    - makedirs: True
    - mode: 755
    - name: /usr/bin/generator
    - source: salt://splitpoint/prom-probe/generator-{{ cpuarch }}

generator_snmp_folder:
  cmd.run:
    - name: mkdir /etc/snmp_exporter
    - creates:  /etc/snmp_exporter/snmp.yml

generator_snmp_yaml:
  cmd.run:
    - name: touch /etc/snmp_exporter/snmp.yml
    - creates:  /etc/snmp_exporter/snmp.yml

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
    - onchanges:
      - file: /etc/snmp_exporter/generator.yml

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
      - file: /etc/snmp_exporter/snmp.yml
