#sps-backup:
#  cmd.run:
#    - name:  cp /srv/Splitpoint-salt/pillar/sps.sls /srv/sps-$(date "+%F-%T").sls

prometheus-backup:
  cmd.run:
    - name:  cp /etc/prometheus/prometheus.yml /var/lib/docker/prometheus/backups/prometheus-$(date "+%F-%T").yml

#sps-mine-update:
#  cmd.run:
#    - name:  salt 'server-minion' mine.update

prometheus-yaml:
  file.managed:
    - makedirs: True
    - template: jinja
    - name: /etc/prometheus/prometheus.yml
    - source: salt://splitpoint/prom-server/prometheus.yml
    - backup: minion

prometheus-yaml-check:
  cmd.wait:
    - name: promtool check config /etc/prometheus/prometheus.yml
    - watch:
      - file: /etc/prometheus/prometheus.yml

prometheus-yaml-reload:
  cmd.wait:
    - name: curl -X POST http://localhost:9090/-/reload &
    - watch:
      - file: /etc/prometheus/prometheus.yml
