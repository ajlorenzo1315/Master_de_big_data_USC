#!/bin/bash
#Installation and configuration of Checkpoint on Linux

#As explained above, Checkpoint is the exclusive tool available for activating the VPN connection with our facilities. The installation will be carried out with the snx file following the steps explained below:

#1. From the command line of your computer, download the snx file executing: wget http://bigdata.cesga.es/files/snx If the wget command fails, you can download the file from here.

wget http://bigdata.cesga.es/files/snx
chmod +x snx
#Change the permissions of the file to make it executable: chmod a+x snx

#    Install the required dependencies, multiarch must be enable because snx is a i386 binary:

sudo dpkg --add-architecture i386

sudo apt update

sudo apt install libaudit1:i386 libbsd0:i386 libc6:i386 libcap-ng0:i386 libgcc-s1:i386 libpam0g:i386 libstdc++5:i386 libx11-6:i386 libxau6:i386 libxcb1:i386 libxdmcp6:i386

#Once the installation is complete, to start the VPN connection you must execute the following command: 

expect -c "
spawn sudo ./snx -s pasarela.cesga.es -u curso$curso
expect \"Please enter your password:\"
send \"M.B.D{$curso}\r\"
expect \"Do you accept? \[y\]es/ \[N\]o:\"
send \"y\"
expect eof
"