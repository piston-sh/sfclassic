FROM sourceforts/dedicated-server
LABEL maintainer="admin@deniscraig.com"

ENV SOURCEFORTS_DIR=$STEAM_HOME_DIR/sourceforts

COPY --chown=steam:steam sourceforts $SOURCEFORTS_DIR
# Override server config
COPY --chown=steam:steam cfg $SOURCEFORTS_DIR/cfg

ENV HOSTNAME="docker-sourceforts"
ENV BLOCK_LIMIT=50 BUILD_LENGTH_LONG=600 BUILD_LENGTH_SHORT=240 COMBAT_LENGTH=600

VOLUME $SOURCEFORTS_DIR
COPY --chown=steam:steam start.sh start.sh
RUN chmod +x start.sh
ENTRYPOINT ./start.sh
