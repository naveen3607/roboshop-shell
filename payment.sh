log=/tmp/roboshop.log
#Create payment service
echo -e "\e[31m>>>>>>>>>>> Creating shipping service <<<<<<<<<<\e[0m" | tee -a ${log}
cp payment.service /etc/systemd/system/payment.service
#Install python
echo -e "\e[32m>>>>>>>>>>> Installing python <<<<<<<<<<\e[0m" | tee -a ${log}
yum install python36 gcc python3-devel -y
#Add user, create directory, download payment content, install dependencies
echo -e "\e[33m>>>>>>>>>>> Creating user <<<<<<<<<<\e[0m" | tee -a ${log}
useradd roboshop
echo -e "\e[34m>>>>>>>>>>> Removing existing directory <<<<<<<<<<\e[0m" | tee -a ${log}
rm -rf /app
echo -e "\e[35m>>>>>>>>>>> Creating new directory <<<<<<<<<<\e[0m" | tee -a ${log}
mkdir /app
echo -e "\e[36m>>>>>>>>>>> Downloading payment content <<<<<<<<<<\e[0m" | tee -a ${log}
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip
echo -e "\e[31m>>>>>>>>>>> Extracting payment content <<<<<<<<<<\e[0m" | tee -a ${log}
cd /app || return
unzip /tmp/payment.zip
echo -e "\e[32m>>>>>>>>>>> Installing dependencies <<<<<<<<<<\e[0m" | tee -a ${log}
cd /app || return
pip3.6 install -r requirements.txt
#Enable & Start the service
echo -e "\e[33m>>>>>>>>>>> Starting payment service <<<<<<<<<<\e[0m" | tee -a ${log}
systemctl daemon-reload
systemctl enable payment
systemctl restart payment
