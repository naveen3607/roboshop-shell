#Frontend is the service to serve the web content over nginx web server.
yum install nginx -y
#nginx reverse proxy configuration
cp nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf
#Remove the default content that web server is serving
rm -rf /usr/share/nginx/html/*
#Download the frontend content
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
#Extract the frontend content to web server
cd /usr/share/nginx/html || return
unzip /tmp/frontend.zip
#Start & Enable the nginx service
systemctl enable nginx
systemctl restart nginx