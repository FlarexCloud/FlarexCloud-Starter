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
        --npm-script )
            if [[ $2 != --* ]]; then
                NPM_SCRIPT="$2"
                shift
            else
                NPM_SCRIPT=""
            fi
            shift
            ;;
        
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
echo -e "| > NPM Script '${UNDERLINE}${NPM_SCRIPT}\e[24m'"
echo -e "| > Git Repository: '${UNDERLINE}${REPO}\e[24m'"
echo -e "| > Git Branch: '${UNDERLINE}${BRANCH}\e[24m'"
echo -e "| > Package Manager '${UNDERLINE}${MANAGER}\e[24m'"
echo -e "| > Bash Mode: '${UNDERLINE}${SHELL}\e[24m'"
echo -e "| > Auto Install: '${UNDERLINE}${AUTO_INSTALL}\e[24m'"
echo -e "| > Auto Pull: '${UNDERLINE}${AUTO_PULL}\e[24m'"
echo -e "| > Logs: '${UNDERLINE}${LOGGER}\e[24m'"
echo -e "${LIGHT_MAGENTA}************************************************************${DEFAULT}"

wget -nv -O /tmp/start https://github.com/acidicnodes/starter/raw/master/start.sh
bash /tmp/start "$REPO" "$BRANCH" $SHELL $AUTO_PULL

if [ "$MANAGER" == "ask" ]; then
    echo "** Please choose a node package manager: [Enter the integer] **"
    echo "Hint: You can now hide this prompt by setting the default value on the 'Startup' page."
    echo "1) npm [default]"
    echo "2) yarn"
    echo "3) pnpm"
    read confirmation
    case $confirmation in
        2 )
            MANAGER="yarn"
            echo "Using yarn"
            ;;
        3 )
            MANAGER="pnpm"
            echo "Using pnpm"
            ;;
        * )
            MANAGER="npm"
            echo "Using npm"
            ;;
    esac
fi

if [ -f package.json ] && [ "$AUTO_INSTALL" != "no" ]; then
    if [ "$AUTO_INSTALL" == "ask" ]; then
        echo "** package.json detected. Continue to install/upgrade from package.json? [Enter yes or no] **"
        echo "Hint: You can now hide this prompt by setting the default value on the 'Startup' page."
        read confirmation
        case $confirmation in
            [Yy]* )
                echo "Installing/upgrading packages..."
                eval $MANAGER "install"
                ;;
            * ) echo "Skipped!";;
        esac
    else
        eval $MANAGER "install"
    fi
fi

echo "Starting app..."

CMD="node $FILE"

if [ ! -z "$NPM_SCRIPT" ]; then
    CMD="npm run $NPM_SCRIPT"
fi

if [ "$LOGGER" == "yes" ]; then
    CMD="$CMD | tee alaister_debug_$(date +%d-%m-%Y_%H-%M-%S).log"
fi

eval env NODE_EXTRA_CA_CERTS=/tmp/alaister.ca.pem $CMD 