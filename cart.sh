#Cart is a microservice that is responsible for Cart Service in RobotShop e-commerce portal.
#Create cart service
cp cart.service /etc/systemd/system/cart.service
#Setup NodeJS repo
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
#Install NodeJS
yum install nodejs -y
#Add user, create directory, download cart content, install dependencies
useradd roboshop
mkdir /app
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip
cd /app || return
unzip /tmp/cart.zip
cd /app || return
npm install
#Enable & start the service
systemctl daemon-reload
systemctl enable cart
systemctl restart cart