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

REPO=$1
BRANCH=$2
TERMINAL=$3
AUTO_PULL=$4

NORMAL="\e[0m"
BOLD="\e[1m"
UNDERLINE="\e[4m"

YELLOW="\e[33m"
LIGHT_MAGENTA="\e[95m"
LIGHT_GREEN="\e[92m"
DEFAULT="\e[39m"

# || Terminal Mode

terminal_mode() {
    echo -e "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
    echo -e "| > The terminal mode have been enabled. To exit, please just type in '${UNDERLINE}exit\e[24m'."
    echo -e "| > ${BOLD}WARNING! Terminal text editors, and long running processes won't work here.\e[21m${NORMAL}"
    echo -e "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
    echo -e "\033[1m${YELLOW}container@acidicnodes:$\033[0m"
    while true; do
        read -p "\033[1m${YELLOW}container@acidicnodes:$\033[0m " cmd
        if [ "$cmd" == "exit" ]; then
            echo -e "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
            echo -e "| > Thanks for using AcidicNodes, and it's Terminal Mode."
            echo -e "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
            sleep 1
            exit
        else
            eval "$cmd"
            sleep 0.1
            echo "\033[1m${YELLOW}container@acidicnodes:$\033[0m "
        fi
    done
}

if [ "$TERMINAL" == "ask" ]; then
    echo -e "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
    echo -e "-| > Would you like no enable the access to terminal mode? [Enter ${UNDERLINE}yes\e[24m or ${UNDERLINE}no\e[24m]"
    echo -e "-| > ${BOLD}Hint: You could hide this prompt by setting up a default value on the 'Startup' page.${NORMAL}"
    echo -e "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
    read confirmation
    case $confirmation in
        [Yy]* ) terminal_mode;;
    esac
elif [ "$TERMINAL" == "yes" ]; then
    terminal_mode
fi

echo -e "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
echo -e "-| > ${BOLD}Terminal mode have been disabled!${NORMAL}"
echo -e "${LIGHT_MAGENTA}************************************************************${DEFAULT}";

cd /home/container

# || GitHub

if [[ $REPO != *.git ]]; then
    REPO=${REPO}.git
fi

if [ -d .git ]; then
    if [ -f .git/config ]; then
        ORIGIN=$(git config --get remote.origin.url)
        if [ ! -z "$ORIGIN" ] && [ "$AUTO_PULL" != "no" ]; then
            if [ "$AUTO_PULL" == "ask" ]; then
                echo -e "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
                echo -e "-| > .git configuration have been detected."
                echo -e "-| > Would you like to continue to pull from '${LIGHT_GREEN}${ORIGIN}${NORMAL}'? [Enter ${UNDERLINE}yes\e[24m or ${UNDERLINE}no\e[24m]"
                echo -e "-| > ${BOLD}Hint: You could hide this prompt by setting up a default value on the 'Startup' page.${NORMAL}"
                echo -e "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
                read confirmation
                case $confirmation in
                    [Yy]* )
                        echo "*| > Pulling from '${LIGHT_GREEN}${ORIGIN}${NORMAL}'..."
                        git pull --ff-only
                        ;;
                    * ) echo "*| > Skipped!";;
                esac
            else
                git pull --ff-only ${REPO}
            fi
        fi
    fi
elif [ ! -z "$REPO" ] && [ ! -z "$BRANCH" ]; then
    echo -e "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
    echo -e "| > ${BOLD}WARNING! By cloning a Git Repository, all existing files will be deleted. Continue? [Enter ${UNDERLINE}yes\e[24m or ${UNDERLINE}no\e[24m]"
    echo -e "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
    read confirmation
    case $confirmation in
        [Yy]* )
            rm -rf ..?* .[!.]* *
            echo -e "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
            echo -e "-| > ${BOLD}/home/container${NORMAL} have been wiped out."
            echo -e "-| > Cloning '${LIGHT_GREEN}${BRANCH}${NORMAL}' from '${LIGHT_GREEN}${REPO}${NORMAL}'\e[24m"
            echo -e "${LIGHT_MAGENTA}************************************************************${DEFAULT}"
            git clone --single-branch --branch ${BRANCH} ${REPO} .
            ;;
        * ) echo "*| > Skipped!";;
    esac
fi