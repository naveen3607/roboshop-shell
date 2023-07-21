#Catalogue is a microservice that is responsible for serving the list of items that displays in Roboshop application.
#Create service
echo -e "\e[31m>>>>>>>>>>> Copied catalogue service <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
cp catalogue.service /etc/systemd/system/catalogue.service &>>/tmp/roboshop.log
#Create mongoDB repo
echo -e "\e[31m>>>>>>>>>>> Copied mongodb repo <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
cp mongo.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log
#Setup NodeJS repos
echo -e "\e[31m>>>>>>>>>>> Setup nodejs repo <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log
#Install NodeJS
echo -e "\e[31m>>>>>>>>>>> Installing nodejs <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
yum install nodejs -y &>>/tmp/roboshop.log
#Add application user, setup app directory, download application code, install dependencies
echo -e "\e[31m>>>>>>>>>>> Create application user <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
useradd roboshop &>>/tmp/roboshop.log
echo -e "\e[31m>>>>>>>>>>> Removed existing directory <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
rm -rf /app &>>/tmp/roboshop.log
echo -e "\e[31m>>>>>>>>>>> Created directory <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
mkdir /app &>>/tmp/roboshop.log
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>/tmp/roboshop.log
echo -e "\e[31m>>>>>>>>>>> Extracting catalogue content <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
cd /app || return &>>/tmp/roboshop.log
unzip /tmp/catalogue.zip &>>/tmp/roboshop.log
echo -e "\e[31m>>>>>>>>>>> Installing Dependencies <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
cd /app || return &>>/tmp/roboshop.log
npm install &>>/tmp/roboshop.log
#Install mongoDB
echo -e "\e[31m>>>>>>>>>>> Installing mongodb <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
yum install mongodb-org-shell -y &>>/tmp/roboshop.log
#Load mongoDB Schema
echo -e "\e[31m>>>>>>>>>>> Loading schema <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
mongo --host mongodb.naveen3607.online </app/schema/catalogue.js &>>/tmp/roboshop.log
#Reload, enable & start the service
echo -e "\e[31m>>>>>>>>>>> Starting catalogue service <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable catalogue &>>/tmp/roboshop.log
systemctl restart catalogue &>>/tmp/roboshop.log


