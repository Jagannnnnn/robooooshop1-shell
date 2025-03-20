component=catalogue
 source common.sh
 print_head copy mongodb repo file
cp mongo.repo /etc/yum.repos.d/mongo.repo  &>> $log_file
  exit_status_print $?

nodejs_app_setup

print_head install mongodb
dnf install mongodb-mongosh -y &>> $log_file
  exit_status_print $?

print_head load master data
mongosh --host mongodb-dev.jdevops18.online </app/db/master-data.js  &>> $log_file
  exit_status_print $?

