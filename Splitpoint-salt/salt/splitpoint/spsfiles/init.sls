sps-int-csv:
  file.managed:
    - makedirs: True
    - template: jinja
    - name: ~/sps.csv
    - source: salt://splitpoint/spsfiles/prometheus.yml


sps-int-csv-all:
  file.managed:
    - makedirs: True
    - template: jinja
    - name: ~/all.csv
    - source: salt://splitpoint/spsfiles/prometheus1.yml

core-int-csv-all:
  file.managed:
    - makedirs: True
    - template: jinja
    - name: ~/core.csv
    - source: salt://splitpoint/spsfiles/prometheuscore.yml
