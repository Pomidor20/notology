# Установка QEMU + KVM
ы
### Debian:
	sudo apt install qemu-kvm qemu qemu-system

### CentOS:
	sudo yum install qemu-kvm qemu qemu-system

### ArchLinux:
	sudo pacman -i qemu-kvm qemu qemu-system

### FreeBSD:
	cd /usr/ports/emulator/qemu
	make && make install && make install clean


## Создание VM QEMU (из лекции)
1. Создаем диск
	```
	qemu-img create -f qcow2 test3 1G
	```
	
1. Дальше можно выбрать ряд загрузок и устновок

1. Установка с без gui
	```
	qemu-system-x86_64 display none -serial stdio -net nic -net user -hda test3 -boot d -cdrom ./Загрузки/alpine-standard-3.18.3-x86_64.iso -m 1024
  	qemu-system-x86_64 -nographic -net nic -net user -hda test3 -boot d -cdrom ./Загрузки/alpine-standard-3.18.3-x86_64.iso -m 1024
	```

1. C GUI
	```
	qemu-system-x86_64 -net nic -net user -hda test3 -boot d -cdrom ./Загрузки/alpine-standard-3.18.3-x86_64.iso -m 1024
	````
	
1. После загрузки с диска нужно установить Alpine
	```
	setup-alpine -q
	setup-disk
	```
	
1. После установки запускаем 
	```
	qemu-system-x86_64 -nographic -net nic -net user -hda test3  -m 1024
	```
	
### Все установка окончена
	
#  По установке Alpine
	https://wiki.alpinelinux.org/wiki/Alpine_setup_scripts
	https://wiki.alpinelinux.org/wiki/Installation


# Параметры запуска QEMU

### Эмулятор qemu создает много команд, но их можно разделить на группы:
1. qemu-архитектура — эмуляция окружения пользователя для указанной архитектуры;
1. qemu-system-архитектура — эмуляция полной системы для архитектуры;
1. qemu-img — утилита для работы с дисками;
1. qemu-io — утилита для работы с вводом/выводом на диск;
1. qemu-user — оболочка для qemu-архитектура, позволяет запускать программы других архитектур в этой системе;
1. qemu-system — оболочка для qemu-system-архитектура,позволяет полностью эмулировать систему нужной архитектуры.

### Для использования команд настройки выше:
	$ qemu-system параметры
### Куда сложнее здесь синтаксис каждого из параметров:
	имя_параметра имя_опции=значение:значение2
### https://wiki.qemu.org/Category:User_documentation

### Полезные ссылки
	https://www.opennet.ru/tips/3209_qemu_kvm_virtual.shtml
	https://losst.pro/kak-polzovatsya-qemu
 	https://ahelpme.com/software/qemu/qemu-full-virtualization-cpu-emulations-enable-disable-cpu-flags-instruction-sets-of-qemu-6-2-0/
