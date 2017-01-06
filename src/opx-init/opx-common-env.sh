#!/bin/bash

#
# SONiC Common Environment Settings
#

# Syslog settings
LOGSYSLOG="SYSLOG"
LOGCONSOLE="CONSOLE"
LOGLVLDBG="DBG"
LOGLVLINFO="INFO"
LOGLVLERR="ERR"
SYSLOGDBG="-v${LOGSYSLOG}:${LOGLVLDBG}"
SYSLOGINFO="-v${LOGSYSLOG}:${LOGLVLINFO}"
SYSLOGERR="-v${LOGSYSLOG}:${LOGLVLERR}"
CONSDBG="-v${LOGCONSOLE}:${LOGLVLDBG}"
CONSINFO="-v${LOGCONSOLE}:${LOGLVLINFO}"
CONSERR="-v${LOGCONSOLE}:${LOGLVLERR}"
LOGDEFAULT=${SYSLOGINFO}

# Required directories
PASSWDDIR=$SNAP_DATA/var/run/ops-passwd-srv
CFGDIR=$SNAP_DATA/etc/opx

# Override the default install_path and data_path in SONiC
export OPX_INSTALL_PATH=$SNAP
export OPX_DATA_PATH=$SNAP_DATA
export PATH=/snap/opx-appliance/x1/bin:/snap/opx-appliance/x1/usr/bin:$PATH

# LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu / PYTHONPATH=/usr/lib/sonic:/usr/lib/x86_64-linux-gnu/sonic
#export LD_LIBRARY_PATH= $SNAP/usr/lib/x86_64-linux-gnu ./snap/sonic-vm/x1/lib/libsonic_logging.so.1
export LD_LIBRARY_PATH=$SNAP/lib:$SNAP/usr/lib/x86_64-linux-gnu
export PYTHONPATH=$SNAP/usr/lib/opx:$SNAP/lib/opx
