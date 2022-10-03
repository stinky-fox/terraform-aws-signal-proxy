#!/bin/bash

export FQDN="<POINT TO YOUR FULL FQDN>"
amazon-linux-extras install docker
pip3 install docker-compose
ln /usr/local/bin/docker-compose /usr/bin/docker-compose
yum install git -y
systemctl enable --now docker
mkdir -p /home/ec2-user/signal
git clone https://github.com/signalapp/Signal-TLS-Proxy.git /home/ec2-user/signal
cd /home/ec2-user/signal/
echo $FQDN | bash init-certificate.sh
/usr/local/bin/docker-compose up --detach
