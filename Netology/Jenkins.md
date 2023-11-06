## Установка
### Ставим Java
apt update
apt install fontconfig openjdk-17-jre
java -version


### Ставим Jenkins
 wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian/jenkins.io-2023.key
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian binary/ | tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
 apt-get update
 apt-get install jenkins
systemctl enable jenkins
systemctl start jenkins

пароль берем 

cat /var/lib/jenkins/secrets/initialAdminPassword

 http://10.10.20.244:8080/

 Для связки работы с гитом не забываем ставить git на мастер
 ```
 apt install git
 ```
 ### Docker в pipeline
 Итак для того что бы использовать докер в pipeline нужно:
 - Установить docker
 - Добавить пользователя jenkins в группу докер
   ```
   usermod -a -G docker jenkins
   ```
 - Перезапустить службу Jenkins.что бы она смогла интегрироваться с докером)
   ```
   systemctl restart jenkins
   ```
 - 
 
