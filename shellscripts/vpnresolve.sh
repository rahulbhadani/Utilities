#!/bin/bash
# Author: Rahul Kumar Bhadani
# Command to correct dns and network system once you exit
# fron CISCO ANYCONNECT VPN
echo 'Restarting network name resolution services ... '
sudo service systemd-resolved restart
echo 'Network name resolution service restarted!'
