# Splitpoint-salt.
Salt states for managing edge Hamsters and wheels.

Salt States.

    - splitpoint.vpn
      Copy certs and install client.conf.
      
    - splitpoint.grain        
      Sync the grains file with server sps.sls.
      
    - splitpoint.inFluxDB     
      Configure Telegraf.
      
    - splitpoint.watchdog     
      Rpi watchdog timer.
      
    - splitpoint.TraceRoute    
      Write and configure MTR test batch file.
      
    - splitpoint.prom-probe   
      Configure and copy files required for the prometheus jobs.
      
    - splitpoint.networking   
      Configure NTP,VLAN,DNS.
      
    - splitpoint.minion       
      Configure minion backoff and highstate interval.
      
    - splitpoint.tstat         
      Copy configure and start Filebeats and Tstat.
