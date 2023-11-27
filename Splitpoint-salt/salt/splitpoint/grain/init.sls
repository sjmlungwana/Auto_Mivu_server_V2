splitpoint_grains:
  file.managed:
    - makedirs: True
    - template: jinja
    - name: /etc/salt/grains
    - source: salt://splitpoint/grain/grains

get_new_grains:
  module.run:
    - name: saltutil.sync_grains
    - refresh: True  
    - reload_grains: True
