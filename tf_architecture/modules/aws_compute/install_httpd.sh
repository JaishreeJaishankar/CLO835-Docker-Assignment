#! /bin/bash
sudo yum install -y docker
sudo service docker start
# export DBHOST=$(sudo docker inspect --format '{{ .NetworkSettings.IPAddress }}' my_db)
# echo $DBHOST
# export DBPORT=3306
# export DBUSER=root
# export DATABASE=employees
# export DBPWD=pw
# export APP_COLOR=blue

echo "Deployed via Terraform" 