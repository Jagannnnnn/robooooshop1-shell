echo -e "\e[35mdisable default nginx\e[0m"
dnf module disable nginx -y

echo -e "\e[35menable nginx 24\e[0m"
dnf module enable nginx:1.24 -y

echo -e "\e[35minstall nginx\e[0m"
dnf install nginx -y

echo -e "\e[35mcopy nginx config file\e[0m"
cp nginx.conf /etc/nginx/nginx.conf

echo -e  "\e[35mclean old content\e[0m"
rm -rf /usr/share/nginx/html/*

echo -e "\e[35mdownload app content\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip
cd /usr/share/nginx/html

echo -e "\e[35mextract app content\e[0m"
unzip /tmp/frontend.zip
echo -e "\e[35mstart Nginx service"\e[0m"
systemctl enable nginx
systemctl restart nginx
