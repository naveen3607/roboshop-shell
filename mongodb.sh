#Creating the MongoDB repo
echo -e "\e[31m>>>>>>>>>>> Copied mongodb repo <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
cp mongo.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log
#Install MongoDB
echo -e "\e[32m>>>>>>>>>>> Installing mongodb <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
yum install mongodb-org -y &>>/tmp/roboshop.log
#Update listen address from 127.0.0.1 to 0.0.0.0 in /etc/mongod.conf
echo -e "\e[33m>>>>>>>>>>> Updating ip in configuration file <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>/tmp/roboshop.log
#Enable & Start MongoDB
echo -e "\e[34m>>>>>>>>>>> Starting mongodb service <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
systemctl enable mongod &>>/tmp/roboshop.log
systemctl restart mongod &>>/tmp/roboshop.log
