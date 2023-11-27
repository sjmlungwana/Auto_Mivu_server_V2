{% set vlans = salt['grains.get']('vlans') %}
{% set dns = salt['grains.get']('dns') %}
timesyncdupdate:
  file.managed:
    - template: jinja
    - makedirs: True
    - mode: 555
    - name: /etc/systemd/timesyncd.conf
    - source: salt://splitpoint/networking/timesyncd.conf
{% if dns is defined and dns|length %}
resolveconfupdate:
  file.managed:
    - template: jinja
    - makedirs: True
    - mode: 555
    - name: /etc/resolv.conf
    - source: salt://splitpoint/networking/resolve.conf
{% endif %}
splitpoint_grainses:
  file.managed:
    - makedirs: True
    - template: jinja
    - name: /etc/salt/grains
    - source: salt://splitpoint/grain/grains
{% if vlans is defined %}
{% for routes in vlans -%}
modprobe_{{routes.rawdevice}}.{{routes.vlanid}}:
  cmd.run:
    - name: modprobe 8021q
    - creates: /etc/systemd/network/{{routes.rawdevice}}.{{routes.vlanid}}.netdev
NetdevVlan_{{routes.rawdevice}}.{{routes.vlanid}}Update:
  file.managed:
    - template: jinja
    - makedirs: True
    - mode: 555
    - name: /etc/systemd/network/{{routes.rawdevice}}.{{routes.vlanid}}.netdev
    - source: salt://splitpoint/networking/VlanTemplateNetDev
    - context:
        rawdevice: {{routes.rawdevice}}
        vlanid: {{routes.vlanid}}
        ip_addr: {{routes.ip_addr}}
        {% if routes.routes is defined and routes.routes|length %}
        routes: {{routes.routes}}
        {% endif %}
vconfigadd{{routes.rawdevice}}.{{routes.vlanid}}:
  cmd.run:
    - name:  vconfig add {{routes.rawdevice}} {{routes.vlanid}}
    - creates: /etc/systemd/network/{{routes.rawdevice}}.{{routes.vlanid}}.network  
NetworkVlan_{{routes.rawdevice}}.{{routes.vlanid}}Update:
  file.managed:
    - template: jinja
    - makedirs: True
    - mode: 555
    - name: /etc/systemd/network/{{routes.rawdevice}}.{{routes.vlanid}}.network
    - source: salt://splitpoint/networking/VlanTemplate
    - context:
        rawdevice: {{routes.rawdevice}}
        vlanid: {{routes.vlanid}}
        ip_addr: {{routes.ip_addr}}
        {% if routes.routes is defined and routes.routes|length %}
        routes: {{routes.routes}}
        {% endif %}
vlanReload-yaml-check_{{routes.rawdevice}}.{{routes.vlanid}}:
  cmd.wait:
    - name: systemctl restart systemd-networkd
    - watch:
      - file: /etc/systemd/network/{{routes.rawdevice}}.{{routes.vlanid}}.network
{% endfor %}
8021q-create:
  cmd.run:
    - name: echo "8021q" > /etc/modules-load.d/8021q.conf
    - creates: /etc/modules-load.d/8021q.conf
DisableIPv6:
  file.managed:
    - template: jinja
    - makedirs: True
    - mode: 555
    - name: /etc/sysctl.d/99-sysctl.conf
    - source: salt://splitpoint/networking/99-sysctl.conf
{% endif %}
