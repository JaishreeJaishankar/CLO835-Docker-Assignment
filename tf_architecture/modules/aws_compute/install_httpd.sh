#! /bin/bash
sudo yum install -y docker
sudo service docker start
export ECR=570629616813.dkr.ecr.us-east-1.amazonaws.com
export DBECR=570629616813.dkr.ecr.us-east-1.amazonaws.com/database-image-clo835-docker-assignment:latest
export APPECR=570629616813.dkr.ecr.us-east-1.amazonaws.com/app-image-clo835-docker-assignment:latest
export DBPORT=3306
export DBUSER=root
export DATABASE=employees
export DBPWD=pw
aws ecr get-login-password --region us-east-1 |sudo docker login -u AWS ${ECR} --password-stdin   
sudo docker pull $DBECR
sudo docker pull $APPECR
sudo docker network create customBridge
sudo docker run --name mysql-db --network=customBridge -d -e MYSQL_ROOT_PASSWORD=pw $DBECR
export DBHOST=$(sudo docker inspect --format '{{ .NetworkSettings.Networks.customBridge.IPAddress }}' mysql-db)
sleep 40
export APP_COLOR=blue
sudo docker run -d --name blue_app -p 8081:8080  --network=customBridge -e APP_COLOR=$APP_COLOR -e DBHOST=$DBHOST -e DBPORT=$DBPORT -e  DBUSER=$DBUSER -e DBPWD=$DBPWD $APPECR
export APP_COLOR=green
sudo docker run -d --name green_app -p 8082:8080  --network=customBridge -e APP_COLOR=$APP_COLOR -e DBHOST=$DBHOST -e DBPORT=$DBPORT -e  DBUSER=$DBUSER -e DBPWD=$DBPWD $APPECR
export APP_COLOR=pink
sudo docker run -d --name pink_app -p 8083:8080  --network=customBridge -e APP_COLOR=$APP_COLOR -e DBHOST=$DBHOST -e DBPORT=$DBPORT -e  DBUSER=$DBUSER -e DBPWD=$DBPWD $APPECR