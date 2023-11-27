splitpoint_server_grains:
  file.managed:
    - makedirs: True
    - template: jinja
    - name: /etc/salt/grains
    - source: salt://splitpoint/server-probe/grains

    
{% set probes = salt['grains.get']('probes') %}
{% if probes is defined and probes|length %}
blackbox-exporter-deb:
  file.managed:
    - makedirs: True
    - mode: 755
    - name: /usr/bin/blackbox_exporter
    - source: salt://splitpoint/prom-probe/blackbox_exporter-x86_64

blackbox_exporter-service:
  file.managed:
    - makedirs: True
    - template: jinja
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



