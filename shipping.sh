component=shipping
 source common.sh

maven_app_setup

print_head install mysql client
dnf install mysql -y &>> $log_file

for file in schema app-user master-data; do
print_head load schema $file
mysql -h mysql-dev.jdevops18.online -uroot -pRoboShop@1 < /app/db/$file.sql &>> $log_file
done



