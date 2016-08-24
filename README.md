# Server setup for MojeSkoly.cz

Setup is prepared for Salt Stack configuration management. 

## Bootstrapping new server

```
# as root
curl -L https://bootstrap.saltstack.com -o bootstrap_salt.sh
sh bootstrap_salt.sh
apt-get install python-git
apt-get install software-properties-common
```

create file `/etc/salt/minion.d/settings.conf`:

```
file_client: local
fileserver_backend:
  - roots
  - git
gitfs_remotes:
  - https://github.com/moje-skoly/elasticsearch-formula.git
  - https://github.com/moje-skoly/java-oracle-formula.git
  - https://github.com/moje-skoly/nginx-formula.git
  - https://github.com/moje-skoly/php-formula.git
  - https://github.com/moje-skoly/node-formula.git
  - https://github.com/moje-skoly/composer-formula.git
  - https://github.com/moje-skoly/mysql-formula.git
  - https://github.com/moje-skoly/users-formula.git
```

Files for salt setup are in `https://github.com/moje-skoly/salt` to be cloned into `/srv/salt`. Pillars are in private repository `https://bitbucket.org/mojeskoly/pillar` to be cloned to `/srv/pillar`. 

Generate private key for root user on the server and add the keys to bitbucket repo as deploy keys (it needs to be private because there are passwords in the files). 
