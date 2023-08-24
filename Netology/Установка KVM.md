# Установка виртуально машины для KVM в связке с QEMU

#### Проверим поддерживает ли проц аппаратную виртуализацию
	egrep --color=auto 'vmx|svm|0xc0f' /proc/cpuinfo

#### Проверяем поддержку виртуализации в системе
	lsmod | grep kvm
#### Если модуль не загружен,то загрузим:
	modprobe kvm
	modprobe kvm_intel  или modprobe kvm_amd

#### Устанавливаем KVM для QEMU
	apt install qemu-kvm 

#### Ставим KVM,virsh,virt-manager(для gui)
```
	apt install -y qemu-kvm virt-manager libvirt-daemon-system virtinst libvirt-clients bridge-utils
```
##### Пояснение к пакетам
	qemu-kvm  –  эмулятор с открытым исходным кодом и пакет виртуализации, обеспечивающий аппаратную эмуляцию.
	virt-manager –  графический интерфейс на основе Qt для управления виртуальными машинами через демон libvirt.
	libvirt-daemon-system –  пакет, предоставляющий файлы конфигурации, необходимые для запуска демона libvirt.
	virtinst – набор утилит командной строки для подготовки и изменения виртуальных машин.
	libvirt-clients –набор клиентских библиотек и API для управления виртуальными машинами и гипервизорами из командной строки.
	bridge-utils – Набор инструментов для создания мостовых устройств и управления ими.

#### добавляем текущго пользователя в группу libvirt (если root пропускаем шаг)
Это нужно что бы пользователь мог работать с vm (создавать,управлять,удалять)
```
sudo gpasswd -a $USER libvirt
```

#### Проверям запущена ли служба(демон) libvirt
	systemctl status libvirtd
	systemctl start libvirtd

#### Проверям что сетевой мост создан и работает
```
ip link
brctl show
```
Должен существовать интерфейс virbr0 

#### Создание vm через gui

Запускаем и в нем создаем gui
```
virt-manager
```
#### Создаем через cli
Шаблон лежит с проекте в папке files

####Управление VM из консоли virsh
Для управления из консоли используем команду virsh.только перед этим надо создать диск с cow2.
```
create --file ./notology/Netology/Виртуализация/files/"template vm virsh.txt"
```
Ключи команды:
```
virsh create target_guest_machine.xml - создать vm из консоли;
virsh edit <VM name> – изменить настройки виртуальной машины;
virsh start <VM name> – запустить виртуальную машину;
virsh shutdown <VM name> – выключить виртуальную машину;
virsh reboot <VM name> – перегрузить виртуальную машину;
virsh console <VM name> – открыть консоль виртуальной машины; выход из консоли осуществляется при помощи сочетания Ctrl + ] ;
virsh list --all – вывести список всех виртуальных машин;
virsh destroy <VM name> – уничтожает (останавливает) виртуальную машину (когда shutdown не работает);
virsh undefine <VM name> – удалить виртуальную машину из списка (необходимо применять после destroy);
virsh vcpuinfo <VM name> – просмотр привязки виртуальных ядер к физическим в данный момент времени (повторный вывод может отличаться, если привязка ядер не фиксированная).
```
#### создание через virt-install
```
virt-install --name centos8-2 --memory 10240 --vcpus=2 --os-type=Linux --os-variant=centos7.0 --location=/tmp/rhel-server-7.6-x86_64-dvd.iso  --network network=default --graphics=vnc -v Using centos7.0 default --disk size=10
```
#### Список сайтов в помощь
1. https://www.linuxtechi.com/how-to-install-kvm-on-ubuntu-22-04/
1. https://losst.pro/ustanovka-kvm-ubuntu-16-04
1. https://libvirt.org/formatdomain.html
1. https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/virtualization_getting_started_guide/chap-virtualization_getting_started-what_is_it
1. https://www.golinuxcloud.com/virt-install-examples-kvm-virt-commands-linux/
1. https://www.techotopia.com/index.php/Installing_a_KVM_Guest_OS_from_the_Command-line_(virt-install)
