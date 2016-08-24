{% set appKey = 'web-admin' %}

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

web-admin-cache-dir:
  file.directory:
    - user: www-data
    - group: www-data

    - name: /var/www/web-admin/app/cache
    - mode: 777
    - recurse:
      - user
      - group
      - mode
    - watch:
      - git: deploy-repo-web-admin

web-admin-logs-dir:
  file.directory:
    - user: www-data
    - group: www-data
    - name: /var/www/web-admin/app/logs
    - mode: 777
    - recurse:
      - user
      - group
      - mode
    - watch:
      - git: deploy-repo-web-admin

web-admin-post-deploy-composer:
  cmd.run:
    - name: SYMFONY_ENV=prod composer install --no-interaction --optimize-autoloader --ignore-platform-reqs
    - cwd: /var/www/web-admin
    - user: www-data
    - watch:
      - git: deploy-repo-web-admin
    - require:
      - file: web-admin-production-config

web-admin-production-config:
  file.managed:
    - name: /var/www/web-admin/app/config/config_prod.yml
    - template: jinja
    - source: salt://mojeskoly/files/config_prod.yml
