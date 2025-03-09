dnf install maven -y
useradd roboshop
cp shipping.service /etc/systemd/system/shipping.service
rm -rf /app
mkdir /app
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping-v3.zip
cd /app
unzip /tmp/shipping.zip
cd /app
mvn clean package
mv target/shipping-1.0.jar shipping.jar

dnf install mysql -y

mysql -h mysql-dev.jdevops18.online -uroot -pRoboShop@1 < /app/db/schema.sql
mysql -h mysql-dev.jdevops18.online -uroot -pRoboShop@1 < /app/db/app-user.sql
mysql -h mysql-dev.jdevops18.online -uroot -pRoboShop@1 < /app/db/master-data.sql

systemctl daemon-reload
systemctl enable shipping
systemctl restart shipping

