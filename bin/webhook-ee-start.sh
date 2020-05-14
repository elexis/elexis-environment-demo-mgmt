#!/bin/bash
echo "<HTML>"
echo "Executing ....<br>" | ts '[%Y-%m-%d %H:%M:%S]'
# tr replaces only single character
RESULT=$(/opt/ee/elexis-environment/ee system cmd up -d --build | tr '\n' ',' )
# now replace , with HTML BR
echo ${RESULT//,/<BR>}
echo "</HTML>"