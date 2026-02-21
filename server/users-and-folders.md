# Users and Folders
This guide aims to create a folder structure like this at your `/mtn/storage`:
```
.
├── private        # Accessible only by the users
│   └── user1
│       └── media
└── public         # Everyone has readonly access
    ├── music
    ├── videos
    └── shared     # Writable by everyone
```

## Users and Groups setup
* Create user groups for nas users and admins.
```bash
sudo groupadd nas-users
sudo groupadd nas-admins
```

* Add your user to users and admins
```bash
sudo adduser user nas-users
sudo adduser user nas-admins
```

* Create readonly user to access media files; they won't be able to access the server, just the samba share
```bash
sudo useradd -M -s /sbin/nologin -G nas-users sreader
```

* Set samba password
```bash
sudo smbpasswd -a sreader
```

* Enable user in samba
```bash
sudo smbpasswd -e sreader
```

* (optional) Create regular users
```bash
sudo useradd -m -G nas-users user
sudo passwd user
```

* Create base directories
```bash
sudo mkdir -p /mnt/storage/{public/{videos,music,shared},private}
```

* Create a user directory
```bash
sudo mkdir -p /mnt/storage/private/user1
```

## Change ownership for folders
* Public videos (read-only for everyone)
```bash
sudo chown -R admin:nas-users /mnt/storage/public/videos
sudo chmod -R 755 /mnt/storage/public/videos
```

* Public music (read-only for everyone)
```bash
sudo chown -R admin:nas-users /mnt/storage/public/music
sudo chmod -R 755 /mnt/storage/public/music
```

* Public shared (read-write for all users)
```bash
sudo chown -R admin:nas-users /mnt/storage/public/shared
sudo chmod -R 775 /mnt/storage/public/shared
sudo chmod g+s /mnt/storage/public/shared  # SetGID for group inheritance
```

* Private user directories
```bash
sudo chown -R user:user /mnt/storage/private/user
sudo chmod -R 700 /mnt/storage/private/user
```

* Prevent browsing on base public directory
```bash
sudo chmod 751 /mnt/storage/private
```
