# /etc/default/grub
```
# If you change this file, run 'update-grub' afterwards to update /boot/grub/grub.cfg.
# For full documentation of the options in this file, see: info -f grub -n 'Simple configuration'
GRUB_DEFAULT=saved
GRUB_SAVEDEFAULT=true
# #GRUB_HIDDEN_TIMEOUT=0
GRUB_HIDDEN_TIMEOUT_QUIET=true
GRUB_TIMEOUT=1
GRUB_DISTRIBUTOR='Linux Lite'
GRUB_CMDLINE_LINUX_DEFAULT="quiet nosplash"
GRUB_CMDLINE_LINUX="elevator=deadline iwlwifi.power_save=Y iwlwifi.power_level=3 net.ifnames=0 biosdevname=0"
# GRUB_BACKGROUND="/boot/grub_linux_lite.png"
GRUB_TERMINAL=console
GRUB_GFXMODE=1280x1024x32,1024x768x32,auto
GRUB_GFXPAYLOAD_LINUX="keep"
GRUB_VIDEO_BACKEND="vbe"
#GRUB_DISABLE_LINUX_UUID=true
#GRUB_DISABLE_RECOVERY="true"
```

# /boot/grub/custom.cfg
```
set color-normal=black/black
set menu_color_normal=dark-gray/black
set menu_color_highlight=white/dark-gray
menuentry "System shutdown" {
	echo "System shutting down..."
	halt
}
menuentry "System reboot" {
	echo "System rebooting"
	reboot
}
```
