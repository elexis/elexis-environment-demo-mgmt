#!/bin/bash
echo "<HTML>"
echo "Executing ....<br>"
# tr replaces only single character
RESULT=$(/opt/ee/elexis-environment/ee setup configure | tr '\n' ',' )
# now replace , with HTML BR
echo ${RESULT//,/<BR>}
echo "</HTML>"