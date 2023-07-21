#Disable default MySQL 8 version
echo -e "\e[31m>>>>>>>>>>> Disable default mysql service <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
yum module disable mysql -y
#Create mysql repo file
echo -e "\e[32m>>>>>>>>>>> Copying mysql repo <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
cp mysql.repo /etc/yum.repos.d/mysql.repo
#Install MySQL
echo -e "\e[33m>>>>>>>>>>> Installing mysql <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
yum install mysql-community-server -y
#Set the default root password
echo -e "\e[34m>>>>>>>>>>> Setting root password <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
mysql_secure_installation --set-root-pass RoboShop@1
#Enable & start the service
echo -e "\e[35m>>>>>>>>>>> Starting mysql service <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
systemctl enable mysqld
systemctl restart mysqld
