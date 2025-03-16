source common.sh


print_head install mysql server
dnf install mysql-server -y &>> $log_file

print_head start mysql service
systemctl enable mysqld &>> $log_file
systemctl start mysqld &>> $log_file

print_head setup root password
mysql_secure_installation --set-root-pass RoboShop@1 &>> $log_file