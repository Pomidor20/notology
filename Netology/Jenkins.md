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

 Для связки рабы с гитом не забываем ставить git на мастер
 ```
 apt install git
 ```
