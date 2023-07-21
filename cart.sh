#Cart is a microservice that is responsible for Cart Service in RobotShop e-commerce portal.
#Create cart service
echo -e "\e[31m>>>>>>>>>>> Copying cart service <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
cp cart.service /etc/systemd/system/cart.service &>> /tmp/roboshop.log
#Setup NodeJS repo
echo -e "\e[32m>>>>>>>>>>> Creating nodejs repo <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>> /tmp/roboshop.log
#Install NodeJS
echo -e "\e[33m>>>>>>>>>>> Installing nodejs <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
yum install nodejs -y &>> /tmp/roboshop.log
#Add user, create directory, download cart content, install dependencies
echo -e "\e[34m>>>>>>>>>>> Removing existing directory <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
rm -rf /app &>> /tmp/roboshop.log
echo -e "\e[35m>>>>>>>>>>> Creating new user <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
useradd roboshop &>> /tmp/roboshop.log
echo -e "\e[36m>>>>>>>>>>> Creating new directory <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
mkdir /app &>> /tmp/roboshop.log
echo -e "\e[31m>>>>>>>>>>> Downloading cart content <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip &>> /tmp/roboshop.log
echo -e "\e[32m>>>>>>>>>>> Extracting cart content <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
cd /app || return &>> /tmp/roboshop.log
unzip /tmp/cart.zip &>> /tmp/roboshop.log
echo -e "\e[33m>>>>>>>>>>> Installing dependencies <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
cd /app || return &>> /tmp/roboshop.log
npm install &>> /tmp/roboshop.log
#Enable & start the service
echo -e "\e[34m>>>>>>>>>>> Starting cart service <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
systemctl daemon-reload &>> /tmp/roboshop.log
systemctl enable cart &>> /tmp/roboshop.log
systemctl restart cart &>> /tmp/roboshop.log