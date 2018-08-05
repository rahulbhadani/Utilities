#!/bin/bash
# Author: Rahul Kumar Bhadani
git config --global credential.helper store
echo "export ROS_MASTER_URI=http://$HOSTNAME.local:11311" >> ~/.bashrc
echo "export ROS_HOSTNAME=$HOSTNAME.local" >> ~/.bashrc

if [ ! -d ~/VersionControl ]; then
  mkdir -p ~/VersionControl;
fi

cd VersionControl

if [ ! -d ./catvehicle_ws ]; then
  mkdir -p ./catvehicle_ws/src;
fi

cd ./catvehicle_ws/src
git clone http://gitlab.engr.arizona.edu/CatvehicleTestBed/obstaclestopper.git
git clone http://gitlab.engr.arizona.edu/CatvehicleTestBed/sicktoolbox.git
git clone http://gitlab.engr.arizona.edu/CatvehicleTestBed/sicktoolbox_wrapper.git
git clone http://gitlab.engr.arizona.edu/CatvehicleTestBed/novatel_span_driver.git
git clone http://gitlab.engr.arizona.edu/CatvehicleTestBed/velodyne.git
git clone http://gitlab.engr.arizona.edu/CatvehicleTestBed/catvehiclecameras.git
git clone http://gitlab.engr.arizona.edu/CatvehicleTestBed/odometryadaptor.git
git clone http://gitlab.engr.arizona.edu/CatvehicleTestBed/catvehicle_simulink.git
git clone http://gitlab.engr.arizona.edu/CatvehicleTestBed/deadreckoning.git
git clone http://gitlab.engr.arizona.edu/CatvehicleTestBed/point_cloud_converter.git
git clone http://gitlab.engr.arizona.edu/CatvehicleTestBed/catvehiclehwil.git
git clone http://gitlab.engr.arizona.edu/CatvehicleTestBed/stepvel.git
git clone http://gitlab.engr.arizona.edu/CatvehicleTestBed/hoffmansubsystem.git
git clone http://gitlab.engr.arizona.edu/CatvehicleTestBed/cmdvel2gazebo.git
git clone  -b melodic_gazebo-9 http://gitlab.engr.arizona.edu/CatvehicleTestBed/catvehicle.git
gitclone http://gitlab.engr.arizona.edu/CatvehicleTestBed/pointgrey_camera_driver.git

cd ..
catkin_make
#git clone https://git.engr.arizona.edu/CatvehicleTestBed/joystick_drivers
echo "source ~/VersionControl/catvehicle_ws/devel/setup.bash" >> ~/.bashrc
source ~/.bashrc
