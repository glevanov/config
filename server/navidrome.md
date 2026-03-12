# navidrome
Installation instructions available here: https://www.navidrome.org/docs/installation/

* Download rpm from the [releases page](https://github.com/navidrome/navidrome/releases)
```bash
wget https://github.com/navidrome/navidrome/releases/download/v0.60.3/navidrome_0.60.3_linux_amd64.rpm
```

* Install .rpm
```bash
sudo dnf install navidrome_0.60.3_linux_amd64.rpm
```

* Setup music folder path
```
sudo nano /etc/navidrome/navidrome.toml
# set to this
# MusicFolder = "/mnt/storage/public/music"
```

* Configure firewall
```bash
sudo firewall-cmd --add-port=4533/tcp
sudo firewall-cmd --runtime-to-permanent
```

It's now available at `http://<server ip>:4533/`
