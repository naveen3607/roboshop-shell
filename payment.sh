#Create payment service
cp payment.service /etc/systemd/system/payment.service
#Install python
yum install python36 gcc python3-devel -y
#Add user, create directory, download payment content, install depedencies
useradd roboshop
mkdir /app
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip
cd /app || return
unzip /tmp/payment.zip
cd /app || return
pip3.6 install -r requirements.txt
#Enable & Start the service
systemctl daemon-reload
systemctl enable payment
systemctl restart payment
