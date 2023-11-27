{% set cpuarch = salt['grains.get']('cpuarch') %}
telegraf-serial-conf:
  file.managed:
    - makedirs: True
    - mode: 777
    - name: /usr/bin/serial.sh
    - source: salt://splitpoint/serial/serial-{{ cpuarch }}.sh


telegraf-telegraf-serial-conf:
  file.managed:
    - makedirs: True
    - mode: 777
    - name: /etc/telegraf/telegraf.d/serial.conf
    - source: salt://splitpoint/serial/serial.conf
{% if grains['cpuarch'] == 'x86_64' %}

telegraf-dmi-conf:
  file.managed:
    - makedirs: True
    - mode: 755
    - name: /tmp/dmi.deb
    - source: salt://splitpoint/serial/dmi.deb


install-serial-dmi:
  cmd.wait:
    - name: dpkg -i /tmp/dmi.deb
    - watch:
      - file: /tmp/dmi.deb
{% endif %}
