#Creating the MongoDB repo
cp mongo.repo /etc/yum.repos.d/mongo.repo
#Install MongoDB
yum install mongodb-org -y
#Update listen address from 127.0.0.1 to 0.0.0.0 in /etc/mongod.conf
#Enable & Start MongoDB
systemctl enable mongod
systemctl restart mongod
