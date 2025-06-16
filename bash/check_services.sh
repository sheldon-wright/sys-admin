#!/bin/bash

LOGFILE="/var/log/service_check.log"
timestamp() { date "+%Y-%m-%d %H:%M:%S"; }

# check if apache2 is running
if ! systemctl is-active --quiet apache2; then
    echo "$(timestamp) apache2 is not running, restarting..." >> "$LOGFILE"
    systemctl restart apache2 >> "$LOGFILE" 2>&1
fi

# check if mysql is running
if ! systemctl is-active --quiet mysql; then
    echo "$(timestamp) mysql is not running, restarting..." >> "$LOGFILE"
    systemctl restart mysql >> "$LOGFILE" 2>&1
fi