## Установка и настройка ansible

### Установка [^1]
-------------------------- 
#### Вариант 1.Установка из готового пакета
- Начинается с обновления пакета
  ```
  sudo apt update
  sudo yum update
  ```
- Добавляем репозиторий ppa
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
#### Вариант 2.Установка последней актуальной версии через PIP [^2]

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
  pip3 install ansible
  ```
  >[!WARNING]  
  > Если не запускается команда ansible,то нужно дабавть в переменную PATH путь до установленно ansible.  
  >export PATH="$PATH:/home/$user/.local/bin"  
  >Затем перезапустите вашу оболочку или выполните source ~/.bashrc (или source ~/.bash_profile) для применения изменений.

<br>
<br>
<br>

### Настраиваем Ansible [^3]
---------------------------------------------------- 

- Cоздать файл конфигурации Ansible, в котором перечислены все настройки по умолчанию.
 ``` 
 ansible-config init --disabled > ansible.cfg
 ```

- Создаем файл конфигурации [^4]
  ```
  sudo mkdir /etc/ansible/
  sudo touch /etc/ansible/ansible.cfg
  ansible-config init --disabled -t all > /etc/ansible/ansible.cfg
  ```
- настраиваем если нужно файл конфигурации[^5]
- Создаем файл inventory{ini,json}
  - Пример вида файла inventory.ini 	
	```
	[debian]
	vm2
	vm3
	```
  - Пример вида файла inventory.yml
	```
	all:
    children:
    debian:
      children:
        vm2:
         hosts:
           vm2
        vm3:
          hosts:
           vm3
	```

### Запуск кода Ansible через AD-HOC.Больше примеров по сноске[^6]
--------------------------------------------------------------------------------------------------------
 ```
 ansible debian -i /etc/ansible/inventory.ini -m ping
 ```  
 
- Модули всегда можно посмотреть на оф сайте https://docs.ansible.com/ansible/2.9/modules/list_of_all_modules.html  
	  или тут https://docs.ansible.com/ansible/2.9/modules/modules_by_category.html#modules-by-category

- Для упрощения подключения по имени к машине можно сощдать файл ~/.ssh/config [^7].Пример содержания

```
Host vm2
  HostName 10.10.1.176
  User vagrant
  Port 22
  UserKnownHostsFile /dev/null
  StrictHostKeyChecking no
  PasswordAuthentication no
  IdentityFile /vagrant/private_key2
  IdentitiesOnly yes
  LogLevel FATAL
  PubkeyAcceptedKeyTypes +ssh-rsa
  HostKeyAlgorithms +ssh-rsa
```



=========================================================================================================================
[^1]: https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html#installing-ansible-on-debian
[^2]: https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html#installing-ansible-on-debian
[^3]: 
[^4]: https://docs.ansible.com/ansible/latest/reference_appendices/config.html  
[^5]: https://habr.com/ru/articles/516028/  
[^6]: https://www.middlewareinventory.com/blog/ansible-ad-hoc-commands/
[^7]: https://freehost.com.ua/faq/articles/kak-nastroit-ssh-s-pomoschju--ssh-config/
https://habr.com/ru/companies/jugru/articles/416763/  
https://habr.com/ru/companies/veeam/articles/455604/  
https://tproger.ru/translations/yaml-za-5-minut-sintaksis-i-osnovnye-vozmozhnosti/#part4  
