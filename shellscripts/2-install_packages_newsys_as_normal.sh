#!/bin/bash
# Author: Rahul Kumar Bhadani
echo "alias mv='mv -v'" >> ~/.bashrc
echo "alias rm='rm -v'" >> ~/.bashrc
echo "alias rm -rf='rm -v -rf'" >> ~/.bashrc

echo "#############################################################################################################################"
echo "Installing Scikit learn"
pip install --user -U scikit-learn pip pygccxml

echo "#############################################################################################################################"
echo "Installing Numpy, Scipy, Matplot, iPythpon, Jupyter and pandas"
python -m pip install --user numpy scipy matplotlib ipython jupyter pandas sympy nose

echo "#############################################################################################################################"
echo "Installing Ns-3"
#install ns-3

#all packages will be in Package direcory in the user's home folder
if [ ! -d ~/Packages ]; then
  mkdir -p ~/Packages;
fi

cd ~/Packages

wget https://www.nsnam.org/release/ns-allinone-3.28.tar.bz2

tar -vxjf ns-allinone-3.28.tar.bz2
cd ns-allinone-3.28
./build.py --enable-examples --enable-tests
cd ns-3.28
./waf configure -d debug --enable-examples --enable-tests --enable-sudo
./waf

echo "#############################################################################################################################"
echo "Downloading and installing Omnet++"
if [ ! -d ~/Packages ]; then
  mkdir -p ~/Packages;
fi
cd ~/Packages
git clone https://gitlab.gnome.org/hopemikelson/omnetplusplus-5.4.1 Omnet++5.4.1
cd Omnet++5.4.1
if [ ! -d ./bin ]; then
  mkdir -p ./bin;
fi
#. setenv
echo "export PATH=$HOME/Packages/Omnet++5.4.1/bin:$PATH" >> ~/.bashrc
./configure
make
make install-menu-item
make install-desktop-icon


echo "#############################################################################################################################"
echo "Installing SUMO now ..."
#install Sumo
sudo add-apt-repository ppa:sumo/stable
sudo apt-get update
sudo apt-get install sumo sumo-tools sumo-doc


echo "#############################################################################################################################"
echo "Installing Veins"

if [ ! -d ~/Packages ]; then
  mkdir -p ~/Packages;
fi

cd ~/Packages
git clone https://gitlab.gnome.org/hopemikelson/Veins-4.7.1 Veins-4.7.1



echo "#############################################################################################################################"
echo "#############################################################################################################################"
echo "#############################################################################################################################"
echo "#############################################################################################################################"
echo "Please run following command manually"
echo "cd ~/Packages/Omnet++5.4.1"
echo ". setenv"
