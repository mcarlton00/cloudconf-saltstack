{% set role = salt['grains.get']('ec2_roles', '') %}

base:
  '*':
    - base
  'ec2_roles:{{ role }}':
    - match: grain
    - {{ role }}
