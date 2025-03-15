print_head() {
  echo -e "\e[35m$*\e[0m"
  echo "################################" >> $log_file
  echo -e "\e[35m$*\e[0m" >> $log_file
    echo "################################" >> $log_file

}
log_file=/tmp/robooooshop1.log
rm -f $log_file
print_head Disable default nginx
dnf module disable nginx -y >> $log_file

print_head Enable nginx 24
dnf module enable nginx:1.24 -y >> $log_file
print_head install nginx
dnf install nginx -y >> $log_file

print_head copy nginx config file
cp nginx.conf /etc/nginx/nginx.conf >> $log_file

print_head clean old content
rm -rf /usr/share/nginx/html/* >>  $log_file

print_head download app content
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip >> $log_file
cd /usr/share/nginx/html

print_head extract app content
unzip /tmp/frontend.zip >> $log_file
print_head start Nginx service
systemctl enable nginx >> $log_file
systemctl restart nginx >> $log_file
