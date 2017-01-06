#!/usr/bin/env bash

# Until we get proper ordering, delay after starting the database servers
DBDELAY=2

# Slow down startup so can see what's happening easier
STARTDELAY=0

# Setup /var/run, /run and /var/log
/usr/bin/test -d $SNAP_DATA/run || mkdir -p $SNAP_DATA/run
/usr/bin/test -d $SNAP_DATA/var || mkdir -p $SNAP_DATA/var
/usr/bin/test -d $SNAP_DATA/var/log || mkdir -p $SNAP_DATA/var/log
/usr/bin/test -d $SNAP_DATA/var/log/redis || mkdir -p $SNAP_DATA/var/log/redis
/usr/bin/test -L $SNAP_DATA/var/run || ln -s $SNAP_DATA/run $SNAP_DATA/var/run

# Modfiy redis.conf file to work in snap

# The following code is used to modify the log location used by the redis server
# by modifiying redis.conf file: logfile $SNAP_DATA/var/log/redis/redis-server.log
#####sed 's/logfile \/var\/log\/redis\/redis-server.log/logfile $SNAP_DATA\/var\/log\/redis\/redis-server.log/g' $SNAP/etc/redis/redis.conf > $SNAP_DATA/var/run/redis.conf
sed 's/logfile \/var\/log\/redis\/redis-server.log/logfile \/var\/snap\/opx-vm\/x1\/var\/log\/redis\/redis-server.log/g' $SNAP/etc/redis/redis.conf > $SNAP_DATA/var/run/redis.conf
# Create the network namespaces
source $SNAP/usr/bin/opx-env

#
# Appliance / Simulation
#
source $SNAP/usr/bin/opx-sim-env

# Setup OpenSwitch environment variables
source $SNAP/usr/bin/opx-env
echo HACK STARTING: OPX 
#$BINDIR/redis-server $SNAP/etc/redis/redis.conf &
$BINDIR/redis-server $SNAP_DATA/var/run/redis.conf &
$BNDIR/opx_cps_service &
$BNDIR/python  $SNAP/usr/lib/opx/cps_db_stunnel_manager.py
$BNDIR/opx_nas_daemon &
$BNDIR/base_nas_front_panel_ports.sh &
$BNDIR/base-nas-shell.sh &
$BNDIR/base_nas_create_interface.sh &
$BNDIR/base_nas_fanout_init.sh && /usr/bin/network_restart.sh
$BNDIR/base_acl_copp_svc.sh &
$BNDIR/base_nas_default_init.sh &


#$BNDIR/opx_object_library.sh &
#$BNDIR/platform_init.sh
#$BNDIR/opx_pas_service &
#$BNDIR/base_nas_monitor_phy_media.sh &
#$BNDIR/base_nas_phy_media_config.sh &
echo HACK ENDING: OPX

