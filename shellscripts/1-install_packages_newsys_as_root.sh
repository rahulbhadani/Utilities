#!/bin/bash
# Author: Rahul Kumar Bhadani
##Check root privlige
echo "Checking for root privilege"
if ((EUID !=0 )); then
    echo "Please run this script as root"
    exit 100
fi

echo "Root privilege provided, prceeding ..."

echo "#############################################################################################################################"
echo " ... Installing helpful softwares"
apt-get update
apt-get install subversion git vim libpcap0.8-dev libusb-dev libspnav-dev libbluetooth-dev libcwiid-dev qt4-default libgcrypt20 libgcrypt20-dev valgrind libgsl-dev gsl-bin texlive-full texmaker bleachbit libpangox-1.0-dev libopenscenegraph-dev libosgearth-dev default-jre default-jdk ctags rpm alien dpkg-dev debhelper npm nmap kazam openssh-server -y


echo "#############################################################################################################################"
echo "...Installing ROS"

sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
apt-get update
apt-get install ros-melodic-desktop-full -y
echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
source ~/.bashrc
rosdep init

echo "#############################################################################################################################"
echo "...Installing ROS packages for CAT Vehicle"

apt-get install ros-melodic-controller-manager -y
apt-get install ros-melodic-ros-control ros-melodic-ros-controllers -y
apt-get install ros-melodic-gazebo-ros-control -y
apt-get install ros-melodic-image-transport-* -y
apt-get install ros-melodic-joystick-drivers -y


echo "#############################################################################################################################"
echo "...Installing Google Chrome"

#install Google Chrome
apt-get install libxss1 libappindicator1 libindicator7 -y
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
apt-get update
apt-get install google-chrome-stable -y
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
apt-get update

echo "#############################################################################################################################"
echo "...Installing Visual Studio Code"
#install visual studio code
apt-get install code -y # or code-insiders

echo "...Installing Nodejs"
#install nodejs
curl -sL https://deb.nodesource.com/setup_8.x | -E bash -
apt-get install -y nodejs
apt-get install -y build-essential
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.6.list
apt update

echo "#############################################################################################################################"
echo "...Installing Mongodb"
#install mongodb
apt install -y mongodb-org
systemctl stop mongod.service
systemctl start mongod.service
systemctl enable mongod.service

echo "#############################################################################################################################"
echo "...Installing Python Pip"
#install python pip
apt install python-pip -y

echo "#############################################################################################################################"
echo "...Installing TCL 8.6"
#install tcl
apt-get install tcl8.6 -y

echo "#############################################################################################################################"
echo "...Installing SCTP"
#install Kerne mode SCTP
apt-get install libsctp-dev lksctp-tool -y

echo "#############################################################################################################################"
echo "...Installing libnet Packet filteR"
#install libnet packet filter
apt-get install libnetfilter-queue-dev -y

echo "#############################################################################################################################"
echo "...Installing Bison and Flex for OMNET ++"
#install bison and flex for Omnet++
apt-get install bison flex qt5-default -y

echo "#############################################################################################################################"
echo "...Installing packages required for ns-3"
#packages required for ns-3
apt-get install bzr gsl-bin flex bison tcpdump sqlite3 libsqlite3-dev libxml2 libxml2-dev libgtk2.0-0 libgtk2.0-dev uncrustify doxygen graphviz imagemagick texi2html python-pygraphviz python-kiwi python-pygooglechart libgoocanvas-2.0-dev python-pygccxml -y

apt install python-gi python-gi-cairo python3-gi python3-gi-cairo gir1.2-gtk-3.0 libffi-dev -y

if [ ! -d ~/Packages ]; then
  mkdir -p ~/Packages;
fi

cd ~/Packages
git clone https://gitlab.gnome.org/hopemikelson/ActiveTcl-8.6 ActiveTcl-8.6
cd ActiveTcl-8.6
./install.sh
echo "export PATH='/opt/ActiveTcl-8.6/bin:$PATH'" >> ~/.bashrc
echo "export PATH='/opt/ActiveTcl-8.6/man:$PATH'" >> ~/.bashrc
echo "#############################################################################################################################"
echo "#############################################################################################################################"
echo "#############################################################################################################################"
echo "#############################################################################################################################"
echo "#############################################################################################################################"
echo "#############################################################################################################################"
echo "#############################################################################################################################"
echo "#############################################################################################################################"

echo "Please excute following command as a normal user:"
echo "rosdep update"
