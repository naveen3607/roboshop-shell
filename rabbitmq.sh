log=/tmp/roboshop.log
#Configure yum repos
echo -e "\e[31m>>>>>>>>>>> Creating rabbitmq repo <<<<<<<<<<\e[0m" | tee -a ${log}
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>> ${log}
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>> ${log}
#Install rabbitmq
echo -e "\e[32m>>>>>>>>>>> Installing rabbitmq <<<<<<<<<<\e[0m" | tee -a ${log}
yum install rabbitmq-server -y &>> ${log}
#Set permissions
echo -e "\e[33m>>>>>>>>>>> Setup permissions <<<<<<<<<<\e[0m" | tee -a ${log}
rabbitmqctl add_user roboshop roboshop123 &>> ${log}
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>> ${log}
#Enable & Start the service
echo -e "\e[31m>>>>>>>>>>> Starting rabbitmq service <<<<<<<<<<\e[0m" | tee -a ${log}
systemctl enable rabbitmq-server &>> ${log}
systemctl restart rabbitmq-server &>> ${log}
