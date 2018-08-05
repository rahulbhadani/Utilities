#!/bin/bash
# Author: Rahul Kumar Bhadani
git config --global credential.helper store
if [ ! -d ~/VersionControl ]; then
  mkdir -p ~/VersionControl;
fi

cd VersionControl
svn co https://svn.engr.arizona.edu/svn/jms/ros15 ros15
if [ ! -d ./Jmsgroup/trunk/ ]; then
  mkdir -p ./Jmsgroup/trunk;
fi

cd Jmsgroup/trunk
svn co https://svn.engr.arizona.edu/svn/jms/jmsgroup/trunk/rahulbhadani rahulbhadani
