#Catalogue is a microservice that is responsible for serving the list of items that displays in Roboshop application.
#Create service
echo -e "\e[31m>>>>>>>>>>> Copied catalogue service <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
cp catalogue.service /etc/systemd/system/catalogue.service
#Create mongoDB repo
echo -e "\e[31m>>>>>>>>>>> Copied mongodb repo <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
cp mongo.repo /etc/yum.repos.d/mongo.repo
#Setup NodeJS repos
echo -e "\e[31m>>>>>>>>>>> Setup nodejs repo <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
#Install NodeJS
echo -e "\e[31m>>>>>>>>>>> Installing nodejs <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
yum install nodejs -y
#Add application user, setup app directory, download application code, install dependencies
echo -e "\e[31m>>>>>>>>>>> Create application user <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
useradd roboshop
echo -e "\e[31m>>>>>>>>>>> Removed existing directory <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
rm -rf /app
echo -e "\e[31m>>>>>>>>>>> Created directory <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
mkdir /app
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
echo -e "\e[31m>>>>>>>>>>> Extracting catalogue content <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
cd /app || return
unzip /tmp/catalogue.zip
echo -e "\e[31m>>>>>>>>>>> Installing Dependencies <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
cd /app || return
npm install
#Install mongoDB
echo -e "\e[31m>>>>>>>>>>> Installing mongodb <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
yum install mongodb-org-shell -y
#Load mongoDB Schema
echo -e "\e[31m>>>>>>>>>>> Loading schema <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
mongo --host mongodb.naveen3607.online </app/schema/catalogue.js
#Reload, enable & start the service
echo -e "\e[31m>>>>>>>>>>> Starting catalogue service <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
systemctl daemon-reload
systemctl enable catalogue
systemctl restart catalogue


