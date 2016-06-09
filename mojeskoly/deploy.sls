{% for app in salt['pillar.get']('mojeskoly:apps', []) %}
deploy-repo-{{ app.name }}:
  git.latest:
    - name: {{ app.repo }}
    - target: /var/www/{{ app.name }}
    - branch: master
    - force_fetch: True
    - force_checkout: True
    - force_reset: True
{% endfor %}

web-admin-cache-dir:
  file.directory:
    - user: www-data
    - group: www-data

    - name: /var/www/web-admin/app/cache
    - recurse:
      - user
      - group
    - watch:
      - git: deploy-repo-web-admin

web-admin-logs-dir:
  file.directory:
    - user: www-data
    - group: www-data
    - name: /var/www/web-admin/app/logs
    - recurse:
      - user
      - group
    - watch:
      - git: deploy-repo-web-admin

web-admin-post-deploy-composer:
  cmd.run:
    - name: SYMFONY_ENV=prod composer install --no-interaction --optimize-autoloader --ignore-platform-reqs
    - cwd: /var/www/web-admin
    - watch:
      - git: deploy-repo-web-admin
