#!/bin/sh
# Shell script to monitor or watch the disk space on SEVAS servers
# It will send an email to $ADMIN, if the (free avilable) percentage 
# of space is >= 80% 
# -------------------------------------------------------------------------
# Email alert sent to VAS team when treashold reached over 90%
# -------------------------------------------------------------------------
# 
# Linux shell script to watch disk space (should work on other UNIX oses )
# 
# set admin email so that the VAS team can get the alert email

ADMIN="adedeji.soyemi@ee.co.uk sumit.bhatnagar@ee.co.uk samir.shrivastava@ee.co.uk varun.gupta@ee.co.uk arul.kumaran@bt.com  kamal.hersh@ee.co.uk"

# set alert treshold value

ALERT=80

GROUP="vdsldaprhwp11 vdsldaprhwp12 vdsomcrhwp11 vdsomcrhwp12 vdsppsrhwp11 vdssdbrhwp11 vdssdbrhwp12 vdssvasdbrhwp11 vdssvasdbrhwp12 vdssvasdbrhwp13 vdssvasdbrhwp14 vdssvasifrhwp11 vdssvasifrhwp12"
for host in $GROUP; do
ssh asoyemi@$host df -PH | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $1 }' | while read output;
	do
             #echo $output
             usep=$(echo $output | awk '{ print $1}' | cut -d'%' -f1  )
             partition=$(echo $output | awk '{ print $2 }' )
             if [ $usep -ge $ALERT ]; then
             echo "Running out of space \"$partition ($usep%)\" on $host as on $(date)" | 
              mail -s "ESNAlert: \"$partition almost out of disk space on $host $usep%" $ADMIN
         fi
         done
done

