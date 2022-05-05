#!/usr/bin/env bash
# https://github.com/complexorganizations/shell-script-boilerplate

# Require script to be run as root
function super-user-check() {
  if [ "${EUID}" -ne 0 ]; then
    echo "Error: You need to run this script as administrator."
    exit
  fi
}

# Check for root
super-user-check
# Get the current system information
function system-information() {
  if [ -f /etc/os-release ]; then
    # shellcheck source=/dev/null
    source /etc/os-release
    CURRENT_DISTRO=${ID}
    CURRENT_DISTRO_VERSION=${VERSION_ID}
  fi
}

# Get the current system information
system-information

# Pre-Checks system requirements
function installing-system-requirements() {
  if { [ "${CURRENT_DISTRO}" == "ubuntu" ] || [ "${CURRENT_DISTRO}" == "debian" ] || [ "${CURRENT_DISTRO}" == "raspbian" ] || [ "${CURRENT_DISTRO}" == "pop" ] || [ "${CURRENT_DISTRO}" == "kali" ] || [ "${CURRENT_DISTRO}" == "linuxmint" ] || [ "${CURRENT_DISTRO}" == "neon" ] || [ "${CURRENT_DISTRO}" == "fedora" ] || [ "${CURRENT_DISTRO}" == "centos" ] || [ "${CURRENT_DISTRO}" == "rhel" ] || [ "${CURRENT_DISTRO}" == "almalinux" ] || [ "${CURRENT_DISTRO}" == "rocky" ] || [ "${CURRENT_DISTRO}" == "arch" ] || [ "${CURRENT_DISTRO}" == "archarm" ] || [ "${CURRENT_DISTRO}" == "manjaro" ] || [ "${CURRENT_DISTRO}" == "alpine" ] || [ "${CURRENT_DISTRO}" == "freebsd" ] || [ "${CURRENT_DISTRO}" == "ol" ]; }; then
    if { [ ! -x "$(command -v curl)" ] || [ ! -x "$(command -v iptables)" ]; }; then
      if { [ "${CURRENT_DISTRO}" == "ubuntu" ] || [ "${CURRENT_DISTRO}" == "debian" ] || [ "${CURRENT_DISTRO}" == "raspbian" ] || [ "${CURRENT_DISTRO}" == "pop" ] || [ "${CURRENT_DISTRO}" == "kali" ] || [ "${CURRENT_DISTRO}" == "linuxmint" ] || [ "${CURRENT_DISTRO}" == "neon" ]; }; then
        apt-get update
        apt-get install curl --yes
      elif { [ "${CURRENT_DISTRO}" == "fedora" ] || [ "${CURRENT_DISTRO}" == "centos" ] || [ "${CURRENT_DISTRO}" == "rhel" ] || [ "${CURRENT_DISTRO}" == "almalinux" ] || [ "${CURRENT_DISTRO}" == "rocky" ]; }; then
        yum check-update
        yum install curl --yes
      elif { [ "${CURRENT_DISTRO}" == "arch" ] || [ "${CURRENT_DISTRO}" == "archarm" ] || [ "${CURRENT_DISTRO}" == "manjaro" ]; }; then
        pacman -Sy
        pacman -S --noconfirm --needed curl
      elif [ "${CURRENT_DISTRO}" == "alpine" ]; then
        apk update
        apk add curl
      elif [ "${CURRENT_DISTRO}" == "freebsd" ]; then
        pkg update
        pkg install curl
      elif [ "${CURRENT_DISTRO}" == "ol" ]; then
        yum check-update
        yum install curl --yes
      fi
    fi
  else
    echo "Error: ${CURRENT_DISTRO} ${CURRENT_DISTRO_VERSION} is not supported."
    exit
  fi
}

# Run the function and check for requirements
installing-system-requirements

# Global variables
GLOBAL_VARIABLES="/config/file/path"

if [ ! -f "${GLOBAL_VARIABLES}" ]; then

  # comments for the first question
  function first-question() {
    echo "What is the first question that u want to ask the user?"
    echo "  1) Ansewer #1 (Recommended)"
    echo "  2) Ansewer #2"
    echo "  3) Custom (Advanced)"
    until [[ "${FIRST_QUESTION_SETTINGS}" =~ ^[0-9]+$ ]] && [ "${FIRST_QUESTION_SETTINGS}" -ge 1 ] && [ "${FIRST_QUESTION_SETTINGS}" -le 3 ]; do
      read -rp "Ansewer choice [1-3]: " -e -i 1 FIRST_QUESTION_SETTINGS
    done
    case ${FIRST_QUESTION_SETTINGS} in
    1)
      FIRST_QUESTION="Ansewer #1"
      ;;
    2)
      FIRST_QUESTION="Ansewer #2"
      ;;
    3)
      read -rp "User text: " -e -i "Ansewer #3" FIRST_QUESTION
      ;;
    esac
  }

  # comments for the first question
  first-question

  ### use the code above to ask any questions as u want.
  function install-the-app() {
      if { [ "${CURRENT_DISTRO}" == "ubuntu" ] || [ "${CURRENT_DISTRO}" == "debian" ] || [ "${CURRENT_DISTRO}" == "raspbian" ] || [ "${CURRENT_DISTRO}" == "pop" ] || [ "${CURRENT_DISTRO}" == "kali" ] || [ "${CURRENT_DISTRO}" == "linuxmint" ] || [ "${CURRENT_DISTRO}" == "neon" ]; }; then
        apt-get update
      elif { [ "${CURRENT_DISTRO}" == "fedora" ] || [ "${CURRENT_DISTRO}" == "centos" ] || [ "${CURRENT_DISTRO}" == "rhel" ] || [ "${CURRENT_DISTRO}" == "almalinux" ] || [ "${CURRENT_DISTRO}" == "rocky" ]; }; then
        yum check-update
      elif { [ "${CURRENT_DISTRO}" == "arch" ] || [ "${CURRENT_DISTRO}" == "archarm" ] || [ "${CURRENT_DISTRO}" == "manjaro" ]; }; then
        pacman -Sy
      elif [ "${CURRENT_DISTRO}" == "alpine" ]; then
        apk update
      elif [ "${CURRENT_DISTRO}" == "freebsd" ]; then
        pkg update
      elif [ "${CURRENT_DISTRO}" == "ol" ]; then
        yum check-update
      fi
  }

  # run the function
  install-the-app

  # configure service here
  function config-service() {
    if { [ "${DISTRO}" == "ubuntu" ] || [ "${DISTRO}" == "debian" ] || [ "${DISTRO}" == "raspbian" ] || [ "${DISTRO}" == "pop" ] || [ "${DISTRO}" == "kali" ] || [ "${DISTRO}" == "linuxmint" ] || [ "${DISTRO}" == "fedora" ] || [ "${DISTRO}" == "centos" ] || [ "${DISTRO}" == "rhel" ] || [ "${DISTRO}" == "arch" ] || [ "${DISTRO}" == "archarm" ] || [ "${DISTRO}" == "manjaro" ] || [ "${DISTRO}" == "alpine" ] || [ "${DISTRO}" == "freebsd" ]; }; then
      echo "${GLOBAL_VARIABLES}"
      echo "${FIRST_QUESTION}"
      echo "${DISTRO}"
      echo "${DISTRO_VERSION}"
    fi
  }

  # run the function
  config-service

  function service-manager() {
    if pgrep systemd-journal; then
      systemctl disable SERVICE
      systemctl stop SERVICE
    else
      service SERVICE disable
      service SERVICE stop
    fi
  }

  # restart the chrome service
  service-manager

  function variable() {
    if [ -n "${FIRST_QUESTION}" ]; then
      echo "There is a var here"
    fi
    if [ -z "${FIRST_QUESTION}" ]; then
      echo "There is no var here"
    fi
  }

  variable

else

  # take user input
  function take-user-input() {
    echo "What do you want to do?"
    echo "   1) Option #1"
    echo "   2) Option #2"
    echo "   3) Option #3"
    echo "   4) Option #4"
    echo "   5) Option #5"
    until [[ "${USER_OPTIONS}" =~ ^[0-9]+$ ]] && [ "${USER_OPTIONS}" -ge 1 ] && [ "${USER_OPTIONS}" -le 5 ]; do
      read -rp "Select an Option [1-5]: " -e -i 1 USER_OPTIONS
    done
    case ${USER_OPTIONS} in
    1)
      echo "Hello, World!"
      ;;
    2)
      read -rp "Ask the user a Yes/No question. (y/n):" ASK_USER_A_QUESTION
      if { [ "${ASK_USER_A_QUESTION}" = "y" ] || [ "${ASK_USER_A_QUESTION}" = "Y" ]; }; then
        echo "The answer is yes."
      elif { [ "${ASK_USER_A_QUESTION}" = "n" ] || [ "${ASK_USER_A_QUESTION}" = "N" ]; }; then
        echo "The answer is no."
      else
        exit
      fi
      ;;
    3)
      echo "Hello, World!"
      ;;
    4)
      echo "Hello, World!"
      ;;
    5)
      echo "Hello, World!"
      ;;
    esac
  }

  # run the function
  take-user-input

fi
