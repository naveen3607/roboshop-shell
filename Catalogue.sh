#Catalogue is a microservice that is responsible for serving the list of items that displays in roboshop application.
#Create service
cp catalogue.service /etc/systemd/system/catalogue.service
#Create mongoDB repo
cp mongo.repo /etc/yum.repos.d/mongo.repo
#Setup NodeJS repos
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
#Install NodeJS
yum install nodejs -y
#Add application user, setup app directory, download application code, install dependencies
useradd roboshop
mkdir /app
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app || return
unzip /tmp/catalogue.zip
cd /app || return
npm install
#Install mongoDB
yum install mongodb-org-shell -y
#Load mongoDB Schema
mongo --host MONGODB-SERVER-IPADDRESS </app/schema/catalogue.js
#Reload, enable & start the service
systemctl daemon-reload
systemctl enable catalogue
systemctl restart catalogue


