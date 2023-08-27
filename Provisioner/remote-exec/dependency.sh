#!/bin/bash
sudo apt update
sudo apt-add-repository ppa:ansible/ansible -y,
sudo apt install ansible -y
chmod +x /home/ubuntu/tomcat9.yaml 
chmod +x /home/ubuntu/nginx.yaml
echo '''ubuntu@localhost''' > inventory
chmod 600 /home/ubuntu/id_rsa
ssh-keyscan -H localhost >> ~/.ssh/known_hosts
ansible -i inventory -m ping all --private-key /home/ubuntu/id_rsa
