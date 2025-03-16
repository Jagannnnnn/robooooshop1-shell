source common.sh

print_head copy Rabbitmq repo file
cp rabbitmq.repo /etc/yum.repos.d/rabbitmq.repo

print_head install rabbitmq server
dnf install rabbitmq-server -y

print_head start rabbitmq service
systemctl enable rabbitmq-server
systemctl start rabbitmq-server

print_head Add application user
rabbitmqctl add_user roboshop roboshop123
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
