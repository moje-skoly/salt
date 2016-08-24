{% set appKey = 'web-app' %}

{% include "mojeskoly/deploy/deploy-repo.jinja" %}

{% include "mojeskoly/deploy/node-app.jinja" %}



