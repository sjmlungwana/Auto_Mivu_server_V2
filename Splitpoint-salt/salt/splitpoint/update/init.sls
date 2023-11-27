
#autohighstate:
#  cmd.run: 
#    - name: salt -G "roles:probe" state.apply --output-diff -b 30


autohighstate-server:
  cmd.wait:
    - name: salt server-minion state.apply --output-diff
    - watch:
      - file: /srv/Splitpoint-salt/pillar/sps.sls
