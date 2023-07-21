#Frontend is the service to serve the web content over nginx web server.
echo -e "\e[31m>>>>>>>>>>> Installing nginx <<<<<<<<<<\e[0m" tee -a /tmp/roboshop.log
yum install nginx -y &>>/tmp/roboshop.log
echo -e "\e[32m>>>>>>>>>>> configuration file copied <<<<<<<<<<\e[0m" tee -a /tmp/roboshop.log
cp nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf &>>/tmp/roboshop.log
#Remove the default content that web server is serving
echo -e "\e[33m>>>>>>>>>>> Removed existing content <<<<<<<<<<\e[0m" tee -a /tmp/roboshop.log
rm -rf /usr/share/nginx/html/* &>>/tmp/roboshop.log
#Download the frontend content
echo -e "\e[34m>>>>>>>>>>> Downloading frontend content <<<<<<<<<<\e[0m" tee -a /tmp/roboshop.log
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>/tmp/roboshop.log
#Extract the frontend content to web server
echo -e "\e[35m>>>>>>>>>>> Extracting the frontend content <<<<<<<<<<\e[0m" tee -a /tmp/roboshop.log
cd /usr/share/nginx/html || return &>>/tmp/roboshop.log
unzip /tmp/frontend.zip &>>/tmp/roboshop.log
#Start & Enable the nginx service
echo -e "\e[36m>>>>>>>>>>> Started nginx service <<<<<<<<<<\e[0m" tee -a /tmp/roboshop.log
systemctl enable nginx &>>/tmp/roboshop.log
systemctl restart nginx &>>/tmp/roboshop.log