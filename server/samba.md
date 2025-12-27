# Samba setup
* Install samba (I was missing `samba` package)
```bash
sudo dnf install samba samba-common
```

* Enable samba daemon
```bash
sudo systemctl enable smb --now
```

* Add firewall rule
```bash
sudo firewall-cmd --permanent --add-service=samba
sudo firewall-cmd --reload
```

* Add this to `/etc/samba/smb.conf`
```conf
[global]
  workgroup = WORKGROUP
  security = user
  map to guest = never

[Public Videos]
  path = /mnt/storage/public/videos
  read only = yes
  guest ok = no
  valid users = @nas-users

[Public Music]
  path = /mnt/storage/public/music
  read only = yes
  guest ok = no
  valid users = @nas-users

[Public Shared]
  path = /mnt/storage/public/shared
  read only = no
  valid users = @nas-users

[User1 Private]
  path = /mnt/storage/private/user1
  valid users = user1, @nas-admins
  read only = no
  browseable = no
```

* Create samba users (linux users and samba users are not the same)
```bash
sudo smbpasswd -a user
```

* Restart samba
```bash
sudo systemctl restart smb
```
