vpn-config:
  file.managed:
    - makedirs: True
    - template: jinja
    - name: /etc/openvpn/client.conf
    - source: salt://splitpoint/vpn/client.conf

vpn-service:
  service.enabled:
    - name: openvpn@client.service
    - require:
        - file: vpn-config

vpn-enable:
  service.enabled:
    - name: openvpn@client.service

sps-rsyslog-cert:
  file.managed:
    - makedirs: True
    - name: /etc/rsyslog.pki/client.crt
    - source: salt://pki/issued/{{ grains['id'] }}.crt
    - mode: 400

sps-rsyslog-key:
  file.managed:
    - makedirs: True
    - name: /etc/rsyslog.pki/client.key
    - source: salt://pki/private/{{ grains['id'] }}.key
    - mode: 400

sps-rsyslog-cacert:
  file.managed:
    - makedirs: True
    - name: /etc/rsyslog.pki/ca.crt
    - source: salt://pki/ca.crt
    - mode: 400

vpn-start:
  service.running:
    - enable: True
    - reload: True
    - name: openvpn@client.service

reboot:
  cmd.run:
    - name: systemctl restart openvpn@client
    - creates: /etc/openvpn/completed

vpn-confirm.true:
  cmd.run:
    - name: touch /etc/openvpn/completed

vpn-mine-update:
  cmd.run:
    - name:  salt-call mine.update
