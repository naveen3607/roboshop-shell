#User is a microservice that is responsible for User Logins and Registrations Service in RobotShop e-commerce portal.
#Create user service
cp user.service /etc/systemd/system/user.service
#Create mongodb repo
cp mongo.repo /etc/yum.repos.d/mongo.repo
#Setup NodeJS repo
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
#Install NodeJS
yum install nodejs -y
#Add user, create directory, download user content, install dependencies
useradd roboshop
mkdir /app
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip
cd /app || return
unzip /tmp/user.zip
cd /app || return
npm install
#Install mongodb
yum install mongodb-org-shell -y
#Load schema
mongo --host mongodb.naveen3607.online </app/schema/user.js
#Enable & start the service
systemctl daemon-reload
systemctl enable user
systemctl restart user
