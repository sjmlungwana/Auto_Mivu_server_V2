
TraceRoute-scriptin:
  file.managed:
    - makedirs: True
    - mode: 755
    - name: /usr/local/bin/TraceRoute
    - template: jinja
    - source: salt://splitpoint/TraceRoute/TraceRoute
