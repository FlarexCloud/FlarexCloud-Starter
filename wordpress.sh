#!/bin/bash

# /////////////////////////////////////////////////////////////////////////// #
#                                                                             #
#                      Copyright 2022 AcidicNodes                             #
#                                                                             #
#   Licensed under the Apache License, Version 2.0 (the "License");           #
#   you may not use this file except in compliance with the License.          #
#   You may obtain a copy of the License at                                   #
#                                                                             #
#       http://www.apache.org/licenses/LICENSE-2.0                            #
#                                                                             #
#   Unless required by applicable law or agreed to in writing, software       #
#   distributed under the License is distributed on an "AS IS" BASIS,         #
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  #
#   See the License for the specific language governing permissions and       #
#   limitations under the License.                                            #
#                                                                             #
# /////////////////////////////////////////////////////////////////////////// #

# ////////////////| [🥽] | AcidicNodes | [⚗️] |//////////////// #

# || Start [📍] || #

INSTALLER_VERSION=1.0.5

NORMAL="\e[0m"
BOLD="\e[1m"
UNDERLINE="\e[4m"

YELLOW="\e[33m"
LIGHT_YELLOW="\e[93m"
LIGHT_MAGENTA="\e[95m"
LIGHT_GREEN="\e[92m"
LIGHT_RED="\e[91m"
DEFAULT="\e[39m"

WORDPRESS_INSTALL_VERSION=$1

echo -e "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
echo -e "| > Installer Version: '${UNDERLINE}${INSTALLER_VERSION}\e[24m'"
echo -e "| > PHP Version: '${UNDERLINE}${phpversion();}\e[24m'"
echo -e "| > WordPress Version: '${UNDERLINE}${WORDPRESS_INSTALL_VERSION}\e[24m'"
echo -e "${LIGHT_MAGENTA}************************************************************${DEFAULT}"

sleep 0.5
echo

echo -e "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
echo -e "| > Time Zone: '${UNDERLINE}${TZ}\e[24m'"
echo -e "| > Cluster: '${UNDERLINE}${P_SERVER_LOCATION}\e[24m'"
echo -e "| > RAM: '${UNDERLINE}${SERVER_MEMORY}MB\e[24m'"
echo -e "| > Local IPv4: '${UNDERLINE}${SERVER_IP}\e[24m'"
echo -e "| > Primary Port: '${UNDERLINE}${SERVER_PORT}\e[24m'"
echo -e "| > UUID: '${UNDERLINE}${P_SERVER_UUID}\e[24m'"
echo -e "${LIGHT_MAGENTA}************************************************************${DEFAULT}"

sleep 1.5
echo

echo
echo -e "${LIGHT_GREEN}************************************************************${DEFAULT}"
echo
echo -e "-| > Thanks for using AcidicNodes, starting WordPress ($WORDPRESS_VERSION)..."
echo
echo -e "${LIGHT_GREEN}************************************************************${DEFAULT}"
echo

sleep 1.5

#if [ "$PHP_VERSION" != "" ]; then
#/usr/sbin/php-fpm8 --fpm-config /home/container/php-fpm/php-fpm.conf --daemonize
#/usr/sbin/nginx -c /home/container/nginx/nginx.conf
#else
#/usr/sbin/php-fpm7 --fpm-config /home/container/php-fpm/php-fpm.conf --daemonize
#/usr/sbin/nginx -c /home/container/nginx/nginx.conf
#fi