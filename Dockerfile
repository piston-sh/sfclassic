FROM sourceforts/dedicated-server:debian-gdb
LABEL maintainer="admin@deniscraig.com"

ENV SOURCEFORTS_DIR=$STEAM_HOME_DIR/sourceforts

COPY --chown=steam:steam sourceforts $SOURCEFORTS_DIR
# Override server config
COPY --chown=steam:steam cfg $SOURCEFORTS_DIR/cfg

# We need to be user to make the init script executable
USER root
COPY init.d/sourceforts.sh /etc/init.d/sourceforts.sh
RUN chmod +x /etc/init.d/sourceforts.sh
RUN touch $STEAM_HOME_DIR/Steam/logs/daemon.log && chown steam:steam $STEAM_HOME_DIR/Steam/logs/daemon.log

# Steam users needs somewhere to create pidfiles
RUN mkdir -p /var/run/sourceforts && chown steam:steam /var/run/sourceforts
USER steam

ENV HOSTNAME="docker-sourceforts"
ENV DEFAULT_MAP="sf_skywalk"
ENV BLOCK_LIMIT=50 
ENV BUILD_LENGTH_LONG=600 
ENV BUILD_LENGTH_SHORT=240 
ENV COMBAT_LENGTH=600

VOLUME $SOURCEFORTS_DIR
ENTRYPOINT [ "/bin/sh" ]
CMD [ "-c", "\"service sourceforts.sh start && tail -F $STEAM_HOME_DIR/Steam/logs/*\""" ]
