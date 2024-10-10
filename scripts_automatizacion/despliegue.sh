#!/bin/bash

# define variables
APP_PATH=/opt/Despliegues_Automatizados/front-devops
DATE=$(date +'%m-%d-%Y')

#echo "fehca actual: " $DATE
#echo "export path: "  $EXPORT_PATH

# get app version
VERSION=$(cat var.version)
echo $VERSION
PREVIUS_ID=$(($VERSION - 1))
echo "$PREVIUS_ID"
echo "$PREVIUS_ID" > version.anterior

#Inicio proceso de Despliegue
echo "***** Validando releaseID *****"
echo $VERSION
echo "id imagen despliegue actual: $VERSION"
echo "id imagen despliegue anterior version estable: $PREVIUS_ID"
echo "Realizar pull sobre la rama QA"
cd /opt/Repositorios/Prueba_jhon && git pull origin QA
cd /opt/Repositorios/Prueba_jhon && git branch

#Creacion de imagen
cd /opt/Repositorios/Prueba_jhon && aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 005198794443.dkr.ecr.us-east-1.amazonaws.com
cd /opt/Repositorios/Prueba_jhon && docker build . -t front_devops:$VERSION
docker tag front_devops:$VERSION 005198794443.dkr.ecr.us-east-1.amazonaws.com/devsecops:front_devops$VERSION
docker push 005198794443.dkr.ecr.us-east-1.amazonaws.com/devsecops:front_devops$VERSION
sleep 15

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