#!/bin/bash
# Incoming  {"adminemail":"ask-user","hostname":"base.demo.myelexis.ch","organisationbasedn":"ask-user","organisationdomain":"ask-user","organisationname":"ask-user"}

DOCKER_ENV=/opt/ee/elexis-environment/.env

echo "<HTML>"
echo "Executing ...<BR>" | ts '[%Y-%m-%d %H:%M:%S]'
echo $(/opt/ee/elexis-environment/ee system cmd stop)

echo "Resetting $DOCKER_ENV <BR>"
rm $DOCKER_ENV
cp $DOCKER_ENV.template $DOCKER_ENV
adminpass=$(uuid)
echo "<B>ADMIN_PASSWORD is now [$adminpass]</B><BR>"
sed -i "s/ADMIN_PASSWORD=.*/ADMIN_PASSWORD=$adminpass/g" $DOCKER_ENV

IPADDR_ETH=$(ifdata -pa eth0)
echo "RDBMS_HOST is [$IPADDR_ETH]</B><BR>"
sed -i "s/RDBMS_HOST=.*/RDBMS_HOST=$IPADDR_ETH/g" $DOCKER_ENV
echo "ADMIN_USERNAME is [ee_admin]</B><BR>"
sed -i "s/ADMIN_USERNAME=.*/ADMIN_USERNAME=ee_admin/g" $DOCKER_ENV

#
# Adapt .env values
#
echo "Setting .env values<BR>"

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

#
# Perform full reset
#
echo "Remove all containers<BR>"
echo $(/opt/ee/elexis-environment/ee system cmd rm -f) "<BR>"
echo "Prune volumes and images<BR>"
echo $(docker volume prune -f) "<BR>"
echo $(docker image prune -f) "<BR>"

echo "Delete .env.bkup.* backup files<BR>"
rm -f /opt/ee/elexis-environment/.env.bkup
rm -f /opt/ee/elexis-environment/.env.bkup.*

echo "Delete /opt/ee/elexis-environment/site/bootstrap.ldif<BR>"
rm -f /opt/ee/elexis-environment/site/bootstrap.ldif
rm -f /opt/ee/elexis-environment/site/dhparam.pem

# TODO clear database
echo "Dropping SQL databases and users<BR>"
echo $(/usr/bin/mysql --defaults-extra-file=/opt/elexis-environment-demo-mgmt/mysql-secrets.cnf -u ee -H < /opt/elexis-environment-demo-mgmt/sql/drop-databases-and-users.sql)
echo "Creating SQL databases and users<BR>"
echo $(/usr/bin/mysql --defaults-extra-file=/opt/elexis-environment-demo-mgmt/mysql-secrets.cnf -u ee -H < /opt/elexis-environment-demo-mgmt/sql/create-databases-and-users.sql)

#
# reboot system
#
echo "<B> Rebooting system ...</B><BR>" | ts '[%Y-%m-%d %H:%M:%S]'
echo "After startup you should execute <I>Configure EE</I> in the <A HREF="/hooks/form">main form</A><BR>"
echo "You can also check status and uptime there in <I>EE status</I><BR>"
echo "<HTML>"
nohup ./reboot.sh >/dev/null 2>&1 & disown