./home/steam/steamcmd/steamcmd.sh \
        +login anonymous \
        +force_install_dir /home/steam/sourceforts \
        +app_update 232370 \
        +app_update 205 validate \
        +app_update 215 validate +quit && \
    ./home/steam/sourceforts/srcds_run -game sourceforts -console -autoupdate -steam_dir /home/steam/steamcmd/ -steamcmd_script /home/steam/sourceforts/sourceforts_update.txt \
        -usercon \
        +fps_max $SRCDS_FPSMAX \
        -tickrate $SRCDS_TICKRATE \
        -port $SRCDS_PORT \
        -tv_port $SRCDS_TV_PORT \
        -maxplayers_override $SRCDS_MAXPLAYERS \
        +sv_setsteamaccount $SRCDS_TOKEN \
        +rcon_password $SRCDS_RCONPW \
        +sv_password $SRCDS_PW \
        +sv_region $SRCDS_REGION \
        +hostname $HOSTNAME \
        +sf_team_blocklimit $BLOCK_LIMIT \
        +sf_build_long_length $BUILD_LENGTH_LONG \
        +sf_build_short_length $BUILD_LENGTH_SHORT \
        +sf_combat_length $COMBAT_LENGTH;