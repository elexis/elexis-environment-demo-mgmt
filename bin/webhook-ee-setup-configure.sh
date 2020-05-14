#!/bin/bash
echo "<HTML>"
echo "Executing ....<br>" | ts '[%Y-%m-%d %H:%M:%S]'
# tr replaces only single character
RESULT=$(/opt/ee/elexis-environment/ee setup configure | tr '\n' ',' )
# now replace , with HTML BR
echo ${RESULT//,/<BR>}
echo "DONE<br>" | ts '[%Y-%m-%d %H:%M:%S]'
echo "</HTML>"