## Установка и настройка ansible

### Установка [^1]

#### Установка из готового пакета
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
#### Установка последней актуальной версии через PIP [^2]

- Проверяем текущую версию python и pip
  ```
  python3 -V
  python3 -m pip -V
  ```
  - ставим pip,если в прошлом окне не показал версию pip
    ```
    sudo apt istall curl
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    python3 get-pip.py --user
    
    ```
- Ставим ansible
  ```
  apt install python3-pip
  python3 -m pip install --user ansible
  ```
  








- Создаем файл конфигурации [^3]
  ```
  
  ```

[^1]: https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html#installing-ansible-on-debian
[^2]:
[^3]: https://docs.ansible.com/ansible/latest/reference_appendices/config.html
