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
#####Пояснение к пакетам
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
#### Список сайтов в помощь
1. https://www.linuxtechi.com/how-to-install-kvm-on-ubuntu-22-04/
1. https://losst.pro/ustanovka-kvm-ubuntu-16-04

```

```
