#!/bin/sh

# /////////////////////////////////////////////////////////////////////////// #
#                                                                             #
#                      Copyright 2024 FlarexCloud                             #
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

# ////////////////| [🥽] | FlarexCloud | [⚗️] |//////////////// #

# || Start [📍] || #

# const { exec } = require('child_process');

INSTALLER_VERSION=0.0.2
OS_VERSION=$(cat /etc/alpine-release)
GIT_VERSION=$(git --version)
NODE_VERSION=$(node -v)
PYTHON_VERSION=$(python3 --version)
NPM_VERSION=$(npm -v)
YARN_VERSION=$(yarn -v)

NORMAL="\e[0m"
BOLD="\e[1m"
UNDERLINE="\e[4m"

YELLOW="\e[33m"
LIGHT_YELLOW="\e[93m"
LIGHT_MAGENTA="\e[95m"
LIGHT_GREEN="\e[92m"
LIGHT_RED="\e[91m"
DEFAULT="\e[39m"

FILE=$1
APPLICATION=$2
MANAGER=$6
TERMINAL=$7
AUTO_INSTALL=$8
AUTO_PULL=$9
LOGGER=${10}
if [ "$2" != "none" ]; then
    GIT_REPOSITORY=""
    GIT_BRANCH=""
    GIT_TOKEN=""; shift
elif [ "$2" == "none" ]; then
    GIT_REPOSITORY="$3"
    GIT_BRANCH="$4"
    GIT_TOKEN="$5"; shift
fi

echo "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
echo "| > Application: '${UNDERLINE}${APPLICATION}\e[24m'"
echo "| > Starter File: '${UNDERLINE}${FILE}\e[24m'"
echo "| > Package Manager: '${UNDERLINE}${MANAGER}\e[24m'"
echo "| > Terminal Mode: '${UNDERLINE}${TERMINAL}\e[24m'"
echo "| > Git Repository: '${UNDERLINE}${GIT_REPOSITORY}\e[24m'"
echo "| > Git Branch: '${UNDERLINE}${GIT_BRANCH}\e[24m'"
echo "| > Git Token: '${UNDERLINE}${GIT_TOKEN}\e[24m'"
echo "| > Auto Install: '${UNDERLINE}${AUTO_INSTALL}\e[24m'"
echo "| > Auto Pull: '${UNDERLINE}${AUTO_PULL}\e[24m'"
echo "| > Logs: '${UNDERLINE}${LOGGER}\e[24m'"
echo "${LIGHT_MAGENTA}************************************************************${DEFAULT}"

sleep 0.5
echo

echo "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
echo "| > Time Zone: '${UNDERLINE}${TZ}\e[24m'"
echo "| > Cluster: '${UNDERLINE}${P_SERVER_LOCATION}\e[24m'"
echo "| > RAM: '${UNDERLINE}${SERVER_MEMORY}MB\e[24m'"
echo "| > IPv4: '${UNDERLINE}${SERVER_IP}\e[24m'"
echo "| > Primary Port: '${UNDERLINE}${SERVER_PORT}\e[24m'"
echo "| > UUID: '${UNDERLINE}${P_SERVER_UUID}\e[24m'"
echo "${LIGHT_MAGENTA}************************************************************${DEFAULT}"

sleep 0.5
echo

echo "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
echo "| > Installer Version: '${UNDERLINE}${INSTALLER_VERSION}\e[24m'"
echo "| > Alpine Version: '${UNDERLINE}${OS_VERSION}\e[24m'"
# echo "| > Bash Version: '${UNDERLINE}${BASH_VERSION}\e[24m'" # As we´re using Alpine
echo "| > Git Version: '${UNDERLINE}${GIT_VERSION}\e[24m'"
echo "| > NodeJs Version: '${UNDERLINE}${NODE_VERSION}\e[24m'"
echo "| > Python Version: '${UNDERLINE}${PYTHON_VERSION}\e[24m'"
if [ "$NODE_VERSION" == "v16.16.0" ]; then
    echo "| > NPM VERSION: '${LIGHT_GREEN}${UNDERLINE}${NPM_VERSION}\e[24m'"
    echo "| > YARN VERSION: '${LIGHT_GREEN}${UNDERLINE}${YARN_VERSION}\e[24m'"
    echo "| > JDK: '${LIGHT_GREEN}${UNDERLINE}Available\e[24m'"
else
    echo "| > NPM VERSION: '${LIGHT_GREEN}${UNDERLINE}${NPM_VERSION}\e[24m'"
    echo "| > YARN VERSION: '${LIGHT_GREEN}${UNDERLINE}${YARN_VERSION}\e[24m'"
    echo "| > JDK: '${LIGHT_RED}${UNDERLINE}Not available\e[24m'"
fi
echo "${LIGHT_MAGENTA}************************************************************${DEFAULT}"

wget -nv -O /tmp/start https://raw.githubusercontent.com/FlarexCloud/starter/main/starter.sh &> /dev/null

sleep 1.5
echo

if [ "$APPLICATION" == "none" ]; then
    echo "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
    echo "-| > You have picked ${UNDERLINE}no application\e[24m!"
    echo "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
    echo
    echo "${LIGHT_GREEN}************************************************************${DEFAULT}"
    echo
elif [ "$APPLICATION" == "-(  WhatsApp Bots  )-" ] || [ "$APPLICATION" == "-(  Discord Bots  )-" ] || [ "$APPLICATION" == "-(  Telegram Bots  )-" ] || [ "$APPLICATION" == "-(  Twitch Bots  )-" ] || [ "$APPLICATION" == "-(  General Applications  )-" ]; then
    echo "${LIGHT_RED}************************************************************${DEFAULT}"
    echo
    echo "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
    echo "-| > ${BOLD}WARNING! '${UNDERLINE}${APPLICATION}\e[24m' is not an application, please pick another one!\e[21m${NORMAL}"
    echo "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
    echo
    echo "${LIGHT_RED}************************************************************${DEFAULT}"
    echo
        exit 0
elif [ "$APPLICATION" != "-(  WhatsApp Bots  )-" ] || [ "$APPLICATION" != "-(  Discord Bots  )-" ] || [ "$APPLICATION" != "-(  Telegram Bots  )-" ] || [ "$APPLICATION" != "-(  Twitch Bots  )-" ] || [ "$APPLICATION" != "-(  General Applications  )-" ]; then
    echo "${LIGHT_RED}************************************************************${DEFAULT}"
    echo
    echo "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
    echo "-| > ${BOLD}WARNING! Remember to reinstall your server in order for '${UNDERLINE}${APPLICATION}\e[24m' to work.\e[21m${NORMAL}"
    echo "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
    echo
    echo "${LIGHT_RED}************************************************************${DEFAULT}"
    echo
fi

sh /tmp/start "$GIT_REPOSITORY" "$GIT_BRANCH" "$GIT_TOKEN" $TERMINAL $AUTO_PULL

if [ "$NODE_VERSION" != "v8.17.0" ] || [ "$NODE_VERSION" != "v10.24.1" ] || [ "$NODE_VERSION" != "v11.15.0" ]; then
    npm i yarn@latest
    # if [ "$APPLICATION" == "none" ]; then
        # yarn add @adiwajshing/baileys
    # fi
fi

if [ "$MANAGER" == "ask" ]; then
    echo "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
    echo "-| > Please choose your favourite package manager: [Enter the integer]"
    echo "-|"
    if [ "$NODE_VERSION" == "v8.17.0" ] || [ "$NODE_VERSION" == "v10.24.1" ] || [ "$NODE_VERSION" == "v11.15.0" ]; then
        echo ">> | > *) No package manager can be selected."
    else
        echo ">> | > 1) npm ($NPM_VERSION) [default]"
        echo ">> | > 2) yarn ($YARN_VERSION)"
    fi
    echo "-|"
    echo "-| > ${BOLD}Hint: You could hide this prompt by setting up a default value on the 'Startup' page.${NORMAL}"
    echo "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
        read confirmation
        case $confirmation in
            2 )
                MANAGER="yarn"
                echo
                echo "${LIGHT_GREEN}************************************************************${DEFAULT}"
                echo
                echo "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
                echo "*| > Using $MANAGER..."
                echo "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
                echo
                echo "${LIGHT_GREEN}************************************************************${DEFAULT}"
                echo
                sleep 1.5
                ;;
            * )
                MANAGER="npm"
                echo
                echo "${LIGHT_GREEN}************************************************************${DEFAULT}"
                echo
                echo "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
                echo "*| > Using $MANAGER..."
                echo "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
                echo
                echo "${LIGHT_GREEN}************************************************************${DEFAULT}"
                echo
                sleep 1.5
                ;;
        esac
fi

if [ -f package.json ] && [ "$AUTO_INSTALL" != "no" ]; then
    if [ "$AUTO_INSTALL" == "ask" ]; then
        echo "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
        echo "-| > A package.json have been detected."
        echo "-| > Continue to Install/Upgrade from package.json? [Enter ${UNDERLINE}yes\e[24m or ${UNDERLINE}no\e[24m]"
        echo "-| > ${BOLD}Hint: You could hide this prompt by setting up a default value on the 'Startup' page.${NORMAL}"
        echo "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
        echo
        echo "${LIGHT_GREEN}************************************************************${DEFAULT}"
        read confirmation
        case $confirmation in
            [Yy]* )
                echo
                echo "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
                echo "*| > Installing/Upgrading from package.json..."
                echo "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
                echo
                echo "${LIGHT_GREEN}************************************************************${DEFAULT}"
                echo
                eval $MANAGER "install";;
            * ) 
                echo
                echo "${LIGHT_GREEN}************************************************************${DEFAULT}"
                echo
                echo "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
                echo "*| > Skipped!"
                echo "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
                echo
                echo "${LIGHT_GREEN}************************************************************${DEFAULT}"
                echo;;
        esac
    else
        eval $MANAGER "install"
    fi
fi

if [ "$APPLICATION" != "none" ]; then
    echo
    echo "${LIGHT_YELLOW}************************************************************${DEFAULT}"
    echo
    echo "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
    echo "-| > Remember to take a look at our Discord Server and at our Knowledgebase if you need help setting up ${APPLICATION}!"
    echo "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
    echo
    echo "${LIGHT_YELLOW}************************************************************${DEFAULT}"
    echo
fi

echo "${LIGHT_GREEN}************************************************************${DEFAULT}"
echo
echo "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
echo "-| > Starting Application/Bot..."
echo "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
echo
echo "${LIGHT_GREEN}************************************************************${DEFAULT}"
echo

if [ "$APPLICATION" == "none" ]; then
    CMD="node $FILE"
: <<'END_COMMENT'
elif [ "$APPLICATION" == "Jareer12/DiscordBotPanel" ] && [ "$SERVER_MEMORY" -lt "2048" ]; then
    echo "${LIGHT_RED}************************************************************${DEFAULT}"
    echo
    echo "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
    echo "-| > ${BOLD}WARNING! '${UNDERLINE}${APPLICATION}\e[24m' must have a minimum of '${UNDERLINE}2048MB\e[24m' of RAM in order for it to run!\e[21m${NORMAL}"
    echo "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
    echo
    echo "${LIGHT_RED}************************************************************${DEFAULT}"
    echo
        exit 0
elif [ "$APPLICATION" != "none" ]; then
    if [ "$APPLICATION" == "[ES]BrunoSobrino/TheMystic-Bot-MD" ]; then
        CMD="node . --server"
    else
        CMD="node ."
    fi
END_COMMENT
fi

if [ "$LOGGER" == "yes" ]; then
    eval "$CMD | tee flarexcloud_debug_$(date +%d-%m-%Y_%H-%M-%S).log"
else
    eval "$CMD"
fi