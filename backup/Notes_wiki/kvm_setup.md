# References
https://www.dwarmstrong.org/kvm-qemu-libvirt/
https://linux.goffinet.org/administration/virtualisation-linux/virtualisation-kvm/
http://www.polarsparc.com/xhtml/Linux-KVM.html

# Some vocabulary
- **qemu-kvm** : the emulator itself
- **libvirt-daemon** : runs virtualization in background
- **bridge-utils** : important networking dependencies
- **virt-manager** : the graĥical program we'll use to work with VMs

Using KVM :
- gui : virtual achine manager
- command line : virsh
- xml descriptive file

![91b5c5ac72bdfbce8beb4e6e16acc86d.png](../../_resources/91b5c5ac72bdfbce8beb4e6e16acc86d.png)


# Installation

## Check compatibility
```
egrep -c '(vmx|svm)' /proc/cpuinfo
lscpu | grep Virtualization
```

## Installation
```
sudo apt install  qemu qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virt-manager virtinst
```

## reboot
```
reboot
```

## Check kernel module
```
lsmod | grep -i kvm
```

## Check if kvm correctly installed
```
virsh list --all
```

## Check if 'libvirt' group exists
## Add user to the kvm and libvirt groups
```
sudo groups $(whoami)
sudo usermod -a -G kvm,libvirt $(whoami)
sudo groups $(whoami)
```

# Directories
Default directory to hold VM images is /var/lib/libvirt/images.

Since I have root and home on separate partitions - and I have much more storage space in home - I create an images directory there, plus an isos directory to hold Linux installer images ...
```
mkdir -p ~/Downloads/Iso
mkdir -p ~/Applications/VMs
sudo chown :kvm ~/Applications/VMs
sudo rmdir /var/lib/libvirt/images
```

Create symbolic links to these new directories in /var/lib/libvirt ...
```
sudo ln -s ~/Applications/VMs /var/lib/libvirt/images
sudo ln -s ~/Downloads/Iso /var/lib/libvirt/isos
```

# Permissions
## libvirt.conf
Create ~/.config/libvirt/libvirt.conf ...
```
mkdir ~/.config/libvirt
sudo cp -rv /etc/libvirt/libvirt.conf ~/.config/libvirt/
sudo chown foo: ~/.config/libvirt/libvirt.conf
```

Open the file and set ...
```
uri_default = "qemu:///system"
```

## qemu.conf
For storage file permissions, open /etc/libvirt/qemu.conf and set the user to your username (example: foo) and group to libvirt ...
```
user = "foo"
group = "libvirt"
```

Start the libvirt service ...
```
sudo systemctl enable libvirtd
sudo systemctl start libvirtd
systemctl status libvirtd
```

## Start Virtual Machine Manager
```
virt-manager
```











