FROM sourceforts/steamcmd
LABEL maintainer="admin@deniscraig.com"

ENV DEDICATED_SERVER_DIR=/steam/steamapps/common/Source\ Dedicated\ Server\ Server

# Run Steamcmd and install dependencies
# - 244310      Source SDK Base 2013 Dedicated Server
# - 243730      Source SDK Base 2013 Multiplayer
# - 232370      Half-Life 2 Deathmatch Dedicated Server
RUN steamcmd.sh +login anonymous +force_install_dir $STEAM_HOME_DIR \
        +app_update 244310 validate \
        +app_update 243730 validate \
        +app_update 232370 validate \
        +quit;

ENV HOSTNAME="docker-source-dedicated-server"
ENV SRCDS_FPSMAX=300 SRCDS_TICKRATE=128 SRCDS_PORT=27015 SRCDS_TV_PORT=27020 SRCDS_MAXPLAYERS=20 SRCDS_TOKEN=0 SRCDS_RCONPW="changeme" SRCDS_PW="changeme"

# Expose ports
EXPOSE 27015 27020 27005 51840