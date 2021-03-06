#!/bin/bash

LOG_DIR=$STEAM_USER_DIR/Steam/logs
LOG_FILE=$LOG_DIR/daemon.log
SF_ARGS="+sf_team_blocklimit $BLOCK_LIMIT +sf_build_long_length $BUILD_LENGTH_LONG +sf_combat_length $COMBAT_LENGTH"
SRCDS_ARGS="+fps_max $SRCDS_FPSMAX -tickrate $SRCDS_TICKRATE -port $SRCDS_PORT -tv_port $SRCDS_TV_PORT +maxplayers $SRCDS_MAXPLAYERS +rcon_password $SRCDS_RCONPW +sv_password $SRCDS_PW"
EXTRA_ARGS="$SRCDS_ARGS $SF_ARGS"
ARGS="-game $GAME -console -norestart +ip 0.0.0.0 +hostname $HOSTNAME +map $DEFAULT_MAP +exec $GAME_DIR/server.cfg $EXTRA_ARGS"

if [ ! -f $LOG_FILE ]; then
    touch $LOG_FILE
fi

# Update hostnames
find $GAME_DIR/cfg -name *.cfg -exec sed -i "s/{hostname}/$HOSTNAME/g" {} \;

./srcds_run -steam_dir $(pwd) -steamcmd_script $(pwd)/steamcmd/steamcmd.sh $ARGS >> $LOG_FILE 2>&1
tail -F $LOG_DIR/*
