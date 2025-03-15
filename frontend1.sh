print_head() {
  echo -e "\e[35m$*\e[0m"
}
print_head Disable default nginx
dnf module disable nginx -y

print_head Enable nginx 24
dnf module enable nginx:1.24 -y

print_head install nginx
dnf install nginx -y

print_head copy nginx config file
cp nginx.conf /etc/nginx/nginx.conf

print_head clean old content
rm -rf /usr/share/nginx/html/*

print_head download app content
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip
cd /usr/share/nginx/html

print_head extract app content
unzip /tmp/frontend.zip
print_head start Nginx service
systemctl enable nginx
systemctl restart nginx
