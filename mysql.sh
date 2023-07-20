#Disable default MySQL 8 version
yum module disable mysql -y
#Create mysql repo file
cp mysql.repo /etc/yum.repos.d/mysql.repo
#Install MySQL
yum install mysql-community-server -y
#Set the default root password
mysql_secure_installation --set-root-pass RoboShop@1
#Enable & start the service
systemctl enable mysqld
systemctl restart mysqld
