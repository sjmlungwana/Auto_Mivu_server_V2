hosts-file:
  file.managed:
    - name: /etc/hosts
    - source: salt://splitpoint/hosts/{{ grains['id'] }}.hosts
    - mode: 766


