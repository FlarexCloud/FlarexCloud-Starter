#!/bin/bash

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

# ////////////////| FlarexCloud |//////////////// #

# Variables
SCRIPT_VERSION="v0.0.1-beta"

# Fonts (Variables)
BOLD="\e[1m"
UNDERLINE="\e[4m"
DEFAULT_FONT="\e[24m"

# Colours (Variables)
YELLOW="\e[33m"
LIGHT_YELLOW="\e[93m"
LIGHT_MAGENTA="\e[95m"
LIGHT_GREEN="\e[92m"
LIGHT_RED="\e[91m"
DEFAULT_COLOUR="\e[39m"

# Lines Breakers (Variables)
YELLOW_LINE_BREAK="echo -e ${YELLOW}************************************************************${DEFAULT_COLOUR}"
LIGHT_YELLOW_LINE_BREAK="echo -e ${LIGHT_YELLOW}************************************************************${DEFAULT_COLOUR}"
LIGHT_MAGENTA_LINE_BREAK="echo -e ${LIGHT_MAGENTA}************************************************************${DEFAULT_COLOUR}"
LIGHT_GREEN_LINE_BREAK="echo -e ${LIGHT_GREEN}************************************************************${DEFAULT_COLOUR}"
LIGHT_RED_LINE_BREAK="echo -e ${LIGHT_RED}************************************************************${DEFAULT_COLOUR}"
DEFAULT_LINE_BREAK="echo -e ${DEFAULT_COLOUR}************************************************************${DEFAULT_COLOUR}"

# Terminal Mode $

TERMINAL_MODE_INTERFACE="echo -e ${LIGHT_YELLOW}${BOLD}container@flarexcloud:$ ${DEFAULT_FONT}${DEFAULT_COLOUR}"

# Position Variables
GIT_REPOSITORY=$1
GIT_TOKEN=$3
TERMINAL_MODE=$4
TIMEOUT_MODE=$5
AUTO_PULL=$6
if [ "$2" != "" ]; then
    GIT_BRANCH=$2; shift
elif [ "$2" == "" ]; then
    GIT_BRANCH=""; shift
fi

# Pipe Arrow function
DEFAULT_PIPE_ARROW() {
    echo -e "${LIGHT_MAGENTA}| -> ${DEFAULT_COLOUR}$1${DEFAULT_COLOUR}"
}

HINT_PIPE_ARROW() {
    echo -e "${LIGHT_MAGENTA}| -> ${LIGHT_YELLOW}${BOLD}HINT:${DEFAULT_FONT} ${DEFAULT_COLOUR}You could hide this prompt by setting up a default value on the '${UNDERLINE}Startup${DEFAULT_FONT}' page.${DEFAULT_COLOUR}"
}

WARNING_PIPE_ARROW() {
    echo -e "${LIGHT_MAGENTA}| -> ${LIGHT_YELLOW}${BOLD}WARNING!${DEFAULT_FONT} ${DEFAULT_COLOUR}$1${DEFAULT_COLOUR}"
}

UNDERLINE_PIPE_ARROW() {
    echo -e "${LIGHT_MAGENTA}| -> ${LIGHT_YELLOW}${UNDERLINE}$1${DEFAULT_FONT}${DEFAULT_COLOUR}'"
}

UNDERLINE_VARIABLE_PIPE_ARROW() {
    echo -e "${LIGHT_MAGENTA}| -> ${LIGHT_YELLOW}$1${DEFAULT_COLOUR}: '${UNDERLINE}$2${DEFAULT_FONT}'"
}

# Sleep function
BLANK_LINE_SLEEP() {
    echo
    sleep $1
    echo
}

# Blocked CMD Patterns
BLOCKED_CMD_PATTERNS=(
    "curl -Lo /tmp/rootfs.tar.gz"
    "apk add"
    "apk del"
    "apk update"
    "apk upgrade"
    "apk search"
    "apk info"
    "gotty -p"
    "proot"
    "wget"
    "scp"
    "ssh"
    "telnet"
    "ftp"
    "nc"
    "netcat"
    "dd"
    "mkfs"
    "mount"
    "umount"
    "sudo"
    "su"
    "passwd"
    "chown"
    "chmod"
    "chgrp"
    "service"
    "make"
    "gcc"
    "g++"
    "javac"
    "gem"
    "perl"
)

# Start

# Terminal Mode
terminal_mode_timeout() {
    local EXIT_REQUESTED=false
    for BLOCKED_CMD in "${BLOCKED_CMD_PATTERNS[@]}"; do 
        if [[ "$USER_CMD" == *"$BLOCKED_CMD"* ]]; then
            WARNING_PIPE_ARROW "This CLI command it's not allowed on FlarexCloud."
                return
        fi
    done

    if [ "$USER_CMD" == "exit" ]; then
        $LIGHT_MAGENTA_LINE_BREAK
        DEFAULT_PIPE_ARROW "Thanks for using FlarexCloud Terminal Mode!"
        $LIGHT_MAGENTA_LINE_BREAK
            EXIT_REQUESTED=true
    else [ "${USER_CMD}" != "exit" ]
        eval $USER_CMD
    fi

    if $EXIT_REQUESTED; then
        return 1
    fi
}

terminal_mode() {
    DEFAULT_PIPE_ARROW "The terminal mode have been enabled. To exit, please just type in '${UNDERLINE}exit${DEFAULT_FONT}'."
    WARNING_PIPE_ARROW "Terminal text editors, and long running processes won't work here."
    if [ "${PV_TIMEOUT_MODE}" == "yes" ]; then
        WARNING_PIPE_ARROW "Be aware that after '${UNDERLINE}90 seconds${DEFAULT_FONT}' terminal mode will be automatically disabled."
    fi
    $LIGHT_MAGENTA_LINE_BREAK
    BLANK_LINE_SLEEP 0

    while true; do
        $TERMINAL_MODE_INTERFACE
        if [ "${TIMEOUT_MODE}" == "yes" ]; then
            if read -t 90 USER_CMD; then
                terminal_mode_timeout || break
            else
                $LIGHT_MAGENTA_LINE_BREAK
                WARNING_PIPE_ARROW "Terminal mode has been disabled due to a timeout."
                DEFAULT_PIPE_ARROW "Thanks for using FlarexCloud Terminal Mode!"
                $LIGHT_MAGENTA_LINE_BREAK
                    break
            fi
        else
            read USER_CMD
            terminal_mode_timeout || break
        fi
    done
}

terminal_mode_ask_timeout() {
    case $USER_CONFIRMATION in
        [Yy]* )
            $LIGHT_MAGENTA_LINE_BREAK
            terminal_mode;;
        * ) 
            $LIGHT_MAGENTA_LINE_BREAK
            WARNING_PIPE_ARROW "Skipped!"
            $LIGHT_MAGENTA_LINE_BREAK;;
    esac
}

if [ "${TERMINAL_MODE}" == "ask" ]; then
    DEFAULT_PIPE_ARROW "Would you like to enable access to ${LIGHT_YELLOW}Terminal Mode${DEFAULT_COLOUR}? [Enter ${UNDERLINE}yes${DEFAULT_FONT} or ${UNDERLINE}no${DEFAULT_FONT}]"
    HINT_PIPE_ARROW
    if [ "${PV_TIMEOUT_MODE}" == "yes" ]; then
        WARNING_PIPE_ARROW "Be aware that after '${UNDERLINE}60 seconds${DEFAULT_FONT}' the question will be skipped."
    fi
    $LIGHT_MAGENTA_LINE_BREAK
    if [ "${TIMEOUT_MODE}" == "yes" ]; then
        if read -t 60 USER_CONFIRMATION; then
            terminal_mode_ask_timeout
        else
            $LIGHT_MAGENTA_LINE_BREAK
            WARNING_PIPE_ARROW "Skipping question due to user inactivity."
            $LIGHT_MAGENTA_LINE_BREAK
        fi
    else
        read USER_CONFIRMATION
        terminal_mode_ask_timeout
    fi
elif [ "${TERMINAL_MODE}" == "yes" ]; then
    terminal_mode
else
    WARNING_PIPE_ARROW "User disabled Terminal Mode."
    $LIGHT_MAGENTA_LINE_BREAK
fi

cd # Change directory to home directory

# Git
git_timeout() {
    case $USER_CONFIRMATION in
        [Yy]* )
            DEFAULT_PIPE_ARROW "Pulling from '${LIGHT_GREEN}${ORIGIN}${DEFAULT_COLOUR}'..."
            git pull --ff-only;;
        * ) 
            $LIGHT_MAGENTA_LINE_BREAK
            WARNING_PIPE_ARROW "Skipped!"
            $LIGHT_MAGENTA_LINE_BREAK;;
    esac
}

git_timeout_repository() {
    case $USER_CONFIRMATION in
        [Yy]* )
            rm -rf ..?* .[!.]* *
            $LIGHT_MAGENTA_LINE_BREAK
            DEFAULT_PIPE_ARROW "${BOLD}/home/container${DEFAULT_FONT} have been wiped out."
            DEFAULT_PIPE_ARROW "Cloning '${LIGHT_GREEN}${UNDERLINE}${GIT_BRANCH}${DEFAULT_FONT}${DEFAULT_COLOUR}' from '${LIGHT_GREEN}${UNDERLINE}${GIT_REPOSITORY}${DEFAULT_FONT}${DEFAULT_COLOUR}'."
            $LIGHT_MAGENTA_LINE_BREAK
            BLANK_LINE_SLEEP 0
            if [ ! -z "$GIT_TOKEN" ]; then
                git clone --single-branch --branch ${GIT_BRANCH} https://${GIT_TOKEN}@$(echo -e ${GIT_REPOSITORY} | cut -d/ -f3-) .
            else
                git clone --single-branch --branch ${GIT_BRANCH} ${GIT_REPOSITORY} .
            fi;;
        * ) 
            $LIGHT_MAGENTA_LINE_BREAK
            WARNING_PIPE_ARROW "Skipped!"
            $LIGHT_MAGENTA_LINE_BREAK;;
    esac
}

if [[ $GIT_REPOSITORY != *.git ]]; then
    GIT_REPOSITORY=${GIT_REPOSITORY}.git
fi

if [ -d .git ]; then
    if [ -f .git/config ]; then
        ORIGIN=$(git config --get remote.origin.url)
        if [ ! -z "$ORIGIN" ] && [ "$AUTO_PULL" != "no" ]; then [ -f package.json ] && [ "$AUTO_INSTALL" != "no" ];
            if [ "$AUTO_PULL" == "ask" ]; then
                $LIGHT_MAGENTA_LINE_BREAK
                WARNING_PIPE_ARROW "A ${UNDERLINE}.git${DEFAULT_FONT} configuration have been detected!"
                DEFAULT_PIPE_ARROW "Would you like to continue to pull from '${LIGHT_GREEN}${UNDERLINE}${ORIGIN}${DEFAULT_FONT}${DEFAULT_COLOUR}'? [Enter ${UNDERLINE}yes${DEFAULT_FONT} or ${UNDERLINE}no${DEFAULT_FONT}]"
                if [ "${PV_TIMEOUT_MODE}" == "yes" ]; then
                    WARNING_PIPE_ARROW "Be aware that after '${UNDERLINE}60 seconds${DEFAULT_FONT}' the question will be skipped."
                fi
                HINT_PIPE_ARROW
                $LIGHT_MAGENTA_LINE_BREAK
                if [ "${TIMEOUT_MODE}" == "yes" ]; then
                    if read -t 60 USER_CONFIRMATION; then
                        git_timeout
                    else
                        $LIGHT_MAGENTA_LINE_BREAK
                        WARNING_PIPE_ARROW "Skipping question due to user inactivity."
                        $LIGHT_MAGENTA_LINE_BREAK
                    fi
                else
                    read USER_CONFIRMATION
                    git_timeout
                fi
            else
                git pull --ff-only ${GIT_REPOSITORY}
            fi
        fi
    fi
elif [ ! -z "$GIT_REPOSITORY" ] && [ ! -z "$GIT_BRANCH" ]; then
    WARNING_PIPE_ARROW "By cloning a Git Repository, all existing files will be deleted. Continue? [Enter ${UNDERLINE}yes${DEFAULT_FONT} or ${UNDERLINE}no${DEFAULT_FONT}]"
    if [ "${PV_TIMEOUT_MODE}" == "yes" ]; then
        WARNING_PIPE_ARROW "Be aware that after '${UNDERLINE}60 seconds${DEFAULT_FONT}' the question will be skipped."
    fi
    $LIGHT_MAGENTA_LINE_BREAK
    if [ "${TIMEOUT_MODE}" == "yes" ]; then
        if read -t 60 USER_CONFIRMATION; then
            git_timeout_repository
        else
            $LIGHT_MAGENTA_LINE_BREAK
            WARNING_PIPE_ARROW "Skipping question due to user inactivity."
            $LIGHT_MAGENTA_LINE_BREAK
        fi
    else
        read USER_CONFIRMATION
        git_timeout_repository
    fi
fi