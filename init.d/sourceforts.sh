PATH=/bin:/usr/bin:/sbin:/usr/sbin
DESC="SourceForts Dedicated Server"
NAME=sourceforts
PIDFILE=/var/run/$NAME/$NAME.pid
SCRIPTNAME=/etc/init.d/$NAME

CHDIR=/home/steam
DAEMON=srcds_run

GAME="sourceforts"
SF_ARGS="+sf_team_blocklimit $BLOCK_LIMIT +sf_build_long_length $BUILD_LENGTH_LONG +sf_combat_length $COMBAT_LENGTH"
SRCDS_ARGS="+fps_max $SRCDS_FPSMAX -tickrate $SRCDS_TICKRATE -port $SRCDS_PORT -tv_port $SRCDS_TV_PORT +maxplayers $SRCDS_MAXPLAYERS +rcon_password $SRCDS_RCONPW +sv_password $SRCDS_PW"
EXTRA_ARGS="$SRCDS_ARGS $SF_ARGS"
ARGS="-game $GAME -console -norestart +ip 0.0.0.0 +hostname $HOSTNAME +map $DEFAULT_MAP +exec $SOURCEFORTS_DIR/server.cfg $EXTRA_ARGS"

export MALLOC_CHECK_=0

[ -x "$DAEMON" ] || exit 0

DAEMON_ARGS="-steam_dir $CHDIR -steamcmd_script $CHDIR/steamcmd/steamcmd.sh -pidfile $PIDFILE $ARGS"

. /lib/init/vars.sh
. /lib/lsb/init-functions

do_start() {
    export MALLOC_CHECK_=0
    touch $CHDIR/Steam/logs/daemon.log
    touch $PIDFILE
    chown steam:steam $PIDFILE
    start-stop-daemon --start --quiet --pidfile $PIDFILE --chuid steam:steam --chdir $CHDIR --exec $DAEMON --test >> $CHDIR/Steam/logs/daemon.log 2>&1
    [ "$?" != 0 ] && return 1
    start-stop-daemon --start --pidfile $PIDFILE --background --chuid steam --chdir $CHDIR --exec $DAEMON -- $DAEMON_ARGS >> $CHDIR/Steam/logs/daemon.log 2>&1
    [ "$?" != 0 ] && return 2
}
do_stop() {
    start-stop-daemon --stop --quiet --retry=TERM/30/KILL/5 --pidfile $PIDFILE --user steam >> $CHDIR/Steam/logs/daemon.log 2>&1
    RETVAL="$?"
    [ "$RETVAL" = 2 ] && return 2
    start-stop-daemon --stop --quiet --oknodo --retry=TERM/30/KILL/5 --exec $DAEMON >> $CHDIR/Steam/logs/daemon.log 2>&1
    [ "$?" = 2 ] && return 2
    rm -f $PIDFILE
    return "$RETVAL"
}
case "$1" in
    start)
        echo "Starting $DESC: $NAME" >> $CHDIR/Steam/logs/daemon.log
        [ "$VERBOSE" != no ] && log_daemon_msg "Starting $DESC" "$NAME"
        do_start
        case "$?" in
            0|1) [ "$VERBOSE" != no ] && log_end_msg 0 ;;
            2) [ "$VERBOSE" != no ] && log_end_msg 1 ;;
        esac
        ;;
    stop)
        echo "Starting $DESC: $NAME" >> $CHDIR/Steam/logs/daemon.log
        [ "$VERBOSE" != no ] && log_daemon_msg "Stopping $DESC" "$NAME"
        do_stop
        case "$?" in
            0|1) [ "$VERBOSE" != no ] && log_end_msg 0 ;;
            2) [ "$VERBOSE" != no ] && log_end_msg 1 ;;
        esac
        ;;
    status)
        status_of_proc -p $PIDFILE "$DAEMON" "$NAME" && exit 0 || exit $?
        ;;
    restart)
        log_daemon_msg "Restarting $DESC" "$NAME"
        do_stop
        case "$?" in
            0|1)
                do_start
                case "$?" in
                    0) log_end_msg 0 ;;
                    1) log_end_msg 1 ;;
                    *) log_end_msg 1 ;;
                esac
                ;;
            *)
                log_end_msg 1
                ;;
        esac
        ;;
    *)
        echo "Usage: $SCRIPTNAME {start|stop|restart|status}" >&2
        exit 3
        ;;
esac
exit 0
