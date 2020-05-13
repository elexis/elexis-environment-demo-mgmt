#!/bin/bash
# Incoming  {"adminemail":"ask-user","hostname":"base.demo.myelexis.ch","organisationbasedn":"ask-user","organisationdomain":"ask-user","organisationname":"ask-user"}

DOCKER_ENV=/opt/ee/elexis-environment/.env

echo "<HTML>"

adminemail=$(echo $@ | jq -r '.adminemail')
echo adminemail $adminemail "<br>"
sed -i "s/ADMIN_EMAIL=.*/ADMIN_EMAIL=$adminemail/g" $DOCKER_ENV

hostname=$(echo $@ | jq -r '.hostname')
echo hostname $hostname "<br>"
sed -i "s/EE_HOSTNAME=.*/EE_HOSTNAME=$hostname/g" $DOCKER_ENV
HOST=$(echo $hostname | cut -d"." -f1)
echo "/etc/hostname ->" $HOST "<br>"
echo $HOST > /etc/hostname
echo "/etc/hosts -> 127.0.1.1 "$hostname $HOST "<br>"
sed "s/127\.0\.1\.1.*/127\.0\.1\.1 $hostname $HOST/g" /etc/hosts | sponge /etc/hosts

organisationbasedn=$(echo $@ | jq -r '.organisationbasedn')
echo organisationbasedn $organisationbasedn "<br>"
sed -i "s/ORGANISATION_BASE_DN=.*/ORGANISATION_BASE_DN=$organisationbasedn/g" $DOCKER_ENV

organisationdomain=$(echo $@ | jq -r '.organisationdomain')
echo organisationdomain $organisationdomain "<br>"
sed -i "s/ORGANSATION_DOMAIN=.*/ORGANSATION_DOMAIN=$organisationdomain/g" $DOCKER_ENV

organisationname=$(echo $@ | jq -r '.organisationname')
echo organisationname $organisationname "<br>"
sed -i "s/ORGANISATION_NAME=.*/ORGANISATION_NAME=$organisationname/g" $DOCKER_ENV

echo "Values set. System will reboot.<HTML>"

sudo reboot