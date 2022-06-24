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

NORMAL="\e[0m"
BOLD="\e[1m"
UNDERLINE="\e[4m"

YELLOW="\e[33m"
LIGHT_MAGENTA="\e[95m"
LIGHT_GREEN="\e[92m"
DEFAULT="\e[39m"

FILE=$1
APPLICATION=$2
REPO=$3
BRANCH=$4
MANAGER=$5
TERMINAL=$6
AUTO_INSTALL=$7
AUTO_PULL=$8
LOGGER=$9

echo -e "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
echo -e "| > Application: '${UNDERLINE}${APPLICATION}\e[24m'"
echo -e "| > Starter File: '${UNDERLINE}${FILE}\e[24m'"
echo -e "| > Git Repository: '${UNDERLINE}${REPO}\e[24m'"
echo -e "| > Git Branch: '${UNDERLINE}${BRANCH}\e[24m'"
echo -e "| > Package Manager '${UNDERLINE}${MANAGER}\e[24m'"
echo -e "| > Terminal Mode: '${UNDERLINE}${TERMINAL}\e[24m'"
echo -e "| > Auto Install: '${UNDERLINE}${AUTO_INSTALL}\e[24m'"
echo -e "| > Auto Pull: '${UNDERLINE}${AUTO_PULL}\e[24m'"
echo -e "| > Logs: '${UNDERLINE}${LOGGER}\e[24m'"
echo -e "${LIGHT_MAGENTA}************************************************************${DEFAULT}"


echo
echo -e "${LIGHT_GREEN}************************************************************${DEFAULT}"
wget -nv -O /tmp/start https://raw.githubusercontent.com/AcidicNodes/starter/main/starter.sh
echo -e "${LIGHT_GREEN}************************************************************${DEFAULT}"
echo

if [ "$APPLICATION" == "none" ]; then
echo -e "a"
else if [ "$APPLICATION" == "Discord Bots" ]; then
    echo -e "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
    echo -e "| > ${BOLD}WARNING! ${APPLICATION} is not an application, please select another one!\e[21m${NORMAL}"
    echo -e "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
else
echo -e "a"
fi

bash /tmp/start "$REPO" "$BRANCH" $TERMINAL $AUTO_PULL

if [ "$MANAGER" == "ask" ]; then
    echo -e "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
    echo "-| > Please choose your favourite package manager: [Enter the integer]"
    echo "-|"
    echo -e ">> | > 1) npm [default]"
    # echo "2) yarn"
    # echo "3) pnpm"
    echo "-|"
    echo -e "-| > ${BOLD}Hint: You could hide this prompt by setting up a default value on the 'Startup' page.${NORMAL}"
    echo -e "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
    read confirmation
    case $confirmation in
        # 2 )
        #     MANAGER="yarn"
        #     echo "Using yarn"
        #     ;;
        # 3 )
        #     MANAGER="pnpm"
        #     echo "Using pnpm"
        #     ;;
        * )
            MANAGER="npm"
            echo
            echo -e "${LIGHT_GREEN}************************************************************${DEFAULT}"
            echo
            echo -e "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
            echo "*| > Using NPM..."
            echo -e "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
            echo
            echo -e "${LIGHT_GREEN}************************************************************${DEFAULT}"
            echo
            sleep 1.5
            ;;
    esac
fi

if [ -f package.json ] && [ "$AUTO_INSTALL" != "no" ]; then
    if [ "$AUTO_INSTALL" == "ask" ]; then
        echo -e "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
        echo -e "-| > A package.json have been detected."
        echo -e "-| > Continue to Install/Upgrade from package.json? [Enter ${UNDERLINE}yes\e[24m or ${UNDERLINE}no\e[24m]"
        echo -e "-| > ${BOLD}Hint: You could hide this prompt by setting up a default value on the 'Startup' page.${NORMAL}"
        echo -e "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
        echo
        echo -e "${LIGHT_GREEN}************************************************************${DEFAULT}"
        read confirmation
        case $confirmation in
            [Yy]* )
                echo
                echo -e "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
                echo "*| > Installing/Upgrading from package.json..."
                echo -e "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
                echo
                echo -e "${LIGHT_GREEN}************************************************************${DEFAULT}"
                echo
                eval $MANAGER "install";;
            * ) 
                echo
                echo -e "${LIGHT_GREEN}************************************************************${DEFAULT}"
                echo
                echo -e "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
                echo "*| > Skipped!"
                echo -e "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
                echo
                echo -e "${LIGHT_GREEN}************************************************************${DEFAULT}"
                echo;;
        esac
    else
        eval $MANAGER "install"
    fi
fi

echo -e "${LIGHT_GREEN}************************************************************${DEFAULT}"
echo
echo -e "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
echo -e "-| > Starting Application/Bot..."
echo -e "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
echo
echo -e "${LIGHT_GREEN}************************************************************${DEFAULT}"
echo

CMD="node $FILE"

if [ "$LOGGER" == "yes" ]; then
    CMD="$CMD | tee acidicnodes_debug_$(date +%d-%m-%Y_%H-%M-%S).log"
fi

eval "$CMD"