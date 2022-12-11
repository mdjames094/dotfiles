# /etc/sysctl.conf
```
# Check current setting
cat /proc/sys/vm/swappiness

# Edit /etc/sysctl.conf
sudo vi /etc/sysctl.conf

# Swapping starts when RAM usage exceeds 90%
vm.swappiness = 10
```

