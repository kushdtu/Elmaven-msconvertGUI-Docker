# Installation

#### For MAC
You need to have a installed and running docker environment and be a member of the `docker` group.

1. Download Docker from Docker Store
* Open browser
* Go to this link : https://download.docker.com/mac/stable/Docker.dmg
* Download docker
* Install it as normal *.dmg* file.

Follow this for more information regading the docker installtion documentation : https://store.docker.com/editions/community/docker-ce-desktop-mac

2. Install XQuartz 

* Download XQuartz latest version from this link : https://www.xquartz.org
* Install it as normal *.dmg* file.


3. Setup XQuartz

* Go to preference
[![N|Solid](https://github.com/kushdtu/Elmaven-msconvertGUI-Docker/blob/master/images/xquartz_setup1.png)]

* Open Security tab and allow connections from network clients
[![N|Solid](https://github.com/kushdtu/Elmaven-msconvertGUI-Docker/blob/master/images/xquartz_setup2.png)]

* Logout from your mac and login again.

Done :) 

#### For UBUNTU
Prerequisites
* 64-bit Ubuntu 16.04 server
* Non-root user with sudo privileges Initial Setup Guide for Ubuntu 16.04 explains how to set this up.

First, add the GPG key for the official Docker repository to the system:
```sh
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```
Add the Docker repository to APT sources:
```sh
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
```
Next, update the package database with the Docker packages from the newly added repo:
```sh
sudo apt-get update
```
Make sure you are about to install from the Docker repo instead of the default Ubuntu 16.04 repo:
```sh
apt-cache policy docker-ce
```
Finally, install Docker:
```sh
sudo apt-get install -y docker-ce
```
Docker should now be installed, the daemon started, and the process enabled to start on boot. Check that it's running:
```sh
sudo systemctl status docker
```
Done :) 

# Build

#### FOR Ubuntu

1. Get this repo
```sh
$ git clone https://github.com/kushdtu/Elmaven-msconvertGUI-Docker
$ cd Elmaven-msconvertGUI-Docker
```
2. Create the container image
```sh
$ docker build --rm -t msconvertgui .
```
3. Allow local X11 connections from root
```sh
$ xhost +local:root
```
4. Run the container
```sh
$ docker run --rm -v /tmp/.X11-unix:/tmp/.X11-unix:rw -v $HOME:/data:rw msconvertgui
```
Substitute `$HOME` with the directory holding your data. The directory is mounted at /data in your container, which is accessible as Z:\data in MSConvertGUI.

#### FOR MAC

1. Get this repo
```sh
$ git clone https://github.com/kushdtu/Elmaven-msconvertGUI-Docker
$ cd Elmaven-msconvertGUI-Docker
```
2. Create the container image
```
$ docker build --rm -t msconvertgui .
```
3. Set Display, path and IP
```
$ export DISPLAY=:0
$ ip=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
$ ip=$(ifconfig en1 | grep inet | awk '$1=="inet" {print $2}')
$ xhost $ip
```
4. Run the container
```
$ docker run --rm --name msmac -v /tmp/.X11-unix:/tmp/.X11-unix:rw -v $HOME:/data:rw -e DISPLAY=$ip:0 msconvertgui
```
Substitute `$HOME` with the directory holding your data. The directory is mounted at /data in your container, which is accessible as Z:\data in MSConvertGUI.

# Docker pull and run msconvertGUI

1. Pull msconvertGUI docker images from docker hub.
```sh
$ docker pull kushalgupta/msconvertgui:0.1 
```

2. give executable permission to run_msconvert.sh
```sh
$ chmod +x ./run_msconvert.sh
```

3. Run msconvertGUI 
```sh
$ ./run_msconvert.sh /your/folder/path/that/you/want/to/see/in/msconvert/browser

---------------OR--------------------

$ export DISPLAY=:0
$ ip=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
$ ip=$(ifconfig en1 | grep inet | awk '$1=="inet" {print $2}')
$ xhost $ip
$ docker run --rm --name msmac -v /tmp/.X11-unix:/tmp/.X11-unix:rw -v $HOME:/data:rw -e DISPLAY=$ip:0 kushalgupta/msconvertgui:0.1
```
Substitute `$HOME` with the directory holding your data. The directory is mounted at /data in your container, which is accessible as Z:\data in MSConvertGUI.

# Debugging

* Make sure your docker is up and running.
* If docker command is not executing then use 'sudo' with your command
* Make sure your XQuartz is up and running.
