#!/bin/bash

sudo apt-get update
sudo apt-get upgrade -y

#install pip
sudo apt install python3-pip

#install pip
pip3 install awscli --upgrade --user

#install curl so you can pull down information from websites
sudo apt install curl

#second repo update 
sudo apt-get update

#starting the prossess of installing cli
	#installing apt transport https to pull from https websites
	sudo apt-get install curl apt-transport-https lsb-release gnupg
	
	#pulling keys from microsoft.com and adding them to trusted keys 
	curl -sL https://packages.microsoft.com/keys/microsoft.asc | \
		gpg --dearmor | \
		sudo tee /etc/apt/trusted.gpg.d/microsoft.asc.gpg > /dev/null
	
	#adding the cli repository to the sources list 
	AZ_REPO=$(lsb_release -cs)
	echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | \
		sudo tee /etc/apt/sources.list.d/azure-cli.list

#final update before install to insure all repos are up to date
sudo apt-get update

#install azure cli 
sudo apt-get install azure-cli

#if you want it to just go away after install rather than look at all the beautiful matix code 
#or just comment it out to see all the pretty words and colors
clear