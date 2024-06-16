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

# Development
DEVELOPMENT_MODE="FALSE"

# Variables
SCRIPT_VERSION="v0.0.5-beta"
OS_VERSION=v$(cat /etc/alpine-release)
GIT_VERSION=v$(git --version | awk '{print $3}')
NODE_VERSION=$(node --version)
NPM_VERSION=v$(npm --version)
YARN_VERSION=$(yarn --version)
PYTHON_VERSION=v$(python3 --version | awk '{print $2}')
PIP_VERSION=v$(pip --version | awk '{print $2}')

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

# Position Variables
PV_APPLICATION=$1
PV_STARTER_FILE=$2
PV_TERMINAL_MODE=$6
PV_PACKAGE_MANAGER=$7
PV_AUTO_INSTALL=$8
PV_AUTO_PULL=$9
PV_TIMEOUT_MODE=${10}
PV_LOGGER=${11}
if [ "$1" != "none" ]; then
    PV_GIT_REPOSITORY=""
    PV_GIT_BRANCH=""
    PV_GIT_TOKEN=""; shift
elif [ "$1" == "none" ]; then
    PV_GIT_REPOSITORY="$3"
    PV_GIT_BRANCH="$4"
    PV_GIT_TOKEN="$5"; shift
fi

# Censorship Git Token
if [ "${PV_GIT_TOKEN}" == "" ]; then
    PV_CENSORED_GIT_TOKEN=""; shift
else
    LENGHT_GIT_TOKEN=$(( ${#PV_GIT_TOKEN} - 3 ))
    UNCENSORED_GIT_TOKEN="${PV_GIT_TOKEN:0:3}"
    CENSORED_GIT_TOKEN=$(printf "%${LENGHT_GIT_TOKEN}s" | tr ' ' '*')
    PV_CENSORED_GIT_TOKEN="${LIGHT_RED}$UNCENSORED_GIT_TOKEN$CENSORED_GIT_TOKEN${DEFAULT_COLOUR}"; shift
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

# Start
clear

# Banner

BLANK_LINE_SLEEP 0

echo -e "${LIGHT_MAGENTA}   ███████╗██╗░░░░░░█████╗░██████╗░███████╗██╗░░██╗░█████╗░██╗░░░░░░█████╗░██╗░░░██╗██████╗░${DEFAULT_COLOUR}"
echo -e "${LIGHT_MAGENTA}   ██╔════╝██║░░░░░██╔══██╗██╔══██╗██╔════╝╚██╗██╔╝██╔══██╗██║░░░░░██╔══██╗██║░░░██║██╔══██╗${DEFAULT_COLOUR}"
echo -e "${LIGHT_MAGENTA}   █████╗░░██║░░░░░███████║██████╔╝█████╗░░░╚███╔╝░██║░░╚═╝██║░░░░░██║░░██║██║░░░██║██║░░██║${DEFAULT_COLOUR}"
echo -e "${LIGHT_MAGENTA}   ██╔══╝░░██║░░░░░██╔══██║██╔══██╗██╔══╝░░░██╔██╗░██║░░██╗██║░░░░░██║░░██║██║░░░██║██║░░██║${DEFAULT_COLOUR}"
echo -e "${LIGHT_MAGENTA}   ██║░░░░░███████╗██║░░██║██║░░██║███████╗██╔╝╚██╗╚█████╔╝███████╗╚█████╔╝╚██████╔╝██████╔╝${DEFAULT_COLOUR}"
echo -e "${LIGHT_MAGENTA}   ╚═╝░░░░░╚══════╝╚═╝░░╚═╝╚═╝░░╚═╝╚══════╝╚═╝░░╚═╝░╚════╝░╚══════╝░╚════╝░░╚═════╝░╚═════╝░${DEFAULT_COLOUR}"

BLANK_LINE_SLEEP 2.5

# Show Details of Server Configuration
BLANK_LINE_SLEEP 0

$LIGHT_MAGENTA_LINE_BREAK

UNDERLINE_VARIABLE_PIPE_ARROW "Script Version" "${SCRIPT_VERSION}"
UNDERLINE_VARIABLE_PIPE_ARROW "Alpine Version" "${OS_VERSION}"
UNDERLINE_VARIABLE_PIPE_ARROW "Git Version" "${GIT_VERSION}"
UNDERLINE_VARIABLE_PIPE_ARROW "Node Version" "${NODE_VERSION}"
UNDERLINE_VARIABLE_PIPE_ARROW "NPM Version" "${NPM_VERSION}"
UNDERLINE_VARIABLE_PIPE_ARROW "Yarn Version" "${YARN_VERSION}"
UNDERLINE_VARIABLE_PIPE_ARROW "Python Version" "${PYTHON_VERSION}"
UNDERLINE_VARIABLE_PIPE_ARROW "Pip Version" "${PIP_VERSION}"
UNDERLINE_VARIABLE_PIPE_ARROW "Server UUID" "${P_SERVER_UUID}"

$LIGHT_MAGENTA_LINE_BREAK

BLANK_LINE_SLEEP 0

UNDERLINE_VARIABLE_PIPE_ARROW "Application" "${PV_APPLICATION}"
UNDERLINE_VARIABLE_PIPE_ARROW "Starter File" "${PV_STARTER_FILE}"
UNDERLINE_VARIABLE_PIPE_ARROW "Git Repository" "${PV_GIT_REPOSITORY}"
UNDERLINE_VARIABLE_PIPE_ARROW "Git Branch" "${PV_GIT_BRANCH}"
UNDERLINE_VARIABLE_PIPE_ARROW "Git Token" "${PV_CENSORED_GIT_TOKEN}"
UNDERLINE_VARIABLE_PIPE_ARROW "Package Manager" "${PV_PACKAGE_MANAGER}"
UNDERLINE_VARIABLE_PIPE_ARROW "Terminal Mode" "${PV_TERMINAL_MODE}"
UNDERLINE_VARIABLE_PIPE_ARROW "Auto Install" "${PV_AUTO_INSTALL}"
UNDERLINE_VARIABLE_PIPE_ARROW "Auto Pull" "${PV_AUTO_PULL}"
UNDERLINE_VARIABLE_PIPE_ARROW "Timeout Mode" "${PV_TIMEOUT_MODE}"
UNDERLINE_VARIABLE_PIPE_ARROW "Logs" "${PV_LOGGER}"

$LIGHT_MAGENTA_LINE_BREAK

BLANK_LINE_SLEEP 1.5

# Get Starter File
if [ "${DEVELOPMENT_MODE}" == "FALSE" ]; then
    wget -qO /tmp/starter https://raw.githubusercontent.com/FlarexCloud/FlarexCloud-Starter/main/starter.sh &> /dev/null
    chmod +x /tmp/starter &> /dev/null # Giving Permissions
else
    chmod +x starter.sh &> /dev/null # Giving Permissions
fi

# Selected Application
if [ "$PV_APPLICATION" == "none" ]; then
    BLANK_LINE_SLEEP 0
    DEFAULT_PIPE_ARROW "You've picked ${UNDERLINE}no application${DEFAULT_FONT}."
    $LIGHT_MAGENTA_LINE_BREAK
elif [ "$PV_APPLICATION" == "-(  WhatsApp Bots  )-" ] || [ "$PV_APPLICATION" == "-(  Discord Bots  )-" ] || [ "$PV_APPLICATION" == "-(  Telegram Bots  )-" ] || [ "$PV_APPLICATION" == "-(  Twitch Bots  )-" ] || [ "$PV_APPLICATION" == "-(  General Applications  )-" ]; then
    WARNING_PIPE_ARROW "'${LIGHT_RED}${UNDERLINE}${PV_APPLICATION}${DEFAULT_FONT}${DEFAULT_COLOUR}' is not a valid application, please pick another one!"
    $LIGHT_MAGENTA_LINE_BREAK
        exit 1
else
    WARNING_PIPE_ARROW "Do not forget to reinstall your server in order for '${UNDERLINE}${PV_APPLICATION}${DEFAULT_FONT}' to work."
    DEFAULT_PIPE_ARROW "Remember to take a look at our Discord Server (${LIGHT_MAGENTA}${BOLD} https://discord.flarex.cloud ${DEFAULT_FONT}${DEFAULT_COLOUR}) and at our Knowledgebase (${LIGHT_MAGENTA}${BOLD} https://docs.flarex.cloud ${DEFAULT_FONT}${DEFAULT_COLOUR})"
    DEFAULT_PIPE_ARROW "Just in case you need help setting up '${UNDERLINE}${PV_APPLICATION}${DEFAULT_FONT}'!"
    $LIGHT_MAGENTA_LINE_BREAK
fi

if [ "${DEVELOPMENT_MODE}" == "FALSE" ]; then
    bash /tmp/starter "${PV_GIT_REPOSITORY}" "${PV_GIT_BRANCH}" "${PV_GIT_TOKEN}" ${PV_TERMINAL_MODE} ${PV_TIMEOUT_MODE} ${PV_AUTO_PULL} # Executing remote script
else
    bash starter.sh "${PV_GIT_REPOSITORY}" "${PV_GIT_BRANCH}" "${PV_GIT_TOKEN}" ${PV_TERMINAL_MODE} ${PV_TIMEOUT_MODE} ${PV_AUTO_PULL} # Executing local script
fi

# Package Manager
package_manager_timeout() {
    case $USER_CONFIRMATION in
        1 )
            $LIGHT_MAGENTA_LINE_BREAK
            PV_PACKAGE_MANAGER="npm";;
        * )
            $LIGHT_MAGENTA_LINE_BREAK
            PV_PACKAGE_MANAGER="yarn";;
    esac
    DEFAULT_PIPE_ARROW "Using ${PV_PACKAGE_MANAGER} as the Package Manager..."
    $LIGHT_MAGENTA_LINE_BREAK
}

if [ "${PV_PACKAGE_MANAGER}" == "ask" ]; then
    $LIGHT_MAGENTA_LINE_BREAK
    DEFAULT_PIPE_ARROW "Please choose your favourite package manager: [Enter the integer]"
    DEFAULT_PIPE_ARROW
    DEFAULT_PIPE_ARROW "1) npm ($NPM_VERSION)"
    DEFAULT_PIPE_ARROW
    DEFAULT_PIPE_ARROW "2) yarn ($YARN_VERSION) [RECOMMENDED]"
    DEFAULT_PIPE_ARROW
    HINT_PIPE_ARROW
    if [ "${PV_TIMEOUT_MODE}" == "yes" ]; then
        WARNING_PIPE_ARROW "Be aware that after '${UNDERLINE}60 seconds${DEFAULT_FONT}' the question will be skipped."
    fi
    $LIGHT_MAGENTA_LINE_BREAK
    if [ "${PV_TIMEOUT_MODE}" == "yes" ]; then
        if read -t 60 USER_CONFIRMATION; then
            package_manager_timeout
        else
            $LIGHT_MAGENTA_LINE_BREAK
            WARNING_PIPE_ARROW "Skipping question due to user inactivity."
            PV_PACKAGE_MANAGER="yarn"
            WARNING_PIPE_ARROW "Using ${PV_PACKAGE_MANAGER} as the Package Manager."
            $LIGHT_MAGENTA_LINE_BREAK
        fi
    else
        read USER_CONFIRMATION
        package_manager_timeout
    fi
fi

# Auto Install
DEFAULT_START_CMD="/usr/local/bin/${PV_PACKAGE_MANAGER} install"

auto_install_timeout() {
    case $USER_CONFIRMATION in
        [Yy]* )
            DEFAULT_PIPE_ARROW "We'll be installing/upgrading from '${UNDERLINE}package.json${DEFAULT_FONT}' using '${UNDERLINE}${PV_PACKAGE_MANAGER}${DEFAULT_FONT}'..."
            $LIGHT_MAGENTA_LINE_BREAK
            BLANK_LINE_SLEEP 0
            eval ${DEFAULT_START_CMD};;
        * )
            WARNING_PIPE_ARROW "Skipped!"
            $LIGHT_MAGENTA_LINE_BREAK;;
    esac
}

if [ -f package.json ]; then
    if [ "${PV_AUTO_INSTALL}" == "ask" ]; then
        $LIGHT_MAGENTA_LINE_BREAK
        DEFAULT_PIPE_ARROW "A '${UNDERLINE}package.json${DEFAULT_FONT}' have been detected!"
        DEFAULT_PIPE_ARROW "Continue to install/upgrade from '${UNDERLINE}package.json${DEFAULT_FONT}'? [Enter ${UNDERLINE}yes${DEFAULT_FONT} or ${UNDERLINE}no${DEFAULT_FONT}]"
        HINT_PIPE_ARROW
        if [ "${PV_TIMEOUT_MODE}" == "yes" ]; then
            WARNING_PIPE_ARROW "Be aware that after '${UNDERLINE}60 seconds${DEFAULT_FONT}' the question will be skipped."
        fi
        $LIGHT_MAGENTA_LINE_BREAK
        if [ "${PV_TIMEOUT_MODE}" == "yes" ]; then
            if read -t 60 USER_CONFIRMATION; then
                auto_install_timeout
            else
                $LIGHT_MAGENTA_LINE_BREAK
                WARNING_PIPE_ARROW "Skipping question due to user inactivity."
                $LIGHT_MAGENTA_LINE_BREAK
            fi
        else
            read USER_CONFIRMATION
            auto_install_timeout
        fi
    elif [ "${PV_AUTO_INSTALL}" == "yes" ]; then
        BLANK_LINE_SLEEP 0
        $LIGHT_MAGENTA_LINE_BREAK
        DEFAULT_PIPE_ARROW "We'll be installing/upgrading from package.json..."
        $LIGHT_MAGENTA_LINE_BREAK
        BLANK_LINE_SLEEP 0
        eval ${DEFAULT_START_CMD}
    else
        WARNING_PIPE_ARROW "User disabled Auto Install."
        $LIGHT_MAGENTA_LINE_BREAK
    fi
fi

# Start Application
if [ "${PV_APPLICATION}" == "none" && "${PV_STARTER_FILE}" == "" ]; then
    START_CMD="/usr/local/bin/node ${PV_STARTER_FILE}"; shift
    BLANK_LINE_SLEEP 0
elif [ "${PV_APPLICATION}" == "none" ]; then
    START_CMD="/usr/local/bin/node ${PV_STARTER_FILE}"; shift
    BLANK_LINE_SLEEP 0
else
    START_CMD="/usr/local/bin/node ."; shift
fi

# Logs
logs_mode() {
    ${START_CMD} 2>&1 | tee "flarexcloud_logs_$(date +%d-%m-%Y_%H-%M-%S).log"
}

logs_mode_timeout() {
    case $USER_CONFIRMATION in
        [Yy]* )
            logs_mode
            eval "${START_CMD}";;
        * ) 
            WARNING_PIPE_ARROW "Skipped!"
            $LIGHT_MAGENTA_LINE_BREAK
            eval "${START_CMD}";;
    esac
}

if [ "${PV_LOGGER}" == "ask" ]; then
    DEFAULT_PIPE_ARROW "Would you like to enable logs for better debugging? [Enter ${UNDERLINE}yes${DEFAULT_FONT} or ${UNDERLINE}no${DEFAULT_FONT}]"
    HINT_PIPE_ARROW
    if [ "${PV_TIMEOUT_MODE}" == "yes" ]; then
        WARNING_PIPE_ARROW "Be aware that after '${UNDERLINE}60 seconds${DEFAULT_FONT}' the question will be skipped."
    fi
    $LIGHT_MAGENTA_LINE_BREAK
    if [ "${PV_TIMEOUT_MODE}" == "yes" ]; then
        if read -t 60 USER_CONFIRMATION; then
            logs_mode_timeout
        else
            WARNING_PIPE_ARROW "Skipping question due to user inactivity."
            $LIGHT_MAGENTA_LINE_BREAK
        fi
    else
        read USER_CONFIRMATION
        logs_mode_timeout
    fi
elif [ "${PV_LOGGER}" == "yes" ]; then
    logs_mode
else
    WARNING_PIPE_ARROW "User disabled Logger (Logs)."
    $LIGHT_MAGENTA_LINE_BREAK
    eval "${START_CMD}"
fi

# Starting Application
if [ ${PV_APPLICATION} == "none" ]; then
    DEFAULT_PIPE_ARROW "Starting Application..."
    $LIGHT_MAGENTA_LINE_BREAK
    BLANK_LINE_SLEEP 0.5
else
    DEFAULT_PIPE_ARROW "Starting Application '${UNDERLINE}${PV_APPLICATION}${DEFAULT_FONT}'..."
    $LIGHT_MAGENTA_LINE_BREAK
    BLANK_LINE_SLEEP 0.5
fi