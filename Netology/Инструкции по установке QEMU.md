# Установка QEMU + KVM


### Debian:
	sudo apt install qemu-kvm qemu qemu-system

### CentOS:
	sudo yum install qemu-kvm qemu qemu-system

### ArchLinux:
	sudo pacman -i qemu-kvm qemu qemu-system

### FreeBSD:
	cd /usr/ports/emulator/qemu
	make && make install && make install clean


# Параметры QEMU

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

### Создание VM QEMU (из лекции)
	qemu-img create -f qcow2 test 1G
	qemu-system-x86_64 -hda ubuntu.qcow -boot d -cdrom ~/downloads/name_iso.iso -m 640
 	qemu-system-i386 -display none -serial stdio -hda test -boot d -cdrom ./Загрузки/alpine-standard-3.13.5-x86.iso -m 640
  	qemu-system-x86_64 -nographic -hda /home/snake/qemd -boot d -cdrom /home/snake/alpine-standard-3.13.5-x86.iso -m 2048


# Полезные ссылки
	https://www.opennet.ru/tips/3209_qemu_kvm_virtual.shtml
	https://losst.pro/kak-polzovatsya-qemu
 	https://ahelpme.com/software/qemu/qemu-full-virtualization-cpu-emulations-enable-disable-cpu-flags-instruction-sets-of-qemu-6-2-0/
