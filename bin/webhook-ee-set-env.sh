#!/bin/bash
# Incoming  {"adminemail":"ask-user","hostname":"base.demo.myelexis.ch","organisationbasedn":"ask-user","organisationdomain":"ask-user","organisationname":"ask-user"}

DOCKER_ENV=/opt/ee/elexis-environment/.env

adminemail=$(echo $@ | jq -r '.adminemail')
sed -i "s/ADMIN_EMAIL=.*/ADMIN_EMAIL=$adminemail/g" $DOCKER_ENV

hostname=$(echo $@ | jq -r '.hostname')
sed -i "s/EE_HOSTNAME=.*/EE_HOSTNAME=$hostname/g" $DOCKER_ENV

organisationbasedn=$(echo $@ | jq -r '.organisationbasedn')
sed -i "s/ORGANISATION_BASE_DN=.*/ORGANISATION_BASE_DN=$organisationbasedn/g" $DOCKER_ENV

organisationdomain=$(echo $@ | jq -r '.organisationdomain')
sed -i "s/ORGANSATION_DOMAIN=.*/ORGANSATION_DOMAIN=$organisationdomain/g" $DOCKER_ENV

organisationname=$(echo $@ | jq -r '.organisationname')
sed -i "s/ORGANISATION_NAME=.*/ORGANISATION_NAME=$organisationname/g" $DOCKER_ENV

echo "<HTML>Values set. Please reload form.<HTML>"