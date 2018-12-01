FROM sourceforts/srcds-server
LABEL maintainer="admin@deniscraig.com"

# <API setup>
ENV API_DIR=$STEAM_USER_DIR/api
USER root

RUN apt-get install -y nodejs
RUN ln -s /usr/bin/node /usr/bin/nodejs

COPY --chown=steam:steam api $API_DIR
USER steam
# </API setup>

ARG version=1
ENV VERSION $version

# <Game setup>
ENV SOURCEFORTS_DIR=$STEAM_USER_DIR/sourceforts

COPY --chown=steam:steam sourceforts $SOURCEFORTS_DIR
# Override server config
COPY --chown=steam:steam cfg $SOURCEFORTS_DIR/cfg

ENV HOSTNAME="docker-sourceforts"
ENV DEFAULT_MAP="sf_skywalk"
ENV BLOCK_LIMIT=50 
ENV BUILD_LENGTH_LONG=600 
ENV BUILD_LENGTH_SHORT=240 
ENV COMBAT_LENGTH=600

VOLUME $SOURCEFORTS_DIR
# </Game setup>

COPY --chown=steam:steam start.sh start.sh
ENTRYPOINT [ "./start.sh" ]
