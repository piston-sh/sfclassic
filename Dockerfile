FROM sourceforts/dedicated-server
LABEL maintainer="admin@deniscraig.com"

ENV SOURCEFORTS_DIR=$STEAM_USER_DIR/sourceforts

COPY --chown=steam:steam sourceforts $SOURCEFORTS_DIR
# Override server config
COPY --chown=steam:steam cfg $SOURCEFORTS_DIR/cfg

USER steam

ENV HOSTNAME="docker-sourceforts"
ENV DEFAULT_MAP="sf_skywalk"
ENV BLOCK_LIMIT=50 
ENV BUILD_LENGTH_LONG=600 
ENV BUILD_LENGTH_SHORT=240 
ENV COMBAT_LENGTH=600

VOLUME $SOURCEFORTS_DIR
COPY --chown=steam:steam start.sh start.sh
ENTRYPOINT [ "./start.sh" ]
