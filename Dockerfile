FROM cm2network/steamcmd
LABEL maintainer="admin@deniscraig.com"

ENV STEAM_HOME_DIR=/steam
ENV STEAMAPPS_DIR=/steam/steamapps
ENV SOURCEFORTS_DIR=/steam/steamapps/sourcemods/sourceforts
ENV DEDICATED_SERVER_DIR=/steam/steamapps/common/Source\ Dedicated\ Server\ Server

# Run Steamcmd and install dependencies
# - 205 Source Dedicated Server
# - 215 Source SDK Base 2006
# - 232370 Half-Life 2 Deathmatch Dedicated Server
RUN ./home/steam/steamcmd/steamcmd.sh +login anonymous \
        +force_install_dir $STEAM_HOME_DIR \
        +app_update 205 validate \
        +app_update 215 validate \
        +app_update 232370 validate \
        +quit

COPY sourceforts $SOURCEFORTS_DIR
# Override server config
COPY cfg $SOURCEFORTS_DIR/cfg

ENV HOSTNAME="docker-sourceforts"
ENV SRCDS_FPSMAX=300 SRCDS_TICKRATE=128 SRCDS_PORT=27015 SRCDS_TV_PORT=27020 SRCDS_MAXPLAYERS=20 SRCDS_TOKEN=0 SRCDS_RCONPW="changeme" SRCDS_PW="changeme"
ENV BLOCK_LIMIT=50 BUILD_LENGTH_LONG=600 BUILD_LENGTH_SHORT=240 COMBAT_LENGTH=600

VOLUME $SOURCEFORTS_DIR

# Set Entrypoint; Technically 2 steps: 1. Update server, 2. Start server
COPY start.sh start.sh
ENTRYPOINT ./start.sh

# Expose ports
EXPOSE 27015 27020 27005 51840