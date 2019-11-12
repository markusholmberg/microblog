conf_filename="<conf_filename>"
domain="<domain>s"
well_known_path="<.well-known-path>"

cat scripts/deploy-app/resources/nginx.conf | sed "s/<domain>/$domain/; s|<.well-known-path>|$well_known_path|" > /etc/nginx/sites-available/$conf_filename

$(cd /etc/nginx/sites-enabled && sudo ln -s /etc/nginx/sites-available/$conf_filename)

sudo nginx -t && sudo service nginx restart



# https
echo "deb http://deb.debian.org/debian stretch-backports main" >> /etc/apt/sources.list
echo "deb http://deb.debian.org/debian stretch-backports main contrib non-free" >> /etc/apt/sources.list

sudo apt-get update
sudo apt-get install -y python-certbot-nginx -t stretch-backports

sudo certbot --nginx # need manuell input

cat scripts/deploy-app/resources/nginx_https.conf | sed "s/<domain>/$domain/; s|<.well-known-path>|$well_known_path|" > /etc/nginx/sites-available/$conf_filename

sudo nginx -t && sudo service nginx restart
