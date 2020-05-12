#!/bin/sh
/opt/ee/elexis-environment/ee system cmd stop
/opt/ee/elexis-environment/ee system cmd rm -f
docker volume prune -f
docker image prune -f
# TODO clear database