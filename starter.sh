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

GIT_REPOSITORY=$1
GIT_TOKEN=$3
TERMINAL=$4
AUTO_PULL=$5
if [ "$2" != "" ]; then
    GIT_BRANCH=$2; shift
elif [ "$2" == "" ]; then
    GIT_BRANCH=""; shift
fi

NORMAL="\e[0m"
BOLD="\e[1m"
UNDERLINE="\e[4m"

YELLOW="\e[33m"
LIGHT_YELLOW="\e[93m"
LIGHT_MAGENTA="\e[95m"
LIGHT_GREEN="\e[92m"
LIGHT_RED="\e[91m"
DEFAULT="\e[39m"

# || Terminal Mode

terminal_mode() {
    echo "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
    echo "| > The terminal mode have been enabled. To exit, please just type in '${UNDERLINE}exit\e[24m'."
    echo "| > ${BOLD}WARNING! Terminal text editors, and long running processes won't work here.\e[21m${NORMAL}"
    echo "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
    echo "\033[1m${YELLOW}container@flarexcloud:$\033[0m"
    # read -t 900 userinput || exit 1
    while true; do
        read -p "container@flarexcloud:$ " CMD
        if [ "$CMD" == "exit" ]; then
            echo "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
            echo "| > Thanks for using FlarexCloud, and it's Terminal Mode."
            echo "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
            echo "${LIGHT_GREEN}************************************************************${DEFAULT}"
            echo
            break
        else
            eval "$CMD"
            sleep 0.2
            echo "container@flarexcloud:$ "
            # read -t 900 userinput || exit 1
        fi
    done
}

if [ "$TERMINAL" == "ask" ]; then
    echo "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
    echo "-| > Would you like no enable the access to terminal mode? [Enter ${UNDERLINE}yes\e[24m or ${UNDERLINE}no\e[24m]"
    echo "-| > ${BOLD}Hint: You could hide this prompt by setting up a default value on the 'Startup' page.${NORMAL}"
    echo "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
    read confirmation
    case $confirmation in
        [Yy]* ) terminal_mode;;
        * ) ;;
esac
elif [ "$TERMINAL" == "yes" ]; then
    terminal_mode
fi

echo "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
echo "-| > ${BOLD}Terminal mode have been disabled!${NORMAL}"
echo "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
echo;

cd /home/container

# || GitHub

if [[ $GIT_REPOSITORY != *.git ]]; then
    GIT_REPOSITORY=${GIT_REPOSITORY}.git
fi

if [ -d .git ]; then
    if [ -f .git/config ]; then
        ORIGIN=$(git config --get remote.origin.url)
        if [ ! -z "$ORIGIN" ] && [ "$AUTO_PULL" != "no" ]; then [ -f package.json ] && [ "$AUTO_INSTALL" != "no" ];
            if [ "$AUTO_PULL" == "ask" ]; then
                echo "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
                echo "-| > .git configuration have been detected."
                echo "-| > Would you like to continue to pull from '${LIGHT_GREEN}${ORIGIN}${NORMAL}'? [Enter ${UNDERLINE}yes\e[24m or ${UNDERLINE}no\e[24m]"
                echo "-| > ${BOLD}Hint: You could hide this prompt by setting up a default value on the 'Startup' page.${NORMAL}"
                echo "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
                read confirmation
                case $confirmation in
                    [Yy]* )
                        echo "*| > Pulling from '${LIGHT_GREEN}${ORIGIN}${NORMAL}'..."
                        git pull --ff-only
                        ;;
                    * ) 
                        echo
                        echo "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
                        echo "*| > Skipped!"
                        echo "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
                        echo;;
                esac
            else
                git pull --ff-only ${GIT_REPOSITORY}
            fi
        fi
    fi
elif [ ! -z "$GIT_REPOSITORY" ] && [ ! -z "$GIT_BRANCH" ]; then
    echo "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
    echo "| > ${BOLD}WARNING! By cloning a Git Repository, all existing files will be deleted. Continue? [Enter ${UNDERLINE}yes\e[24m or ${UNDERLINE}no\e[24m]"
    echo "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
    read confirmation
    case $confirmation in
        [Yy]* )
            rm -rf ..?* .[!.]* *
            
            echo "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
            echo "-| > ${BOLD}/home/container${NORMAL} have been wiped out."
            echo "-| > Cloning '${LIGHT_GREEN}${GIT_BRANCH}${NORMAL}' from '${LIGHT_GREEN}${GIT_REPOSITORY}${NORMAL}'\e[24m"
            echo "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
            if [ ! -z "$GIT_TOKEN" ]; then
                git clone --single-branch --branch ${GIT_BRANCH} https://${GIT_TOKEN}@$(echo ${GIT_REPOSITORY} | cut -d/ -f3-) .
            else
                git clone --single-branch --branch ${GIT_BRANCH} ${GIT_REPOSITORY} .
            fi
            ;;
        * ) echo "*| > Skipped!";;
    esac
fi