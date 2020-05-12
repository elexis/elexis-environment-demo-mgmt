#!/bin/sh
./env-to-json.py /opt/ee/elexis-environment/.env > /tmp/input.json
cat ./form.jade | jade -O /tmp/input.json
rm /tmp/input.json