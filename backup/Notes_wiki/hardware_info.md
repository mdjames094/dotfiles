```
inxi -F
```

# CPU Model
```
grep -i "model name" /proc/cpuinfo
```

# GPU Model
```
lspci | grep -i --color "vga\|3d\|2d"
```

# Chipset Model
```
sudo dmidecode -t baseboard
```

# Keyboard, Trackpad and Touchscreen Connection Type
```
sudo dmesg | grep -i input
```

# Audio Codec
```
aplay -l
```

# Network Controller models
Basic info:
```
lspci | grep -i network
```

More in-depth info:
```
lshw -class network
```

# Drive Model
```
lshw -class disk -class storage
```
