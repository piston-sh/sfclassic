FROM sourceforts/source-dedicated-server
LABEL maintainer="admin@deniscraig.com"

ENV SOURCEFORTS_DIR=$STEAM_HOME_DIR/sourceforts

COPY sourceforts $SOURCEFORTS_DIR
# Override server config
COPY cfg $SOURCEFORTS_DIR/cfg
COPY sourceforts_update.txt $SOURCEFORTS_DIR/sourceforts_update.txt

ENV HOSTNAME="docker-sourceforts"
ENV BLOCK_LIMIT=50 BUILD_LENGTH_LONG=600 BUILD_LENGTH_SHORT=240 COMBAT_LENGTH=600

VOLUME $SOURCEFORTS_DIR
COPY start.sh start.sh
ENTRYPOINT ./start.sh