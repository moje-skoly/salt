include:
  - .web-admin
  - .web-app
  - .web-api

{% for app in salt['pillar.get']('mojeskoly:apps', []) %}
deploy-repo-{{ app.name }}:
  git.latest:
    - name: {{ app.repo }}
    - target: /var/www/{{ app.name }}
    - branch: master
    - user: www-data
    - force_fetch: True
    - force_checkout: True
    - force_reset: True

deploy-dir-{{ app.name }}:
  file.directory:
    - name: /var/www/{{ app.name }}
    - user: www-data
    - group: www-data
    - mode: 775
    - require_in:
      - git: deploy-repo-{{ app.name }}
{% endfor %}


deploy-npm-cache-dir:
  file.directory:
    - name: /var/www/.npm
    - user: www-data
    - group: www-data
