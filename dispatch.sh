log=/tmp/roboshop.log
#Create service
echo -e "\e[31m>>>>>>>>>>> Creating dispatch service <<<<<<<<<<\e[0m" | tee -a ${log}
cp dispatch.service /etc/systemd/system/dispatch.service &>> ${log}
#Install golang
echo -e "\e[32m>>>>>>>>>>> Installing golang <<<<<<<<<<\e[0m" | tee -a ${log}
yum install golang -y &>> ${log}
#Add user, create directory, download dispatch content and install dependencies
echo -e "\e[33m>>>>>>>>>>> Creating user <<<<<<<<<<\e[0m" | tee -a ${log}
useradd roboshop &>> ${log}
echo -e "\e[34m>>>>>>>>>>> Removing existing directory <<<<<<<<<<\e[0m" | tee -a ${log}
rm -rf /app &>> ${log}
echo -e "\e[35m>>>>>>>>>>> Creating new directory <<<<<<<<<<\e[0m" | tee -a ${log}
mkdir /app &>> ${log}
echo -e "\e[36m>>>>>>>>>>> Downloading dispatch content <<<<<<<<<<\e[0m" | tee -a ${log}
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip &>> ${log}
echo -e "\e[37m>>>>>>>>>>> Extracting dispatch content <<<<<<<<<<\e[0m" | tee -a ${log}
cd /app || return &>> ${log}
unzip /tmp/dispatch.zip &>> ${log}
echo -e "\e[38m>>>>>>>>>>> Installing dependencies <<<<<<<<<<\e[0m" | tee -a ${log}
cd /app || return &>> ${log}
go mod init dispatch &>> ${log}
go get &>> ${log}
go build &>> ${log}
#Enable & Start service
echo -e "\e[39m>>>>>>>>>>> Starting dispatch service <<<<<<<<<<\e[0m" | tee -a ${log}
systemctl daemon-reload &>> ${log}
systemctl enable dispatch &>> ${log}
systemctl restart dispatch &>> ${log}
