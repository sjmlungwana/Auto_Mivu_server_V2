Nodes:
  - name: N2-Mlungwana-test
    node: server-minion
    client: splitpoint 
    dns:
      - 8.8.8.8
    ntp:
      - 196.4.160.4
    snmp:
      - module: mikrotik
        job_name: SNMP-N2-Mlungwana-test
        targets:
          - 196.15.134.41 
        walk:
            - sysName
            - ifXTable
            - ifTable
            - hrProcessorLoad
            - hrSystemUptime
            - hrMemorySize
            - hrStorageTable
            - sysUpTime
            - sysDescr
            - mtxrFirmwareVersion
            - mtxrHlProcessorFrequency
            - mtxrSerialNumber
            - mtxrLicSoftwareId
            - hrSystemDate
        community: public
        scrape_interval: 60
        scrape_timeout: 30      
    importanthosts:
      - dest: mybroadband.co.za
        port: 443
      - dest: www.google.com
        port: 443
      - dest: office365.com
        port: 443            
    probes:
      - module: tcp_connect
        targets:
          - "https://mybroadband.co.za"
          - "https://office365.com"
          - "https://amazon.com"
          - "https://google.com"
        scrape_interval: 60
        scrape_timeout: 30
        job_name: TCP-N2-Mlungwana-test
      tstat:
        - interface: eth0
          subnets:
            - 11.47.4.0/24