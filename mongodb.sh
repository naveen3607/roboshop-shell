#Creating the MongoDB repo
cp mongo.repo /etc/yum.repos.d/mongo.repo
#Install MongoDB
yum install mongodb-org -y
#Update listen address from 127.0.0.1 to 0.0.0.0 in /etc/mongod.conf
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongo.conf
#Enable & Start MongoDB
systemctl enable mongod
systemctl restart mongod
