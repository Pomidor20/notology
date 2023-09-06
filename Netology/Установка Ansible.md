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
    apt install python3-pip    
    ```
- Ставим ansible
  ```
  pip3 install python
  ```
  >[!WARNING]  
  > Если не запускается команда ansible,то нужно дабавть в переменную PATH путь до установленно ansible. 
  >export PATH="$PATH:/home/vagrant/.local/bin"
  >Затем перезапустите вашу оболочку или выполните source ~/.bashrc (или source ~/.bash_profile) для применения изменений.






- Создаем файл конфигурации [^3]
  ```
  
  ```

[^1]: https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html#installing-ansible-on-debian
[^2]:
[^3]: https://docs.ansible.com/ansible/latest/reference_appendices/config.html
https://habr.com/ru/companies/jugru/articles/416763/
https://habr.com/ru/companies/veeam/articles/455604/
https://tproger.ru/translations/yaml-za-5-minut-sintaksis-i-osnovnye-vozmozhnosti/#part4
