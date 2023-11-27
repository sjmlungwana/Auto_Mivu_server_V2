installing code server:
  cmd.run:
    - name: sudo curl -fsSL https://code-server.dev/install.sh | sh

pre-start code-server:
  cmd.run:
    - name: code-server

code-server config:
  cmd.run:
    - name: sudo cp config.yaml ~/.config/code-server/

start-code-server:
  cmd.run:
    - name: sudo systemctl start code-server@root

install grafana:
  cmd.run:
    - name: sudo sh grafana.sh

install influxdb:
  cmd.run:
    - name: sudo sh influxdb.sh

install chronograf:
  cmd.run:
    - name: sudo sh chronograf.sh