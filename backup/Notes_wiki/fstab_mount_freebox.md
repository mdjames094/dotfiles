# Access freebox harddrive - fstab settings
```
sudo apt-get install cifs-utils

sudo mkdir /media/freebox/
sudo touch $HOME/.smbcredentials

sudo vim $HOME/.smbcredentials
#username=XXXXXX
#password=XXXXXX

sudo chown -R $USER:root $HOME/.smbcredentials
sudo chmod -R 775 $HOME/.smbcredentials

sudo cp /etc/fstab /etc/fstab.old
sudo nano /etc/fstab

# mount freebox
//192.168.1.254/disque\040dur /media/freebox cifs _netdev,rw,users,credentials=/home/VOTRE_UTILISATEUR/.smbcredentials,iocharset=utf8,uid=1000,sec=ntlmv2,file_mode=0777,dir_mode=0777,vers=2.0
```

