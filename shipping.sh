log=/tmp/roboshop.log
#Create shipping service
echo -e "\e[31m>>>>>>>>>>> Creating shipping service <<<<<<<<<<\e[0m" | tee -a ${log}
cp shipping.service /etc/systemd/system/shipping.service &>> ${log}
#Install Maven
echo -e "\e[32m>>>>>>>>>>> Installing maven <<<<<<<<<<\e[0m" | tee -a ${log}
yum install maven -y &>> ${log}
#Add user, create directory, download shipping content, install dependencies
echo -e "\e[33m>>>>>>>>>>> Creating user <<<<<<<<<<\e[0m" | tee -a ${log}
useradd roboshop &>> ${log}
echo -e "\e[34m>>>>>>>>>>> Removing existing directory <<<<<<<<<<\e[0m" | tee -a ${log}
rm -rf /app &>> ${log}
echo -e "\e[35m>>>>>>>>>>> Creating new directory <<<<<<<<<<\e[0m" | tee -a ${log}
mkdir /app &>> ${log}
echo -e "\e[36m>>>>>>>>>>> Downloading shipping content <<<<<<<<<<\e[0m" | tee -a ${log}
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip &>> ${log}
echo -e "\e[37m>>>>>>>>>>> Extracting shipping content <<<<<<<<<<\e[0m" | tee -a ${log}
cd /app || return &>> ${log}
unzip /tmp/shipping.zip &>> ${log}
echo -e "\e[38m>>>>>>>>>>> Installing dependencies <<<<<<<<<<\e[0m" | tee -a ${log}
cd /app || return &>> ${log}
mvn clean package &>> ${log}
mv target/shipping-1.0.jar shipping.jar &>> ${log}
#Install mysql and load the schema
echo -e "\e[39m>>>>>>>>>>> Installing mysql <<<<<<<<<<\e[0m" | tee -a ${log}
yum install mysql -y &>> ${log}
echo -e "\e[31m>>>>>>>>>>> Loading schema <<<<<<<<<<\e[0m" | tee -a ${log}
mysql -h mysql.naveen3607.online -uroot -pRoboShop@1 < /app/schema/shipping.sql &>> ${log}
#Enable & start the service
echo -e "\e[32m>>>>>>>>>>> Staring shipping service <<<<<<<<<<\e[0m" | tee -a ${log}
systemctl daemon-reload &>> ${log}
systemctl enable shipping &>> ${log}
systemctl restart shipping &>> ${log}
