#!/usr/bin/env bash

[[ `ps aux | grep "./ccminer" | grep -v grep | wc -l` != 0 ]] &&
	echo -e "${RED}$MINER_NAME miner is already running${NOCOLOR}" &&
	exit 1

#try to release TIME_WAIT sockets
while true; do
	for con in `netstat -anp | grep TIME_WAIT | grep $MINER_API_PORT | awk '{print $5}'`; do
		killcx $con lo
	done
	netstat -anp | grep TIME_WAIT | grep $MINER_API_PORT &&
		continue ||
		break
done


cd $MINER_DIR/$MINER_FORK/$MINER_VER
[[ -e $MINER_DIR/$MINER_FORK/$MINER_VER/h-local.conf ]] && source $MINER_DIR/$MINER_FORK/$MINER_VER/h-local.conf
./ccminer-cpu -c pools.conf 2>&1 | tee --append ${MINER_LOG_BASENAME}.log
