{% for app in pillar.get('mojeskoly:apps', []) %}
deploy-key-{{ app.name }}:
  cmd.run:
    - name: ssh-keygen -q -N '' -f ~/.ssh/id_rsa_{{ app.name }}
    - unless: test -f ~/.ssh/id_rsa_{{ app.name }}

deploy-repo-{{ app.name }}:
  git.latest:
    - name: {{ app.repo }}
    - target: /var/www/{{ app.name }}
    - require:
      - cmd: deploy-key-{{ app.name }}
{% endfor %}
