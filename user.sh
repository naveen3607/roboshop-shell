#User is a microservice that is responsible for User Logins and Registrations Service in RobotShop e-commerce portal.
#Create user service
echo -e "\e[31m>>>>>>>>>>> Copying user service <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
cp user.service /etc/systemd/system/user.service &>> /tmp/roboshop.log
#Create mongodb repo
echo -e "\e[32m>>>>>>>>>>> Copying mongodb repo <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
cp mongo.repo /etc/yum.repos.d/mongo.repo &>> /tmp/roboshop.log
#Setup NodeJS repo
echo -e "\e[33m>>>>>>>>>>> Creating nodejs repo <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>> /tmp/roboshop.log
#Install NodeJS
echo -e "\e[34m>>>>>>>>>>> Installing nodejs <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
yum install nodejs -y &>> /tmp/roboshop.log
#Add user, create directory, download user content, install dependencies
echo -e "\e[35m>>>>>>>>>>> Creating application user <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
useradd roboshop &>> /tmp/roboshop.log
echo -e "\e[36m>>>>>>>>>>> Removing existing directory <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
rm -rf /app &>> /tmp/roboshop.log
echo -e "\e[31m>>>>>>>>>>> Creating new directory <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
mkdir /app &>> /tmp/roboshop.log
echo -e "\e[32m>>>>>>>>>>> Downloading user content <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip &>> /tmp/roboshop.log
echo -e "\e[33m>>>>>>>>>>> Extracting user content <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
cd /app || return &>> /tmp/roboshop.log
unzip /tmp/user.zip &>> /tmp/roboshop.log
echo -e "\e[34m>>>>>>>>>>> Installing dependencies <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
cd /app || return &>> /tmp/roboshop.log
npm install &>> /tmp/roboshop.log
#Install mongodb
echo -e "\e[35m>>>>>>>>>>> Installing mongodb <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
yum install mongodb-org-shell -y &>> /tmp/roboshop.log
#Load schema
echo -e "\e[36m>>>>>>>>>>> Loading user schema <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
mongo --host mongodb.naveen3607.online </app/schema/user.js &>> /tmp/roboshop.log
#Enable & start the service
echo -e "\e[35m>>>>>>>>>>> Starting user service <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
systemctl daemon-reload &>> /tmp/roboshop.log
systemctl enable user &>> /tmp/roboshop.log
systemctl restart user &>> /tmp/roboshop.log
