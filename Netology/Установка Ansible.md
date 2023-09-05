## Установка и настройка ansible

### Установка [^1]
- Начинается с обновления пакета
  ```
  sudo apt update
  ```
  ```
  sudo yum update
  ```
- Добравляем репозиторий ppa
  ```
  sudo echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu focal main" >> /etc/apt/sources.list.d/ansible.list
  apt install gnupg
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
  ```
- Устанавливаем пакет
  ```
  sudo apt install ansible
  ```
  ```
  sudo yum install ansible
  ```




[^1]: https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html#installing-ansible-on-debian
