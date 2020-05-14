# Adapted for MariaDB
# https://mariadb.com/kb/en/authentication-plugin-mysql_native_password/
SET old_passwords=0;

CREATE DATABASE ee_elexis;
CREATE USER elexis@'%' IDENTIFIED BY 'elexis';
GRANT ALL PRIVILEGES ON ee_elexis.* TO 'elexis'@'%';

CREATE DATABASE ee_bookstack;
CREATE USER ee_bookstack@'%' BY 'ee_bookstack';
GRANT ALL PRIVILEGES ON ee_bookstack.* TO ee_bookstack@'%';

CREATE DATABASE ee_keycloak CHARACTER SET utf8 COLLATE utf8_unicode_ci;
CREATE USER ee_keycloak@'%' IDENTIFIED BY 'ee_keycloak';
GRANT ALL PRIVILEGES ON ee_keycloak.* TO ee_keycloak@'%';

CREATE DATABASE ee_nextcloud CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
CREATE USER ee_nextcloud@'%' IDENTIFIED WITH mysql_native_password BY 'ee_nextcloud';
GRANT ALL PRIVILEGES ON ee_nextcloud.* TO ee_nextcloud@'%';

FLUSH PRIVILEGES;
