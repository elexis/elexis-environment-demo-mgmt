#!/bin/bash
# Incoming  {"adminemail":"ask-user","hostname":"base.demo.myelexis.ch","organisationbasedn":"ask-user","organisationdomain":"ask-user","organisationname":"ask-user"}

for val in $@;
do
    KEY=$(echo $val | cut -d ':' -f1 -)
    VALUE=$(echo $val | cut -d ':' -f2 -)
    
    if [ $KEY = "adminemail" ]; then
        sed -i "s/ADMIN_EMAIL=.*/ADMIN_EMAIL=$VALUE/g" /opt/ee/elexis-environment/.env
    fi

    if [ $KEY = "hostname" ]; then
        sed -i "s/EE_HOSTNAME=.*/EE_HOSTNAME=$VALUE/g" /opt/ee/elexis-environment/.env
    fi

    if [ $KEY = "organisationbasedn" ]; then
        sed -i "s/ORGANISATION_BASE_DN=.*/ORGANISATION_BASE_DN=$VALUE/g" /opt/ee/elexis-environment/.env
    fi

    if [ $KEY = "organisationdomain" ]; then
        sed -i "s/ORGANSATION_DOMAIN=.*/ORGANSATION_DOMAIN=$VALUE/g" /opt/ee/elexis-environment/.env
    fi

    if [ $KEY = "organisationname" ]; then
        sed -i "s/ORGANISATION_NAME=.*/ORGANISATION_NAME=$VALUE/g" /opt/ee/elexis-environment/.env
    fi

done