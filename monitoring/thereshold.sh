#!/bin/bash
thereshold=80
USAGE=$(df / | grep / | awk '{ print $5 }' |  sed 's/%//g')
if  [ $USAGE -gt $thereshold ]; then
echo "CRITICAL: Disce usage is at ${USAGE}%!"
else echo  "disc status is healty: ${USAGE}%"
fi
