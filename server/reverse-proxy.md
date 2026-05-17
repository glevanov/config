# Reverse proxy

- Install nginx
```bash
sudo dnf install nginx -y
```

- Create config file
```bash
sudo touch /etc/nginx/conf.d/local-proxy.conf
```

- Sample config file
```conf
server {
    listen 80;
    # catch-all, matches any hostname/IP
    server_name _;

    location /app/ {
        proxy_pass http://127.0.0.1:1234/; # trailing slash strips /app prefix, some apps need this intact, like navidrome
        proxy_set_header Host              $host;
        proxy_set_header X-Real-IP         $remote_addr;
        proxy_set_header X-Forwarded-For   $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

- Check that your default config does not have server block on port 80. If it does, you'll need to remove it.
Config path is `/etc/nginx/nginx.conf`.

- Start nginx
```bash
sudo systemctl enable --now nginx
```

- Update firewall
```bash
# Open HTTP (port 80) if not already open
sudo firewall-cmd --permanent --add-service=http
# Apply changes
sudo firewall-cmd --reload
# Verify
sudo firewall-cmd --list-all
```

- Test config
```bash
sudo nginx -t
```

- Reload after future config edits
```bash
sudo systemctl reload nginx
```

- If you get 502 when you open your url, there is likely an issue with SE Linux
```bash
# Check the logs for nginx related denials
sudo ausearch -m avc -ts recent | grep nginx
# This will allow outbound connections for specific ports
sudo semanage port -a -t http_port_t -p tcp 1234
# Restart nginx
sudo systemctl reload nginx
```
