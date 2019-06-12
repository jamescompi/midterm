#!/bin/bash

pdirs=/home/docker/plex

#initial update
/bin/bash /startup.sh


#download and install docker
    #prerequisite packages for docker
    sudo apt install apt-transport-https ca-certificates curl software-properties-common
    #add the GPG key for the official Docker repository
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    #Add the Docker repository to APT sources
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
    #update the package database
    sudo apt update
    #install from the Docker repo instead of the default Ubuntu repo
    apt-cache policy docker-ce
    #install accual docker
    sudo apt install docker-ce
    
#add ubuntu user as a sudoer for docker
sudo usermod -aG docker $ubuntu

#installing plex docker
    #pull down plex docker
    sudo docker pull linuxserver/plex
	#create the plex docker from linuxserver/plex adding in the music folder as well 
    sudo docker create --name=plex --net=host --restart=always -e VERSION=latest -e PUID=1001 -e PGID=1001 -e TZ=Europe/London -v /home/docker/plex/config:/config -v /home/docker/plex/tvshows:/data/tvshows -v /home/docker/plex/movies:/data/movies -v /home/docker/plex/transcode:/transcode linuxserver/plex -v /home/docker/plex/music:/data/music
    
    #start the plex docker
    sudo docker start plex
    