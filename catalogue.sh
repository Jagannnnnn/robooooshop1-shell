component=cart
 source common.sh
cp mongo.repo /etc/yum.repos.d/mongo.repo
nodejs
dnf install mongodb-mongosh -y
mongosh --host mongo-dev.jdevops18.online </app/db/master-data.js

