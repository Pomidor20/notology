###




### Создание 3-ех винтуальных машин(файл Vagrantfile)
```
Vagrant.configure("2") do |config|
  # Конфигурация для первой виртуальной машины
  config.vm.define "vm1" do |vm1|
    vm1.vm.box = "debian/bullseye64" # Замените на имя образа, который вы хотите использовать
    vm1.vm.network "public_network",bridge: "Intel(R) Wi-Fi 6 AX200 160MHz"
    vm1.vm.provider "virtualbox" do |vb1|
      vb1.name = 'VMcom1'
      vb1.memory = 1024 # Выделить памяти (в мегабайтах)
      vb1.cpus = 1 # Выделить процессорных ядер
    end
  end

  # Конфигурация для второй виртуальной машины
  config.vm.define "vm2" do |vm2|
    vm2.vm.box = "debian/bullseye64" # Замените на имя образа, который вы хотите использовать
    vm2.vm.network "public_network", bridge: "Intel(R) Wi-Fi 6 AX200 160MHz"
    vm2.vm.provider "virtualbox" do |vb2|
      vb2.name = 'VMcom2'
      vb2.memory = 1024 # Выделить памяти (в мегабайтах)
      vb2.cpus = 1 # Выделить процессорных ядер
    end
  end

  # Конфигурация для третьей виртуальной машины
  config.vm.define "vm3" do |vm3|
    vm3.vm.box = "debian/bullseye64" # Замените на имя образа, который вы хотите использовать
    vm3.vm.network "public_network", bridge: "Intel(R) Wi-Fi 6 AX200 160MHz"
    vm3.vm.provider "virtualbox" do |vb3|
      vb3.memory = 1024 # Выделить памяти (в мегабайтах)
      vb3.cpus = 1 # Выделить процессорных ядер
      vb3.name = 'VMcom3'
    end
  end
end
```

#### Авторизация на VM

Для авторизации на Vm можно оспользовать несколько вариантов:

- Через команду vagrant:

  vagrant ssh _**имя vm**_ 

- Через стандартную команду ssh:

  ssh vagrand@localhost -p _**проброшенный порт в vm**_ [^1] -i _**путь к файлу закрытому ключу**_ [^2] 


- Через файл конфигурации ssh:
  Выгружем файл подключений Vagrant к vm в папку.
```
vagrant ssh-config >> ~/.ssh/config 
```
Пример содержания файла ~/.ssh/config 
>!
>Host vm1
>  HostName 127.0.0.1
> User vagrant
>  Port 2200
>  UserKnownHostsFile /dev/null
>  StrictHostKeyChecking no
>  PasswordAuthentication no
>  IdentityFile /home/user/vagrant/.vagrant/machines/vm1/virtualbox/private_key
>  IdentitiesOnly yes
>  LogLevel FATAL
>  PubkeyAcceptedKeyTypes +ssh-rsa
>  HostKeyAlgorithms +ssh-rsa


Теперь при подключении по ssh мы пишем:

ssh _**имя vm**_ 
```
ssh vm1
```



[^1]: Из картнки ниже мы видим что нужно подключатся к 2200 порту
```
==> vm2: Preparing network interfaces based on configuration...
    vm2: Adapter 1: nat
    vm2: Adapter 2: bridged
==> vm2: Forwarding ports...
    vm2: 22 (guest) => 2200 (host) (adapter 1)

```

[^2]: IdentityFile /home/user/vagrant/.vagrant/machines/vm3/virtualbox/private_key. Путь указывает на сесто где указана инициализация Vagrant

[^3]: > Вот тут







