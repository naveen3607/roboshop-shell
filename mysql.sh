#Disable default MySQL 8 version
echo -e "\e[31m>>>>>>>>>>> Disable default mysql service <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
yum module disable mysql -y &>> /tmp/roboshop.log
#Create mysql repo file
echo -e "\e[32m>>>>>>>>>>> Copying mysql repo <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
cp mysql.repo /etc/yum.repos.d/mysql.repo &>> /tmp/roboshop.log
#Install MySQL
echo -e "\e[33m>>>>>>>>>>> Installing mysql <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
yum install mysql-community-server -y &>> /tmp/roboshop.log
#Set the default root password
echo -e "\e[34m>>>>>>>>>>> Setting root password <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
mysql_secure_installation --set-root-pass RoboShop@1 &>> /tmp/roboshop.log
#Enable & start the service
echo -e "\e[35m>>>>>>>>>>> Starting mysql service <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
systemctl enable mysqld &>> /tmp/roboshop.log
systemctl restart mysqld &>> /tmp/roboshop.log
