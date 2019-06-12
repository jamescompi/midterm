#!/bin/bash

hostip=`curl http://icanhazip.com`
COUNTER=120

#make a file to hold json information
touch instance.txt

#make a key pair and add to a variable (only needed one time)
mykey=`aws ec2 describe-key-pair --key-name MyKeyPair`

#open ports on security group only needed one time
aws ec2 authorize-security-group-ingress --group-id sg-0aa797ae5847b24fc --protocol tcp --port 22 --cidr $hostip/32
aws ec2 authorize-security-group-ingress --group-id sg-0aa797ae5847b24fc --protocol tcp --port 80 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-id sg-0aa797ae5847b24fc --protocol tcp --port 8080 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-id sg-0aa797ae5847b24fc --protocol tcp --port 32400 --cidr 0.0.0.0/0

#launch instance and add ouptut to variable 
aws ec2 run-instances --image-id ami-024a64a6685d05041 --count 1 --instance-type t2.micro --key-name MyKeyPair --security-group-ids sg-0aa797ae5847b24fc --subnet-id subnet-07960c4452bcb4960 > instance.txt 

# 
#pull instance id from instance.txt
inid=`cat instance.txt | jq -r .Instances[].InstanceId`

#wait for vm to spin up
for ((i=COUNTER; i>=1; i--))
do sleep 1
    echo $i
done

#get public ip from instance id
inip=`aws ec2 describe-instances --instance-ids $inid | jq -r .Reservations[].Instances[].PublicIpAddress`

#testing
#echo $inip

#ssh into freshly spun up server
ssh -i $mykey root@$inip

#'MyKeyPair.pem'