{% for app in salt['pillar.get']('mojeskoly:apps', []) %}
deploy-repo-{{ app.name }}:
  git.latest:
    - name: {{ app.repo }}
    - target: /var/www/{{ app.name }}
{% endfor %}
