base:
  'roles:server':
    - match: grain
    - splitpoint.server
    - splitpoint.server-probe

  'roles:prometheus':
    - match: grain
    - splitpoint.prom-server
    - splitpoint.vpn

  'roles:new':
    - match: grain
    - splitpoint.vpn
    - splitpoint.grain
    
  'roles:baseline1':
    - match: grain
    - splitpoint.vpn
    - splitpoint.grain
    - splitpoint.reappropriate

  'roles:probe':
    - match: grain
    - splitpoint.vpn
    - splitpoint.grain
    - splitpoint.MivuMonitor
    - splitpoint.mibs
    - splitpoint.minion
    - splitpoint.watchdog
    - splitpoint.TraceRoute
    - splitpoint.tstat
    - splitpoint.edge-ui
    - splitpoint.hosts
    - splitpoint.prom-probe
    - splitpoint.inFluxDB
    - splitpoint.networking
    - splitpoint.api
    - splitpoint.serial
    - splitpoint.api-template
  'configured:tag':
    - match: grain
    - splitpoint.vpn
    - splitpoint.grain
    - splitpoint.reappropriate

  'id:dca6*':
    - match: grain
    - splitpoint.vpn
    - splitpoint.grain
    - splitpoint.pi

  '*':
    - match: grain
    - splitpoint.vpn
    - splitpoint.grain
    - splitpoint.reappropriate
