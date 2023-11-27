telegraf-api-template-basic-conf:
  file.managed:
    - template: jinja
    - makedirs: True
    - mode: 755
    - name: /etc/api-template/telegraf.conf
    - source: salt://splitpoint/api-template/telegraf.conf


telegraf-template-conf:
  file.managed:
    - template: jinja
    - makedirs: True
    - mode: 755
    - name: /etc/api-template/telegraf.d/template.conf
    - source: salt://splitpoint/api-template/template.conf

telegraf-api-template-service:
  file.managed:
    - makedirs: True
    - mode: 755
    - name: /etc/systemd/system/api-template.service
    - source: salt://splitpoint/api-template/api-template.service

api-template-restart:
  cmd.run:
    - name: systemctl restart api-template
    - watch:
      - file: /etc/api-template/telegraf.d/template.conf
      - file: /etc/api-template/telegraf.conf
