#!/bin/bash
echo "<HTML>"
# tr replaces only single character
RESULT=$(/opt/ee/elexis-environment/ee system cmd ps | tr '\n' ',' )
# now replace , with HTML BR
echo ${RESULT//,/<BR>}
echo "</HTML>"