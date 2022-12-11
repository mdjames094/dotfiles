# Open */tmp* files in RAM
# Use *noatime* with main drive

```
# /etc/fstab: static file system information.
#
# Use 'blkid' to print the universally unique identifier for a
# device; this may be used with UUID= as a more robust way to name devices
# that works even if disks are added and removed. See fstab(5).
#
# <file system> <mount point>   <type>  <options>       <dump>  <pass>
# / was on /dev/nvme0n1p5 during installation
UUID=aac90bc1-04a1-4a5a-af27-be91fac4bff7 /               ext4    noatime,errors=remount-ro 0       1
# /boot/efi was on /dev/nvme0n1p1 during installation
UUID=6460-6851  /boot/efi       vfat    umask=0077      0       1
/swapfile                                 none            swap    sw              0       0

# Browser cache in RAM
tmpfs	/tmp		tmpfs	noatime,nodiratime,defaults	0	0
tmpfs	/var/cache	tmpfs	noatime,nodiratime,defaults	0	0
tmpfs	/var/lock	tmpfs	noatime,nodiratime,defaults	0	0
tmpfs	/var/log	tmpfs	noatime,nodiratime,defaults	0	0
tmpfs	/var/run	tmpfs	noatime,nodiratime,defaults	0	0
tmpfs	/var/spool	tmpfs	noatime,nodiratime,defaults	0	0
tmpfs	/var/tmp	tmpfs	noatime,nodiratime,defaults	0	0

```

