# Nginx Configuration for osm-WEB Application

## Configuration File for Nginx

This file should be placed in `/etc/nginx/sites-available/osm-web` and symlinked to `/etc/nginx/sites-enabled/`

```nginx
# HTTP server - Redirect all HTTP to HTTPS
server {
    listen 80;
    listen [::]:80;
    server_name your-domain.com www.your-domain.com;

    # Redirect all HTTP requests to HTTPS
    return 301 https://$server_name$request_uri;
}

# HTTPS server
server {
    listen 443 ssl http2;
    listen [::]:443 ssl http2;
    server_name your-domain.com www.your-domain.com;

    # Document root
    root /var/www/osm-WEB;
    index index.html index.php;

    # SSL Configuration
    ssl_certificate /etc/ssl/certs/your-domain.crt;
    ssl_certificate_key /etc/ssl/private/your-domain.key;
    
    # SSL Security Settings
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers 'ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384';
    ssl_prefer_server_ciphers off;
    ssl_session_cache shared:SSL:10m;
    ssl_session_timeout 10m;
    ssl_stapling on;
    ssl_stapling_verify on;

    # Security Headers (additional to PHP headers)
    add_header Strict-Transport-Security "max-age=31536000; includeSubDomains; preload" always;
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header X-XSS-Protection "1; mode=block" always;

    # Logging
    access_log /var/log/nginx/osm-web-access.log;
    error_log /var/log/nginx/osm-web-error.log;

    # Hide nginx version
    server_tokens off;

    # Disable directory listing
    autoindex off;

    # Client body size limit (for file uploads)
    client_max_body_size 10M;

    # Default location
    location / {
        try_files $uri $uri/ =404;
    }

    # PHP processing
    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.1-fpm.sock;  # Adjust PHP version as needed
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
        
        # Security: Don't allow direct access to PHP files in certain directories
        location ~ ^/(\.env|\.git|logs|tmp) {
            deny all;
            return 404;
        }
    }

    # Deny access to .env files
    location ~ /\.env {
        deny all;
        return 404;
    }

    # Deny access to .git directory
    location ~ /\.git {
        deny all;
        return 404;
    }

    # Deny access to logs directory
    location ~ ^/logs/ {
        deny all;
        return 404;
    }

    # Deny access to hidden files (starting with .)
    location ~ /\. {
        deny all;
        return 404;
    }

    # Security: Prevent execution of PHP in upload directories
    location ~* ^/assets/img/uploads/.*\.php$ {
        deny all;
        return 404;
    }

    location ~* ^/m_capacitaciones/assets/docs/.*\.php$ {
        deny all;
        return 404;
    }

    # Static files caching
    location ~* \.(jpg|jpeg|png|gif|ico|css|js|svg|woff|woff2|ttf|eot)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }

    # Deny access to backup files
    location ~* \.(bak|config|sql|fla|psd|ini|log|sh|inc|swp|dist)$ {
        deny all;
        return 404;
    }

    # Gzip compression
    gzip on;
    gzip_vary on;
    gzip_proxied any;
    gzip_comp_level 6;
    gzip_types text/plain text/css text/xml text/javascript application/json application/javascript application/xml+rss application/rss+xml font/truetype font/opentype application/vnd.ms-fontobject image/svg+xml;
    gzip_disable "msie6";
}
```

## Installation Steps

1. **Copy this configuration:**
```bash
sudo nano /etc/nginx/sites-available/osm-web
```

2. **Enable the site:**
```bash
sudo ln -s /etc/nginx/sites-available/osm-web /etc/nginx/sites-enabled/
```

3. **Test nginx configuration:**
```bash
sudo nginx -t
```

4. **Reload nginx:**
```bash
sudo systemctl reload nginx
```

## Important Configuration Notes

### 1. Replace Placeholders
- `your-domain.com` - Your actual domain name
- `/var/www/osm-WEB` - Your actual application path
- `/etc/ssl/certs/your-domain.crt` - Your SSL certificate path
- `/etc/ssl/private/your-domain.key` - Your SSL key path
- `php8.1-fpm.sock` - Your PHP-FPM version socket

### 2. SSL Certificate
You can obtain a free SSL certificate using Let's Encrypt:
```bash
sudo apt install certbot python3-certbot-nginx
sudo certbot --nginx -d your-domain.com -d www.your-domain.com
```

### 3. PHP-FPM Configuration
Ensure PHP-FPM is installed and running:
```bash
sudo apt install php-fpm php-pgsql php-sqlsrv php-mbstring php-xml php-curl
sudo systemctl start php8.1-fpm
sudo systemctl enable php8.1-fpm
```

### 4. File Permissions
Set correct permissions:
```bash
sudo chown -R www-data:www-data /var/www/osm-WEB
sudo chmod -R 755 /var/www/osm-WEB
sudo chmod 600 /var/www/osm-WEB/.env
sudo chmod 755 /var/www/osm-WEB/logs
```

### 5. PHP Configuration
Edit `/etc/php/8.1/fpm/php.ini`:
```ini
upload_max_filesize = 10M
post_max_size = 10M
memory_limit = 256M
max_execution_time = 300
expose_php = Off
display_errors = Off
log_errors = On
error_log = /var/www/osm-WEB/logs/php_errors.log
```

Restart PHP-FPM after changes:
```bash
sudo systemctl restart php8.1-fpm
```
