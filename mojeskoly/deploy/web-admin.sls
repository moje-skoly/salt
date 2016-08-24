{% set appKey = 'web-admin' %}

{% include "mojeskoly/deploy/deploy-repo.jinja" %}

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
    - runas: www-data
    - watch:
      - git: deploy-repo-web-admin
    - require:
      - file: web-admin-production-config

web-admin-production-config:
  file.managed:
    - name: /var/www/web-admin/app/config/config_prod.yml
    - template: jinja
    - source: salt://mojeskoly/files/config_prod.yml
