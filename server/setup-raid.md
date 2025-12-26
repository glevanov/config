# Raid 1 Setup on Fedora Server

* Identify the drives:
```bash
lsblk
```

Drives would look like `/dev/sda` and `/dev/sdb`.

* Prepare the drives (this will erase all data):
```bash
sudo wipefs -a /dev/sda
sudo wipefs -a /dev/sdb
```

* Create the RAID 1 array:
```bash
sudo mdadm --create --verbose /dev/md0 --level=1 --raid-devices=2 /dev/sda /dev/sdb
```

* (optional) Check sync progress:
```bash
cat /proc/mdstat
```

* Create a filesystem (no need to wait, can be executed immediately):
```bash
sudo mkfs.ext4 /dev/md0
```

* Create a mount point and mount:
```bash
sudo mkdir /mnt/storage
sudo mount /dev/md0 /mnt/storage
```

* Add to `/etc/fstab` to make it permanent:
```bash
echo '/dev/md0 /mnt/storage ext4 defaults 0 0' | sudo tee -a /etc/fstab
```

* Save RAID configuration:
```bash
sudo mdadm --detail --scan | sudo tee -a /etc/mdadm.conf
```

* (optional) Save configuration in `initramfs`, in case you want to boot from RAID drives:
```bash
sudo dracut --force
```

* It's done. You can check your configuration with:
```bash
sudo mdadm --detail /dev/md0
```
