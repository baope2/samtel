#!/bin/bash

# define variables
APP_PATH=/opt/Despliegues_Automatizados/front-devops
DATE=$(date +'%m-%d-%Y')

#echo "fehca actual: " $DATE
#echo "export path: "  $EXPORT_PATH

# get app version
VERSION=$(cat version.anterior)
echo $VERSION

#Inicio proceso de Despliegue
echo "***** Validando releaseID *****"
echo $VERSION
echo "id imagen despliegue anterior version estable: $VERSION"

#Aplicacion de deploy, para reiniciar el pod al nuevo despliegue
echo "Reiniciando pods"
cd /opt/Manifiestos/front-devops
sed -i "s|image:.*|image: 005198794443.dkr.ecr.us-east-1.amazonaws.com/devsecops:front_devops$VERSION|" /opt/Manifiestos/front-devops/deployment.yml
cd /root/.kube && kubectl --kubeconfig config apply -f /opt/Manifiestos/front-devops
cd /opt/Manifiestos/front-devops && kubectl scale --replicas=0 deploy front-devops -n front-qa
cd /opt/Manifiestos/front-devops && kubectl scale --replicas=1 deploy front-devops -n front-qa
cd /root/.kube && kubectl --kubeconfig config get po -A
sleep 15
cd /root/.kube && kubectl --kubeconfig config get po -A

# increment backup version
cd $APP_PATH
echo $(($VERSION + 1)) > var.version