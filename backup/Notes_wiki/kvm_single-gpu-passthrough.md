https://gitlab.com/risingprismtv/single-gpu-passthrough/-/wikis/home

# Preparations

Warning your GPU has to support UEFI.

Preperations:

- Check if your motherboard BIOS version is recent. (this can help you with having better IOMMU groups)
- Check if your system is installed in UEFI mode. (CSM disabled in bios for AMD)

INTEL:
VT-D = Enabled VT-X = Enabled

# Editing GRUB

Enable IOMMU
Set the parameter intel_iommu=on or amd_iommu=on respective to your system in the grub config

Set the parameter iommu=pt in grub config for safety reasons

You can add this parameter video=efifb:off fixes issues that few people have with returning back to the host. (Mostly AMD users)

```
sudo vi /etc/default/grub
```

**Edit Grub:**
```
GRUB_CMDLINE_LINUX_DEFAULT="amd_iommu=on iommu=pt quiet splash"
```

**Update Grub:**
```
sudo update-grub
```

# REBOOT

# Checking if your IOMMU groups are valid

Use this script:
```
#!/bin/bash
shopt -s nullglob
for g in /sys/kernel/iommu_groups/*; do
    echo "IOMMU Group ${g##*/}:"
    for d in $g/devices/*; do
        echo -e "\t$(lspci -nns ${d##*/})"
    done;
done;
```

output in my case:

- IOMMU Group 0:
         00:00.0 Host bridge [0600]: Intel Corporation 4th Gen Core Processor DRAM Controller [8086:0c00] (rev 06)
- IOMMU Group 1:
         00:14.0 USB controller [0c03]: Intel Corporation 8 Series/C220 Series Chipset Family USB xHCI [8086:8c31] (rev 05)
- IOMMU Group 10:
         02:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller [10ec:8168] (rev 0c)
- IOMMU Group 2:
         00:16.0 Communication controller [0780]: Intel Corporation 8 Series/C220 Series Chipset Family MEI Controller #1 [8086:8c3a] (rev 04)
- IOMMU Group 3:
         00:1a.0 USB controller [0c03]: Intel Corporation 8 Series/C220 Series Chipset Family USB EHCI #2 [8086:8c2d] (rev 05)
- IOMMU Group 4:
         00:1b.0 Audio device [0403]: Intel Corporation 8 Series/C220 Series Chipset High Definition Audio Controller [8086:8c20] (rev 05)
- IOMMU Group 5:
         00:1c.0 PCI bridge [0604]: Intel Corporation 8 Series/C220 Series Chipset Family PCI Express Root Port #1 [8086:8c10] (rev d5)
- IOMMU Group 6:
         00:1c.4 PCI bridge [0604]: Intel Corporation 8 Series/C220 Series Chipset Family PCI Express Root Port #5 [8086:8c18] (rev d5)
- IOMMU Group 7:
         00:1d.0 USB controller [0c03]: Intel Corporation 8 Series/C220 Series Chipset Family USB EHCI #1 [8086:8c26] (rev 05)
- IOMMU Group 8:
         00:1f.0 ISA bridge [0601]: Intel Corporation B85 Express LPC Controller [8086:8c50] (rev 05)
         00:1f.2 SATA controller [0106]: Intel Corporation 8 Series/C220 Series Chipset Family 6-port SATA Controller 1 [AHCI mode] [8086:8c02] (rev 05)
         00:1f.3 SMBus [0c05]: Intel Corporation 8 Series/C220 Series Chipset Family SMBus Controller [8086:8c22] (rev 05)
- IOMMU Group 9:
         01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GP106 [GeForce GTX 1060 6GB] [10de:1c03] (rev a1)
         01:00.1 Audio device [0403]: NVIDIA Corporation GP106 High Definition Audio Controller [10de:10f1] (rev a1)


Group 9: Is the perfect example how your GPU group should look like in most cases. Some NVIDIA cards will have 4 devices in the group. MAKE SURE YOU ADD THEM ALL!
AMD users can have there GPU and AUDIO device in different IOMMU group but that is still fine.
DON'T ADD BRIDGES

# Configuring of Libvirt

## Installing the packages

```
sudo apt install qemu-kvm libvirt-clients libvirt-daemon-system bridge-utils virt-manager ovmf
```

## Edit libvirtd.conf

Use your terminals editor vim,nvim,nano to edit this file.
```
sudo nano /etc/libvirt/libvirtd.conf
```
 
Uncomment the # off the following lines:

```
unix_sock_group = "libvirt"
unix_sock_rw_perms = "0770"
```

IMPORTANT: You need this for detailed logs.
Add this lines at the end of the file
```
log_filters="1:qemu"
log_outputs="1:file:/var/log/libvirt/libvirtd.log"
```

Then run these commands in your terminal.
This command assigns your user the libvirt group.
```
sudo usermod -a -G libvirt $(whoami)
sudo systemctl start libvirtd
sudo systemctl enable libvirtd
```

You can verify libvirt has been added to your users groups by using the following command.
```
sudo groups $(whoami)
```

It should return your current users groups like so.
username libvirt etc...
 
## Edit qemu.conf

```
sudo nano /etc/libvirt/qemu.conf
```
 
Edit the following lines.
```
#user = "root" to user = "your username"
#group = "root" to group = "your username"
```
 
Then restart the libvirt demon with the following.
```
sudo systemctl restart libvirtd
```
 
Note specific for use on: Linux Mint / Ubuntu / Popos or other Debian based systems!
```
sudo usermod -a -G kvm,libvirt $(whoami)
```
 
You can verify libvirt and kvm has been added to your users groups by using the following command.
```
sudo groups $(whoami)
```


It should return your current users groups like so.
username libvirt kvm etc...
 

## Enabling the virtual machine default network

Important: This will make your virsh internal network automaticly start when you start up your computer.
```
sudo virsh net-autostart default
```

If you prefer not to have the virtual machine network not to automaticly start you will have to run this command ever time you start up your computer.
```
sudo virsh net-start default
```
