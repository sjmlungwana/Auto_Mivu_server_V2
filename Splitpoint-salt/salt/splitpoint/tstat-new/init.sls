{% set cpuarch = salt['grains.get']('cpuarch') %}
{% set interface = salt['grains.get']('tstat:interface') %}
{% if interface is defined and interface|length %}

/opt/splitpoint/tstat/var/{{interface}}:
  mount.mounted:
    - device: tmpfs
    - fstype: tmpfs
    - opts: rw,size=1G
    - persist: True
    - mkmnt: True
    
tstat-bin:
  file.managed:
    - makedirs: True
    - mode: 777
    - name: /usr/bin/tstat
    - source: salt://splitpoint/tstat/tstat-{{ cpuarch }}

tstatCapture-service-{{interface}}:
  file.managed:
    - template: jinja
    - makedirs: True
    - mode: 600
    - name: /etc/systemd/system/tstatCapture{{interface}}.service
    - source: salt://splitpoint/tstat/systemd/tstatCaptureEth0.service

tstatHistgram-service-{{interface}}:
  file.managed:
    - template: jinja
    - makedirs: True
    - mode: 600
    - name: /etc/systemd/system/tstatHistgram{{interface}}.service
    - source: salt://splitpoint/tstat/systemd/tstatHistgramEth0.service

tstatTcpComplete-service-{{interface}}:
  file.managed:
    - template: jinja
    - makedirs: True
    - mode: 600
    - name: /etc/systemd/system/tstatTcpComplete{{interface}}.service
    - source: salt://splitpoint/tstat/systemd/tstatTcpCompleteEth0.service

tstatTcpNoneComplete-service-{{interface}}:
  file.managed:
    - template: jinja
    - makedirs: True
    - mode: 600
    - name: /etc/systemd/system/tstatTcpNoneComplete{{interface}}.service
    - source: salt://splitpoint/tstat/systemd/tstatTcpNoneCompleteEth0.service

tstatUdpComplete-service-{{interface}}:
  file.managed:
    - template: jinja
    - makedirs: True
    - mode: 600
    - name: /etc/systemd/system/tstatUdpComplete{{interface}}.service
    - source: salt://splitpoint/tstat/systemd/tstatUdpCompleteEth0.service
# FileBeats Yaml

filebeatHistogram-yml-{{interface}}:
  file.managed:
    - template: jinja
    - makedirs: True
    - mode: 600
    - name: /etc/filebeat/filebeatHistogram{{interface}}.yml
    - source: salt://splitpoint/tstat/filebeat/filebeatHistogramEth0.yml

filebeatHttpComplete-yml-{{interface}}:
  file.managed:
    - template: jinja
    - makedirs: True
    - mode: 600
    - name: /etc/filebeat/filebeatHttpComplete{{interface}}.yml
    - source: salt://splitpoint/tstat/filebeat/filebeatHttpCompleteEth0.yml

filebeatTcpComplete-yml-{{interface}}:
  file.managed:
    - template: jinja
    - makedirs: True
    - mode: 600
    - name: /etc/filebeat/filebeatTcpComplete{{interface}}.yml
    - source: salt://splitpoint/tstat/filebeat/filebeatTcpCompleteEth0.yml

filebeatTcpNoneComplete-yml-{{interface}}:
  file.managed:
    - template: jinja
    - makedirs: True
    - mode: 600
    - name: /etc/filebeat/filebeatTcpNoneComplete{{interface}}.yml
    - source: salt://splitpoint/tstat/filebeat/filebeatTcpNoneCompleteEth0.yml

filebeatUdpComplete-yml-{{interface}}:
  file.managed:
    - template: jinja
    - makedirs: True
    - mode: 600
    - name: /etc/filebeat/filebeatUdpComplete{{interface}}.yml
    - source: salt://splitpoint/tstat/filebeat/filebeatUdpCompleteEth0.yml

globals-conf:
  file.managed:
    - template: jinja
    - makedirs: True
    - mode: 600
    - name: /opt/splitpoint/tstat/etc/globals.conf
    - source: salt://splitpoint/tstat/etc/globals.conf

local-network-conf:
  file.managed:
    - template: jinja
    - makedirs: True
    - mode: 600
    - name: /opt/splitpoint/tstat/etc/local-networks.conf
    - source: salt://splitpoint/tstat/etc/local-networks.conf

histogram-conf:
  file.managed:
    - template: jinja
    - makedirs: True
    - mode: 600
    - name: /opt/splitpoint/tstat/etc/histogram.conf
    - source: salt://splitpoint/tstat/etc/histo.conf

runtime-conf:
  file.managed:
    - template: jinja
    - makedirs: True
    - mode: 600
    - name: /opt/splitpoint/tstat/etc/runtime.conf
    - source: salt://splitpoint/tstat/etc/runtime.conf


promisc-{{interface}}-conf:
  file.managed:
    - template: jinja
    - makedirs: True
    - mode: 600
    - name: /etc/systemd/system/promisc-{{interface}}.service
    - source: salt://splitpoint/tstat/promisc.service


tstatCapture-{{interface}}-start:
  service.running:
    - enable: True
    - reload: True
    - name: tstatCapture{{interface}}.service
######
tstatChatCompleteEth0-{{interface}}-start:
  service.disabled:
    - enable: False
    - name: tstatChatComplete{{interface}}.service

tstatChatMessagesEth0-{{interface}}-start:
  service.disabled:
    - enable: False
    - name: tstatChatMessages{{interface}}.service

tstatHistgramEth0-{{interface}}-start:
  service.running:
    - enable: True
    - reload: True
    - name: tstatHistgram{{interface}}.service

tstatHttpCompleteEth0-{{interface}}-start:
  service.disabled:
    - enable: False
    - name: tstatHttpComplete{{interface}}.service

tstatMmCompleteEth0-{{interface}}-start:
  service.disabled:
    - enable: False
    - name: tstatMmComplete{{interface}}.service

tstatTcpCompleteEth0-{{interface}}-start:
  service.running:
    - enable: True
    - reload: True
    - name: tstatTcpComplete{{interface}}.service

tstatTcpNoneCompleteEth0-{{interface}}-start:
  service.running:
    - enable: True
    - reload: True
    - name: tstatTcpNoneComplete{{interface}}.service

tstatUdpCompleteEth0-{{interface}}-start:
  service.running:
    - enable: True
    - reload: True
    - name: tstatUdpComplete{{interface}}.service

tstatVideoCompleteEth0-{{interface}}-start:
  service.disabled:
    - enable: False
    - name: tstatVideoComplete{{interface}}.service

promisc.service-{{interface}}-start:
  service.running:
    - enable: True
    - reload: True
    - name: promisc-{{interface}}.service

/usr/bin/find /opt/splitpoint/tstat/var/* -maxdepth 2 -type d -mmin +70 -exec rm -rf {} +:
  cron.present:
    - user: root
    - minute: '*/5'

{%else%}


    {%endif%}