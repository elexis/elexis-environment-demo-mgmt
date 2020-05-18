Setup of base.elexisdemo.ch

Debian 10 image

* apt full-upgrade
* apt install webhook uuid git npm unzip ufw jq moreutils
* apt install mysql 8 server
* uuid > mysql.rootpw.txt; cat mysql.rootpw.txt
* mysql_secure_installation # use former uuid as root pw
* vi  mariadb.conf.d/50-server.cnf -> comment bind-address
* Install https://docs.docker.com/engine/install/debian/
* curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
* chmod +x /usr/local/bin/docker-compose
* useradd -d /opt/ee -m -s /bin/bash ee -G docker,adm
* chgrp adm /etc/hostname /etc/hosts
* chmod g+w /etc/hostname /etc/hosts
* cd /opt; git clone https://github.com/elexis/elexis-environment-demo-mgmt.git
* ln -sf /opt/elexis-environment-demo-mgmt/etc/webhook.json /etc/webhook.conf
* npm install -g log.io
* npm install -g jade
* vi /usr/lib/systemd/system/webhook.service
* systemctl daemon-reload
* systemctl enable webhook
* su - ee
  * git clone https://github.com/elexis/elexis-environment.git
  * cd elexis-environment; cp .env.template .env
  * .env: ADMIN_PASSWORD -> uuid
* Fix wildcard certificate, put it into /opt/ee/elexis-environment/site/certificate.crt
* Configure ufw, see https://hostadvice.com/how-to/how-to-configure-firewall-with-ufw-on-ubuntu-18/ and systemctl enable ufw
  * ufw allow from 77.119.228.135/32 to any port 9000
  * ufw allow from 46.14.179.54/32 to any port 9000
  * ufw allow from 172.0.0.1/8 to any port 3306
* visudo -> add reboot right for adm users
* vi ~ee/mysql-secrets.cnf to add mysql password
* mysql root -> use mysql 8.0.20
  * CREATE USER 'ee'@'localhost' IDENTIFIED BY 'mypass';
  * GRANT ALL PRIVILEGES ON *.* TO 'ee'@'localhost';
  * GRANT GRANT OPTION ON *.* TO 'ee'@'localhost';
* npm install -g log.io --user="ee"
* npm install -g log.io-file-input --user="ee"
* cd ~ee; ln -sf /opt/elexis-environment-demo-mgmt/.log.io .
* vi /usr/lib/systemd/system/logio.service (see https://askubuntu.com/questions/819664/daemonize-log-io-in-16-04)
* vi /usr/lib/systemd/system/logio-file.service
  * ufw allow from 77.119.228.135/32 to any port 6688
  * ufw allow from 46.14.179.54/32 to any port 6688
* Install https://docs.fluentd.org/installation/install-by-deb to catch docker logs and forward to log.io