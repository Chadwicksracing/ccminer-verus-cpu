#!/usr/bin/env bash
# This code is included in /hive/bin/custom function

[[ -z $CUSTOM_TEMPLATE ]] && echo -e "${YELLOW}CUSTOM_TEMPLATE is empty${NOCOLOR}" && return 1
[[ -z $CUSTOM_URL ]] && echo -e "${YELLOW}CUSTOM_URL is empty${NOCOLOR}" && return 1


CPU_CORES=$(cat /proc/cpuinfo | grep processor | wc -l)
threadcount=$CPU_CORES

conf=" -a verus -o $CUSTOM_URL -u $CUSTOM_TEMPLATE -p $CUSTOM_PASS -t $threadcount "

#[[ ! $CUSTOM_USER_CONFIG =~ '-deviceid' ]] && conf+=" -multi-gpu"
#conf+=" ${CUSTOM_USER_CONFIG} -no-cpu -skip -stats ${CUSTOM_LOG_BASENAME}.json"

[[ -z $CUSTOM_CONFIG_FILENAME ]] && echo -e "${RED}No CUSTOM_CONFIG_FILENAME is set${NOCOLOR}" && return 1
echo "$conf" > $CUSTOM_CONFIG_FILENAME