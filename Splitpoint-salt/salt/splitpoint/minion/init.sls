schedule-conf:
  file.managed:
    - template: jinja
    - makedirs: True
    - mode: 755
    - name: /etc/salt/minion.d/highstate_schedule.conf
    - source: salt://splitpoint/minion/highstate_schedule.conf

backoff-conf:
  file.managed:
    - template: jinja
    - makedirs: True
    - mode: 755
    - name: /etc/salt/minion.d/backoff.conf
    - source: salt://splitpoint/minion/backoff.conf

salt-minion-start:
  service.running:
    - reload: True
    - name: salt-minion

systemctl restart salt-minion:
  cron.present:
    - user: root
    - minute: random
    - hour: 0
