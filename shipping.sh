#Create shipping service
cp shipping.service /etc/systemd/system/shipping.service
#Install Maven
yum install maven -y
#Add user, create directory, download shipping content, install dependencies
useradd roboshop
mkdir /app
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip
cd /app || return
unzip /tmp/shipping.zip
cd /app || return
mvn clean package
mv target/shipping-1.0.jar shipping.jar
#Install mysql and load the schema
yum install mysql -y
mysql -h <MYSQL-SERVER-IPADDRESS> -uroot -pRoboShop@1 < /app/schema/shipping.sql
#Enable & start the service
systemctl daemon-reload
systemctl enable shipping
systemctl restart shipping
