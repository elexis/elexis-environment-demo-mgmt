#!/bin/sh
cd /opt/ee-mgmt/bin/
./env-to-json.py /opt/ee/elexis-environment/.env > input.json
cat ./form.jade | jade -O input.json