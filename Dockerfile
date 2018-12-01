FROM sourceforts/srcds-server
LABEL maintainer="admin@deniscraig.com"

ARG version=1
ENV VERSION $version

ARG game=sourceforts
ENV GAME=sourceforts
ENV HOSTNAME="docker-$game"

ARG default_map=sf_skywalk
ENV DEFAULT_MAP=$default_map

# <API setup>
ENV API_DIR=$STEAM_USER_DIR/api
USER root

RUN apt-get install -y nodejs
RUN ln -s /usr/bin/node /usr/bin/nodejs

COPY --chown=steam:steam api $API_DIR
USER steam
# </API setup>

# <Game setup>
ENV GAME_DIR=$STEAM_USER_DIR/$game

COPY --chown=steam:steam $game $GAME_DIR
# Override server config
COPY --chown=steam:steam cfg $GAME_DIR/cfg

ENV BLOCK_LIMIT=50 
ENV BUILD_LENGTH_LONG=600 
ENV BUILD_LENGTH_SHORT=240 
ENV COMBAT_LENGTH=600

VOLUME $GAME_DIR
# </Game setup>

COPY --chown=steam:steam start.sh start.sh
ENTRYPOINT [ "./start.sh" ]
