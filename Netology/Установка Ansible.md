## Установка и настройка ansible

### Установка [^1]
-------------------------- 
#### Вариант 1.Установка из готового пакета
- Начинается с обновления пакета
  ```
  sudo apt update
  ```
  ```
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
  - Привем вида файла inventory.yml
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
	 ```
	 ansible debian -i /etc/ansible/inventory.ini -m ping
	 ```

[^1]: https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html#installing-ansible-on-debian
[^2]: https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html#installing-ansible-on-debian
[^3]: 
[^4]: https://docs.ansible.com/ansible/latest/reference_appendices/config.html  
[^5]: https://habr.com/ru/articles/516028/  
[^6]: https://www.middlewareinventory.com/blog/ansible-ad-hoc-commands/   
https://habr.com/ru/companies/jugru/articles/416763/  
https://habr.com/ru/companies/veeam/articles/455604/  
https://tproger.ru/translations/yaml-za-5-minut-sintaksis-i-osnovnye-vozmozhnosti/#part4  
