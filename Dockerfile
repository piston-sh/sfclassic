FROM sourceforts/source-dedicated-server
LABEL maintainer="admin@deniscraig.com"

ENV SOURCEFORTS_DIR=/steam/steamapps/sourcemods/sourceforts

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