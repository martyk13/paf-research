#!/usr/bin/env bash

### Functions ###
createResource() {
    echo "Creating resource"

    az group create --name testResources --location eastus

    az vm create \
        --resource-group testResources \
        --name testVM \
        --image CentOS \
        --admin-username pafuser \
        --generate-ssh-keys

    az vm open-port --port 80 --resource-group testResources --name testVM
}

deleteResource() {
    echo "Deleting resource"
    az group delete --name testResources
}

### MAIN ###
USAGE="USAGE: --create(-c), --delete(-d)"

if [ $# -eq 0 ]; then
    echo $USAGE
fi

# Switch between modes using flags
while [ ! $# -eq 0 ]
do
	case "$1" in
		--create | -c)
			createResource
			exit
			;;
		--delete | -d)
			deleteResource
			exit
			;;
		*)
		    echo $USAGE
		    exit
		    ;;
	esac
	shift
done




