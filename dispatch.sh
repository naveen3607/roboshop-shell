#Create service
cp dispatch.service /etc/systemd/system/dispatch.service
#Install golang
yum install golang -y
#Add user, create directory, download dispatch content and install dependencies
useradd roboshop
mkdir /app
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip
cd /app || return
unzip /tmp/dispatch.zip
cd /app || return
go mod init dispatch
go get
go build
#Enable & Start service
systemctl daemon-reload
systemctl enable dispatch
systemctl restart dispatch
