{% set nodes = salt['pillar.get']('Nodes') %}
{% set host = salt['grains.get']('id') %}

{% for node in nodes %}
GenerateVPNCertsfor-{{ node.node }}:
  cmd.run:
    - name: EASYRSA_CERT_EXPIRE=3650 ./easyrsa build-client-full {{ node.node }} nopass
    - creates: /etc/openvpn/server/easy-rsa/pki/private/{{ node.node }}.key
    - cwd: /etc/openvpn/server/easy-rsa/

AcceptNewKey-{{ node.node }}:
  cmd.run:
    - name: salt-key -y -a {{ node.node }} 
    - creates: /etc/splitpoint/complete/{{ node.node }}

AutoFirstState-{{ node.node }}:
  cmd.run:
    - name: salt {{ node.node }} state.apply --output-diff >> /etc/splitpoint/complete/log-{{ node.name }}
    - creates: /etc/splitpoint/complete/{{ node.node }} 

SiteConfigComplete-{{ node.node }}:
  cmd.run:
    - name: touch /etc/splitpoint/complete/{{ node.node }} && salt 'server-minion' telegram.post_message message="$(echo 'site addition complete for {{ node.name }}' && salt {{ node.node }} grains.get ip4_interfaces)"
    - creates: /etc/splitpoint/complete/{{ node.node }}

    {% endfor %}


PromState:
  cmd.run:
    - name: salt prometheus state.apply --output-diff
sps-backup-server:
  cmd.run:
    - name:  cp /srv/Splitpoint-salt/pillar/sps.sls /srv/sps-$(date "+%F-%T").sls
