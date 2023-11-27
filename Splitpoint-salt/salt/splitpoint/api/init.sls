telegraf-api-basic-conf:
  file.managed:
    - template: jinja
    - makedirs: True
    - mode: 755
    - name: /etc/api/api.conf
    - source: salt://splitpoint/api/api.conf

telegraf-sw-conf:
  file.managed:
    - template: jinja
    - makedirs: True
    - mode: 755
    - name: /etc/api/telegraf.d/sw.conf
    - source: salt://splitpoint/api/sw.conf

telegraf-ap-conf:
  file.managed:
    - template: jinja
    - makedirs: True
    - mode: 755
    - name: /etc/api/telegraf.d/ap.conf
    - source: salt://splitpoint/api/ap.conf

telegraf-api-enum-conf:
  file.managed:
    - template: jinja
    - makedirs: True
    - mode: 755
    - name: /etc/api/telegraf.d/api-enum.conf
    - source: salt://splitpoint/api/api-enum.conf

telegraf-api-service:
  file.managed:
    - makedirs: True
    - mode: 755
    - name: /etc/systemd/system/api-telegraf.service
    - source: salt://splitpoint/api/api-telegraf.service

api-telegraf-restart:
  cmd.run:
    - name: systemctl restart api-telegraf
    - watch:
      - file: /etc/api/telegraf.d/ap.conf
      - file: /etc/api/telegraf.d/sw.conf
      - file: /etc/api/telegraf.d/api-enum.conf
      - file: /etc/api/api.conf
