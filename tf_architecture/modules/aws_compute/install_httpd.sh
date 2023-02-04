#! /bin/bash
sudo yum install -y docker
sudo service docker start
export ECR=570629616813.dkr.ecr.us-east-1.amazonaws.com
export DBECR=570629616813.dkr.ecr.us-east-1.amazonaws.com/database-image-clo835-docker-assignment:latest
export APPECR=570629616813.dkr.ecr.us-east-1.amazonaws.com/app-image-clo835-docker-assignment:latest
aws ecr get-login-password --region us-east-1 |sudo docker login -u AWS ${ECR} --password-stdin   
sudo docker pull $DBECR
sudo docker pull $APPECR
sudo docker run --name mysql-db -d -e MYSQL_ROOT_PASSWORD=pw $DBECR
export DBHOST=$(sudo docker inspect --format '{{ .NetworkSettings.IPAddress }}' mysql-db)
export DBPORT=3306
export DBUSER=root
export DATABASE=employees
export DBPWD=pw
export APP_COLOR=blue
sudo docker run -d --name app1 --link mysql-db -p 8080:8080  -e DBHOST=$DBHOST -e DBPORT=$DBPORT -e  DBUSER=$DBUSER -e DBPWD=$DBPWD $APPECR
export APP_COLOR=green
sudo docker run -d --name app2 -p 8081:8080  -e DBHOST=$DBHOST -e DBPORT=$DBPORT -e  DBUSER=$DBUSER -e DBPWD=$DBPWD $APPECR
export APP_COLOR=pink
sudo docker run -d --name app3 -p 8082:8080  -e DBHOST=$DBHOST -e DBPORT=$DBPORT -e  DBUSER=$DBUSER -e DBPWD=$DBPWD $APPECR

echo "Deployed via Terraform" 