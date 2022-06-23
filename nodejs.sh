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

while [ ! -z "$1" ]; do
    case "$1" in
        --file ) FILE="$2"; shift 2;;
        
        --repo )
            if [[ $2 != --* ]]; then
                REPO="$2"
                shift
            else
                REPO=""
            fi
            shift
            ;;
        
        --branch )
            if [[ $2 != --* ]]; then
                BRANCH="$2"
                shift
            else
                BRANCH=""
            fi
            shift
            ;;
        
        --manager ) MANAGER="$2"; shift 2;;
        --shell ) SHELL="$2"; shift 2;;
        --auto-install ) AUTO_INSTALL="$2"; shift 2;;
        --auto-pull ) AUTO_PULL="$2"; shift 2;;
        --logger ) LOGGER="$2"; shift 2;;
        -- ) shift; break;;
        * ) break;;
    esac
done

echo -e "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
echo -e "| > Starter File: '${UNDERLINE}${FILE}\e[24m'"
echo -e "| > Git Repository: '${UNDERLINE}${REPO}\e[24m'"
echo -e "| > Git Branch: '${UNDERLINE}${BRANCH}\e[24m'"
echo -e "| > Package Manager '${UNDERLINE}${MANAGER}\e[24m'"
echo -e "| > Bash Mode: '${UNDERLINE}${SHELL}\e[24m'"
echo -e "| > Auto Install: '${UNDERLINE}${AUTO_INSTALL}\e[24m'"
echo -e "| > Auto Pull: '${UNDERLINE}${AUTO_PULL}\e[24m'"
echo -e "| > Logs: '${UNDERLINE}${LOGGER}\e[24m'"
echo -e "${LIGHT_MAGENTA}************************************************************${DEFAULT}"

# wget -nv -O /tmp/start https://raw.githubusercontent.com/AcidicNodes/starter/main/start.sh
# bash /tmp/start "$REPO" "$BRANCH" $SHELL $AUTO_PULL

if [ "$MANAGER" == "ask" ]; then
    echo -e "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
    echo "-| > Please choose your favourite package manager: [Enter the ${UNDERLINE}integer\e[24m]"
    echo -e "| > 1) npm [default]"
    # echo "2) yarn"
    # echo "3) pnpm"
    echo -e "-| > ${BOLD}Hint: You could hide this prompt by setting up a default value on the 'Startup' page.${NORMAL}"
    echo -e "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
    read confirmation
    case $confirmation in
        """
        2 )
            MANAGER="yarn"
            echo "Using yarn"
            ;;
        3 )
            MANAGER="pnpm"
            echo "Using pnpm"
            ;;
        """
        * )
            MANAGER="npm"
            echo "*| > Using '${LIGHT_GREEN}NPM${NORMAL}'..."
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
        read confirmation
        case $confirmation in
            [Yy]* )
                echo "*| > Installing/Upgrading from package.json..."
                eval $MANAGER "install"
                ;;
            * ) echo "*| > Skipped!";;
        esac
    else
        eval $MANAGER "install"
    fi
fi

"""
toilet --filter border:gay AcidicNodes
echo

sleep 1

"""

echo -e "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
echo -e "-| > Starting Application/Bot..."
echo -e "${LIGHT_MAGENTA}************************************************************${DEFAULT}"

CMD="node $FILE"

if [ "$LOGGER" == "yes" ]; then
    CMD="$CMD | tee acidicnodes_debug_$(date +%d-%m-%Y_%H-%M-%S).log"
fi