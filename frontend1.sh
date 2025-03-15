print_head() {
  echo -e "\e[35m$*\e[0m"
}
print_head Disable default nginx
dnf module disable nginx -y >/tmp/robooooshop1.log

print_head Enable nginx 24
dnf module enable nginx:1.24 -y >/tmp/robooooshop1.log

print_head install nginx
dnf install nginx -y >/tmp/robooooshop1.log

print_head copy nginx config file
cp nginx.conf /etc/nginx/nginx.conf >/tmp/robooooshop1.log

print_head clean old content
rm -rf /usr/share/nginx/html/* >/tmp/robooooshop1.log

print_head download app content
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip >/tmp/robooooshop1.log
cd /usr/share/nginx/html

print_head extract app content
unzip /tmp/frontend.zip >/tmp/robooooshop1.log
print_head start Nginx service
systemctl enable nginx >/tmp/robooooshop1.log
systemctl restart nginx >/tmp/robooooshop1.log
