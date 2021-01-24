##Rancher Kubernetes using Contrail SDN as the CNI Deployed into AWS 

This automated stack creates:
				A bastion host for controlled access
				A Rancher build node running in kubernetes+helm
				An RKE1 cluster of three nodes master+worker+worker, built by the Rancher build node

Configure you AWS cli
```
	export AWS_PROFILE="your profile name for eu-west"
	or
	aws configure
```
deploy the CloudFormation stack (this uses my s3 bucket rancher-cocntrail, this is the fastest way to start. It takes 15 minutes to deploy and build.
```
	./rancher-rke1.sh 
```
Note: You can also create your own s3 bucket with ./push-to-s3.sh and it will push the deployer files up to it for you. 

How to ssh into a node via the bastion

The CloudFormation stack outputs and the script output will give you commands to use on completion. 

Examples Follow:

#To connect to any node in the cluster via the bastion

```
#this command sets up the nat in the bastion through to the node and can be reran on a different node
ssh -i [your private ssh key file] ubuntu@[bastion host public ip address] sudo /usr/bin/add-nat.sh -n [node private ip address]
#this command will ssh into the node
ssh -i [your private ssh key file] ubuntu@[bastion host public ip address] -p 222 
sudo bash
#this command will allow you to switch between kubernetes contexts, the rke1 build node and the actual kubernetes+contrail cluster, both are kubernetes. 
switch
#then treate it like any other kubernetes cluster
kubectl get nodes -A -o wide
kubectl get pods -A -o wide
#I've put some test stripts in /root/Testing-k8s
```

#the config files for the Rancher build node are in /root
#the config files for the rke1 cluster integrated into contrail are in /root/cluster1

example: connect to the rancher buildnode (it uses a fixed ip address)
``` 
		ssh -i ~/Downloads/ContrailKey-ireland.pem ubuntu@54.220.153.75 sudo /usr/bin/add-nat.sh -n 100.72.100.11 
		ssh -i ~/Downloads/ContrailKey-ireland.pem ubuntu@54.220.153.75 -p 222
		kubectl get nodes
		switch
		1
		kubectl get nodes
```
#UI Access
The racher cli is also assessible via the bastion on port 443. You need to either use a read dns name (see parameter RancherHostName which default to ranchernode.ranchercluster.com)
Or use a fake name and add an entry to your /etc/hosts 
example:
```
54.229.135.100 ranchernode.ranchercluster.com #the ip is the bastion host public ip
```

The contrail cli is also assessible if you run the add-nat.sh towards the master node, then https://[bastion public ip]:8143

#Other hints
#You can override almost anything in the root stack parameters.
#when you are finished just delete the root stack in the aws console, or run ./delete.sh
#if you want to deploy into an existing VPC you can use just the rancher-nodes-rke1.stack and specify the id*** parameters manualy. 
#I've also included rke2 scripts and stacks. These are a work in progress, however contrail does come up and pods get an overlay ip address.
