#Configure yum repos
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash
#Install rabbitmq
yum install rabbitmq-server -y
#Set permissions
rabbitmqctl add_user roboshop roboshop123
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
#Enable & Start the service
systemctl enable rabbitmq-server
systemctl restart rabbitmq-server