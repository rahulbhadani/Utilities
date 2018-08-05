#!/bin/bash
# Author: Rahul Kumar Bhadani
git config --global credential.helper store
if [ ! -d ~/VersionControl ]; then
  mkdir -p ~/VersionControl;
fi

cd VersionControl
git clone https://git.engr.arizona.edu/rahulbhadani/research Research
git clone https://git.engr.arizona.edu/rahulbhadani/WorldCreator WorldCreator
git clone https://git.engr.arizona.edu/rahulbhadani/TrafficFlowExperiment TrafficFlowExperiment
git clone https://git.engr.arizona.edu/rahulbhadani/ProjectOrion ProjectOrion
git clone https://git.engr.arizona.edu/rahulbhadani/FSO_V2X FSO_V2X
git clone https://git.engr.arizona.edu/rahulbhadani/ProjectLyra ProjectLyra

mkdir REU2018
cd REU2018
git clone https://git.engr.arizona.edu/REU2018/lane-detectives lane-detectives
git clone https://git.engr.arizona.edu/REU2018/lcbentley
git clone https://git.engr.arizona.edu/REU2018/hgmason
git clone https://git.engr.arizona.edu/REU2018/joemacinnes
