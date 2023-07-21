#Redis is used for in-memory data storage(Caching) and allows users to access the data of database over API
#Install Redis
echo -e "\e[31m>>>>>>>>>>> Creating redis repo <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>> /tmp/roboshop.log
#Enable redis module
echo -e "\e[32m>>>>>>>>>>> Enabling redis module <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
yum module enable redis:remi-6.2 -y &>> /tmp/roboshop.log
#Install redis
echo -e "\e[33m>>>>>>>>>>> Installing redis <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
yum install redis -y &>> /tmp/roboshop.log
#Update listen address from 127.0.0.1 to 0.0.0.0 in /etc/redis.conf
echo -e "\e[34m>>>>>>>>>>> Update ip in configuration file <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
sed -i 's/127.0.0.1/0.0.0.0/' /etc/redis.conf /etc/redis/redis.conf &>> /tmp/roboshop.log
#Enable & start the service
echo -e "\e[35m>>>>>>>>>>> Starting redis service <<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
systemctl enable redis &>> /tmp/roboshop.log
systemctl restart redis &>> /tmp/roboshop.log
