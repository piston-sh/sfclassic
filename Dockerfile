FROM cm2network/steamcmd
LABEL maintainer="admin@deniscraig.com"

RUN mkdir -p /home/steam/sourceforts
COPY sourceforts /home/steam/sourceforts
COPY cfg /home/steam/sourceforts/cfg

# Run Steamcmd and install SourceForts
RUN ./home/steam/steamcmd/steamcmd.sh +login anonymous \
        +force_install_dir /home/steam/sourceforts \
        +app_update 232370 validate \
        +app_update 205 validate \
        +app_update 215 validate \
        +quit

RUN { \
		echo '@ShutdownOnFailedCommand 1'; \
		echo '@NoPromptForPassword 1'; \
		echo 'login anonymous'; \
		echo 'force_install_dir /home/steam/sourceforts/'; \
		echo 'app_update 232370'; \
        echo 'app_update 205'; \
        echo 'app_update 215'; \
		echo 'quit'; \
} > /home/steam/sourceforts/sourceforts_update.txt

ENV HOSTNAME="docker-sourceforts"
ENV SRCDS_FPSMAX=300 SRCDS_TICKRATE=128 SRCDS_PORT=27015 SRCDS_TV_PORT=27020 SRCDS_MAXPLAYERS=20 SRCDS_TOKEN=0 SRCDS_RCONPW="changeme" SRCDS_PW="changeme"
ENV BLOCK_LIMIT=50 BUILD_LENGTH_LONG=600 BUILD_LENGTH_SHORT=240 COMBAT_LENGTH=600

VOLUME /home/steam/sourceforts

# Set Entrypoint; Technically 2 steps: 1. Update server, 2. Start server
COPY start.sh start.sh
ENTRYPOINT ./start.sh

# Expose ports
EXPOSE 27015 27020 27005 51840