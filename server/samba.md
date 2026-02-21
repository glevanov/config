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

  # Performance & timeout fixes for file transfers
  deadtime = 0
  socket options = TCP_NODELAY IPTOS_LOWDELAY SO_KEEPALIVE SO_RCVBUF=131072 SO_SNDBUF=131072
  use sendfile = yes
  aio read size = 16384
  aio write size = 16384
  strict sync = no
  sync always = no

[Public Videos]
  path = /mnt/storage/public/videos
  read only = yes
  guest ok = no
  valid users = @nas-users
  write list = @nas-admins

[Public Music]
  path = /mnt/storage/public/music
  read only = yes
  guest ok = no
  valid users = @nas-users
  write list = @nas-admins

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

* Create and enable samba users
```bash
sudo smbpasswd -a user
sudo smbpasswd -e user
```

* Label directories so that selinux is happy
```bash
sudo semanage fcontext -a -t samba_share_t "/mnt/storage(/.*)?"
sudo restorecon -Rv /mnt/storage
```

* Restart samba
```bash
sudo systemctl restart smb
```
