#!/usr/bin/env bash

[[ `ps aux | grep "ccminer-cpu" | grep -v grep | wc -l` != 0 ]] &&
  echo -e "${RED}$CUSTOM_NAME miner is already running${NOCOLOR}" &&
  exit 1

. h-manifest.conf

unset LD_LIBRARY_PATH

conf=`cat $MINER_CONFIG_FILENAME`

if [[ $conf=~';' ]]; then
    conf=`echo $conf | tr -d '\'`
fi

./${$CUSTOM_VERSION}/ccminer-cpu ${conf//;/'\;'} --max-temp=85 -b 0.0.0.0:$MINER_API_PORT  2>&1 | tee --append $CUSTOM_LOG_BASENAME.log