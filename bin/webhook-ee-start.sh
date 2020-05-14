#!/bin/sh

DOCKER_ENV=/opt/ee/elexis-environment/.env

IPADDR_ETH=$(ifdata -pa eth0)
sed -i "s/RDBMS_HOST=.*/RDBMS_HOST=$IPADDR_ETH/g" $DOCKER_ENV

/opt/ee/elexis-environment/ee system cmd up -d --build

echo "OK"