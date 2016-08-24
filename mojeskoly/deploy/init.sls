include:
  - .web-admin
  - .web-app
  - .web-api

deploy-npm-cache-dir:
  file.directory:
    - name: /var/www/.npm
    - user: www-data
    - group: www-data
