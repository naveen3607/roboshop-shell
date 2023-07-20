#Redis is used for in-memory data storage(Caching) and allows users to access the data of database over API
#Install Redis
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y
#Enable redis module
yum module enable redis:remi-6.2 -y
#Install redis
yum install redis -y
#Update listen address from 127.0.0.1 to 0.0.0.0 in /etc/redis.conf
#Enable & start the service
systemctl enable redis
systemctl restart redis
