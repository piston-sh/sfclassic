FROM sourceforts/steamcmd
LABEL maintainer="admin@deniscraig.com"

ARG steam_username 
ARG steam_password

# Run Steamcmd and install dependencies
# - 244310      Source SDK Base 2013 Dedicated Server
# - 243750      Source SDK Base 2013 Multiplayer
RUN steamcmd.sh +login $steam_username $steam_password \
        +force_install_dir $STEAM_HOME_DIR \
        +app_update 244310 validate \
        +app_update 243750 validate \
        +quit

ENV HOSTNAME="docker-source-dedicated-server"
ENV SRCDS_FPSMAX=300 SRCDS_TICKRATE=128 SRCDS_PORT=27015 SRCDS_TV_PORT=27020 SRCDS_MAXPLAYERS=20 SRCDS_TOKEN=0 SRCDS_RCONPW="changeme" SRCDS_PW="changeme"

# Expose ports
EXPOSE 27005/udp
EXPOSE 27015/tcp
EXPOSE 27015/udp
EXPOSE 27020/udp
EXPOSE 26900/udp
EXPOSE 51840/udp