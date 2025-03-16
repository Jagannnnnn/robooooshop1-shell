component=catalogue
 source common.sh
 print_head copy mongodb repo file
cp mongo.repo /etc/yum.repos.d/mongo.repo  &>> $log_file
nodejs_app_setup

print_head install mongodb
dnf install mongodb-mongosh -y &>> $log_file

print_head load master data
mongosh --host mongo-dev.jdevops18.online </app/db/master-data.js  &>> $log_file

