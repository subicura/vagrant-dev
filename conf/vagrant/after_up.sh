#!/bin/sh

echo "Executing trigger after up..."

ls
ls /vagrant
docker-compose -f /vagrant/conf/docker-compose/docker-compose.dev.yml up -d
