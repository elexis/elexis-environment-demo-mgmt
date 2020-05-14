#!/bin/bash
echo "<HTML>"
echo "Executing ....<br>" | ts '[%Y-%m-%d %H:%M:%S]'
echo "<B>Uptime</B>"  $(uptime) "<BR><BR>" 
# tr replaces only single character
RESULT=$(/opt/ee/elexis-environment/ee system cmd ps | tr '\n' ',' )
# now replace , with HTML BR
echo ${RESULT//,/<BR>}
echo "</HTML>"