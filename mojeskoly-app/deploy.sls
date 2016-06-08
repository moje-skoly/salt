deploy-key:
  cmd.run:
  - name: ssh-keygen -t rsa -b 4096 -C "server's root deploy key"
  - unless: test -f ~/.ssh/id_rsa
