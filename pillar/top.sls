{% set role = salt['grains.get']('ec2_roles', '') %}

base:
  '*':
    {{ role }}:
      - match: grain
      - {{ role }}

