# Jenkins
## Pipeline у дженкинса бывает несколько видов
- Freestyle
- Pipeline Job
 - Multibranch Pipeline

### Freestyle Job
Freestyle Job — простейшее описание рутины в виде последовательно выполняемых заданий.
Задача может быть описана удобным способом
Часть заданий можно описать в репозитории
Пишется на любом языке програмирования

### Pipeline Job
Pipeline Job — описание рутины в отдельных файлах с Pipeline на собственном синтаксисе.
Может быть описано в двух видах:
 - Declarative Pipeline
 - Scripted Pipeline

#### Declarative Pipeline 
Declarative Pipeline— верхнеуровневое описание того, чтонеобходимо сделать. Имеет свой собственный синтаксис
и описывается в файлах с именованием Jenkinsfile
Он всегда начинается с pipeline
Пример Dectarative Pipeline:
```
pipe1ine {
 agent апу
 stages {
  stepsstage('Test'){
steps{
```
#### Scripted Pipeline
 Scripted Pipeline— описание стадий конвейера с использованием собственного синтаксиса, но с дополнениями в виде Groovy-скриптов
 Он всегда начинается с node и идут сразу в нутри пайпа его задача

### Multibranch Pipeline
Multibranch Pipeline — вид Pipeline, который умеет запускать 
сборки по действиям в одном репозитории
Умеет разделять виды действий в репозитории
Фильтровать имена branches

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
<<<<<<< HEAD
пароль берем 
cat /var/lib/jenkins/secrets/initialAdminPassword
 http://10.10.20.244:8080/
 
 
 
 
 https://www.jenkins.io/doc/book/pipeline/syntax/#available-options options 
=======

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
