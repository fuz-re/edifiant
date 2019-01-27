#!/bin/bash

Usage() {
	echo "edifiant.sh <command> <config file>"
	echo "where:"
	echo " command is one of : [ setup-instance, deploy-app ]"
	echo ""
}


if [[ -z "$2" ]];
then
	Usage
	exit
fi

COMMAND=$1
CONFIG_FILE=$2

source ${CONFIG_FILE}

case ${COMMAND} in
setup-instance)
  ansible-playbook provision_for_static_website.yml --extra-vars "target=${CT_HOSTNAME} ${VARS}"
  if [ $? -ne 0 ]
  then
	echo "pb_setup_container.yml failed with exit code: $?"
	exit
  fi

  ;;

deploy-app)
ansible-playbook deploy_static_website.yml --extra-vars "target=${CT_HOSTNAME} ${VARS}"
  if [ $? -ne 0 ]
  then
	echo "pb_setup_container.yml failed with exit code: $?"
	exit
  fi

  ;;

*)
  echo "Command missing, should be:"
esac

exit
