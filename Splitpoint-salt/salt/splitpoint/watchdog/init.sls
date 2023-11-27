{% if salt.grains.get('osarch') == 'armhf' %}

watchdog-modprobe:
  file.managed:
    - makedirs: True
    - mode: 666
    - name: /etc/modprobe.d/watchdog.conf
    - source: salt://splitpoint/watchdog/watchdog-modprobe

watchdog-conf:
  file.managed:
    - makedirs: True
    - mode: 666
    - name: /etc/watchdog.conf
    - source: salt://splitpoint/watchdog/watchdog.conf

watchdog-default:
  file.managed:
    - makedirs: True
    - mode: 666
    - name: /etc/default/watchdog
    - source: salt://splitpoint/watchdog/watchdog-default

watchdog-enable:
  service.enabled:
    - name: watchdog

watchdog-start:
  service.running:
    - enable: True
    - name: watchdog

filebeatdpkgpush:
  file.managed:
  - name: /tmp/filebeat.deb
  - source: salt://netops/tstat/filebeat-amd64.deb
  - creates: /tmp/filebeat.deb
  
filebeatdpkg:
  cmd.wait:
  - name: DEBIAN_FRONTEND=noninteractive dpkg --i /tmp/filebeat.deb
  - watch:
    - file: filebeatdpkgpush

{% endif %}
