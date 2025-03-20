systemd_setup() {
  print_head copy systemd service file
  cp $component.service /etc/systemd/system/$component.service  &>> $log_file
  exit_status_print $?

  print_head start service
  systemctl daemon-reload  &>> $log_file
  systemctl enable $component  &>> $log_file
  systemctl restart $component  &>> $log_file
  exit_status_print $?
}

artifact_download(){
  print_head add application user
  id roboshop &>>log_file
  if [ $? -ne 0]; then
  useradd roboshop &>> $log_file
  fi
  exit_status_print $?


  print_head remove existing application code
  rm -rf /app &>> $log_file
  exit_status_print $?

  print_head create application directory
  mkdir /app &>> $log_file
  exit_status_print $?

  print_head download application content
  curl -L -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component-v3.zip
  echo $?
  cd /app

  print_head extract application content
  unzip /tmp/$component.zip &>> $log_file
  exit_status_print $?

}





nodejs_app_setup(){
  print_head disable nodejs default version
  dnf module disable nodejs -y &>> $log_file
  exit_status_print $?

  print_head enable nodejs 20
  dnf module enable nodejs:20 -y &>> $log_file
  exit_status_print $?

  print_head install nodejs
  dnf install nodejs -y &>> $log_file
  exit_status_print $?


  artifact_download
  cd /app

  print_head install nodejs dependecies
  npm install &>> $log_file
  exit_status_print $?

  systemd_setup

}

maven_app_setup() {
  print_head install maven
 dnf install maven -y &>> $log_file
 artifact_download
 cd /app

 print_head Install maven dependencies
 mvn clean package &>> $log_file
 mv target/$component-1.0.jar $component.jar &>> $log_file

  systemd_setup
}

python_app_setup(){
  print_head install python packages
  dnf install python3 gcc python3-devel -y &>> $log_file



   artifact_download

   cd /app

  print_head install python dependencies
   pip3 install -r requirements.txt &>> $log_file
  systemd_setup
}


print_head() {
  echo -e "\e[35m$*\e[0m"
  echo "#################################" &>> $log_file
  echo -e "\e[35m$*\e[0m" >> $log_file
  echo "#################################" &>> $log_file

}
log_file=/tmp/robooooshop1.log
rm -f $log_file

exit_status_print() {

  if [ $1 -eq 0 ]; then
    echo -e "\e[32m >> SUCCESS\e[0m"
  else
    echo -e "\e[31m >> FAILURE\e[0m"
    exit 1
    fi
}