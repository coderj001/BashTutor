#!/bin/bash
# Display the usage and exit.

# Make sure the script is not being executed with superuser privileges.

# Parse the options.

# Remove the options while leaving the remaining arguments.

# If the user doesn't supply at least one argument, give them help.

# Anything that remains on the command line is to be treated as a single command.

# Make sure the SERVER_LIST file exists.

# Loop through the SERVER_LIST

# If it's a dry run, don't execute anything, just echo it.

# Capture any non-zero exit status from the SSH_COMMAND and report to the user.



SERVER_LIST='/vagrant/servers'

SSH_OPTIONS='-o ConnectTimeout=2'

function usage(){
  echo "Usage: ${0} [-nsv] [-f FILE] COMMAND " >&2
  echo "Executes COMMAND as a single command on every server." >&2
  echo "  -f FILE Use FILE for the list of servers. Default ${SERVER_LIST}." >&2
  echo "  -n      Dry run mode. Display the COMMAND that would have been executed and exit." >&2
  echo "  -s      Execte the COMMAND using sudo on the remote server." >&2
  echo "  -v      Verbose" >&2
  exit 1
}

if [[ ${UID} -eq 0 ]]; then
  echo "Do not use this script with sudo or root. Use the -s option instead" >&2
  usage
fi

while getopts f:nsv OPTION
do
  case ${OPTION} in
    f) SERVER_LIST="${OPTARG}" ;;
    n) DRY_RUN='true' ;;
    s) SUDO='sudo' ;;
    v) VERBOSE='true' ;;
    ?) usage ;;
  esac
done

shift "$(( OPTIND - 1 ))"

if [[ "${#}" -lt 1 ]]; then
  usage
fi

COMMAND="${@}"

if [[ ! -e "${SERVER_LIST}" ]]; then
  echo "Cannot open server list file ${SERVER_LIST}." >&2
  exit 1
fi

EXIT_STATUS='0'

for SERVER in $(cat ${SERVER_LIST})
do
  if [[ "${VERBOSE}" = 'true' ]]; then
    echo "${SERVER}"
  fi
  SSH_COMMAND="ssh ${SSH_OPTIONS} ${SERVER} ${SUDO} ${COMMAND}"
  if [[ "${DRY_RUN}" = 'true' ]]; then
    echo "DRY RUN: ${SSH_COMMAND}"
  else
    ${SSH_COMMAND}
    SSH_EXIT_STATUS="${?}"
    
    if [[ "${SSH_EXIT_STATUS}" -ne 0 ]]; then
      EXIT_STATUS="${SSH_EXIT_STATUS}"
      echo "Exceution on ${SERVER} failed" >&2
      exit 1
    fi
  fi
done
exit ${EXIT_STATUS}
