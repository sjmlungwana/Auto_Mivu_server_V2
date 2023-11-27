snmp-mibs:
  file.recurse:
    - name: /usr/share/snmp/mibs
    - source: salt://splitpoint/mibs/mibs
    - clean: false
    - makedirs: true
    - replaceTrue: false 
    
#FORTINETCORE642mib:
#  file.managed:
#    - name: /usr/share/snmp/mibs/FORTINET-CORE-MIB.mib
#    - source: salt://splitpoint/prom-probe/FORTINET-CORE-6.4.2.mib
#FORTINETFORTINET642mib:
#  file.managed:
#    - name: /usr/share/snmp/mibs/FORTINET-FORTIGATE-MIB.mib
#    - source: salt://splitpoint/prom-probe/FORTINET-FORTINET-6.4.2.mib
