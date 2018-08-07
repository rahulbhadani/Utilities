#!/bin/bash
# Author: Rahul Kumar Bhadani
# This bash script checks if port 11311 is open the host $remote host
#If 11311 port of $remote host is down, unreachable for some reason,
# a beep will sound

while [ 1 ]
do
#Get the output of nmap -p 11311 with grep to 11311
    nmapOutput="$(nmap -p 11311 150.135.222.52 -Pn | grep 11311)"
#Split the output string by space splitter
    stringSplit=(${nmapOutput// / })
#Get the status of port 11311
    status=${stringSplit[1]}

#kill the previous BEEP PID and start a new one,
#because if 11311 of remote is reachable again, then beep
#sound should die.
    if [ ! -z ${PID_BEEP} ]; then
        if [ -n "$PID_BEEP" -a -e /proc/$PID_BEEP ]; then
            echo "Killing ${PID_BEEP}"
            kill -9 $PID_BEEP
        fi;

    fi;
    echo "Status of port 11311 is ${status}"
    if [ "$status" != "open" ]; then
        echo "ROS MASTER Unreachable"
        #Make sound because ROS MASTER is not reachable now.
        speaker-test -t sine -f 1000 -l 1 &
        PID_BEEP=$!
        echo "${PID_BEEP}"
        # Make some sound here
    fi;
    
done
