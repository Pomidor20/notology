# Установка виртуально машины для KVM в связке с QEMU

### Проверим поддерживает ли проц аппаратную виртуализацию
	egrep --color=auto 'vmx|svm|0xc0f' /proc/cpuinfo

### Проверяем поддержку можеля в системе
	lsmod | grep kvm
### Если модуль не загружен:
	modprobe kvm
	modprobe kvm_intel  или modprobe kvm_amd

### Устанавливаем KVM для QEMU
	apt install qemu-kvm 

### Ставим virsh или virt-manager(для gui)



