echo "This script will setup an ssl nginx config for your heliactyl instance!" 

echo "What is the domain your heliactyl instance running on? (eg: client.heliactyl.cloud)"                                                                                                                   
read ccdomain                                                                                                                                                     
                                                                                                                                                                  
echo "What is the IP address of your server and the port the heliactyl instance is running on (Eg. 192.168.1.1:8192)"                                                                                   
read ccip                                                                                                                                                         
                                                                                                                                                                  
echo " server {                                                                                                                                                   
        server_name $ccdomain;                                                                                                                                    
        listen 80;                                                                                                                                                
        listen [::]:80;                                                                                                                                           
        access_log /var/log/nginx/reverse-access.log;                                                                                                             
        error_log /var/log/nginx/reverse-error.log;                                                                                                               
        location / {                                                                                                                                              
                    proxy_pass http://$ccip;                                                                                                                      
  }                                                                                                                                                               
} " > /etc/nginx/sites-available/$ccdomain.conf                                                                                                                   
                                                                                                                                                                  
ln -s /etc/nginx/sites-available/$ccdomain.conf /etc/nginx/sites-enabled/$ccdomain.conf                                                                           
                                                                                                                                                                  
certbot --nginx                                                                                                                                                   
                                                                                                                                                                  
echo "Your reverse proxy is now setup and should be available at https://$ccdomain" 
