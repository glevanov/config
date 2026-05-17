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

* Last.fm integration requires configuring API keys and putting them in `LastFM.ApiKey` and `LastFM.Secret` in the config

* Reverse proxy setup requires this:
```
BaseUrl = "/navidrome"
```

* Start the service
```bash
sudo systemctl enable --now navidrome
```
