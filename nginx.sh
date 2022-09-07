#!/bin/bash

echo "This script will setup an ssl nginx config for your heliactyl instance!" 

echo "What is the domain your heliactyl instance running on? (eg: client.heliactyl.cloud)"                                                                                                                   
read domain                                                                               

echo "What is the IP address of your server and the port the heliactyl instance is running on (Eg. 192.168.1.1:8192)"
read ipport                                                                                   
                                                                                                                                                                  
echo " server {
    listen 80;
    server_name $domain;
    return 301 https://$server_name$request_uri;
}
server {
    listen 443 ssl http2;
location /afkwspath {
  proxy_http_version 1.1;
  proxy_set_header Upgrade $http_upgrade;
  proxy_set_header Connection "upgrade";
  proxy_pass "http://$ipport/afkwspath";
}
    
    server_name $domain;
ssl_certificate /etc/letsencrypt/live/$domain/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/$domain/privkey.pem;
    ssl_session_cache shared:SSL:10m;
    ssl_protocols SSLv3 TLSv1 TLSv1.1 TLSv1.2;
    ssl_ciphers  HIGH:!aNULL:!MD5;
    ssl_prefer_server_ciphers on;
location / {
      proxy_pass http://$ipport/;
      proxy_buffering off;
      proxy_set_header X-Real-IP $remote_addr;
  }
} " > /etc/nginx/sites-available/heliactyl.conf                                                                                                                   

ln -s /etc/nginx/sites-available/heliactyl.conf /etc/nginx/sites-enabled/heliactyl.conf                                                                           

apt install certbot
apt install python3-certbot-nginx
certbot certonly --nginx -d $domain                                                        

echo "Your reverse proxy for your heliactyl instance is now setup and should be available at https://$domain" 
