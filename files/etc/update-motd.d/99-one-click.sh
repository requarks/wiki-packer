#!/bin/sh
#
# Configured as part of the DigitalOcean 1-Click Image build process

myip=$(hostname -I | awk '{print$1}')
cat <<EOF
********************************************************************************
Wiki.js 2.x for DigitalOcean

https://wiki.js.org

Documentation: https://docs.requarks.io
Report Bugs: https://github.com/requarks/wiki/issues
Twitter: @requarks
********************************************************************************
To delete this message of the day: rm -rf $(readlink -f ${0})
EOF
