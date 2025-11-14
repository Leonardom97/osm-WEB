# Guía de Despliegue de osm-WEB en Nginx

Esta guía te ayudará a configurar y desplegar la aplicación osm-WEB en un servidor con Nginx.

## 📋 Requisitos Previos

### Sistema Operativo
- Ubuntu 20.04 LTS o superior (recomendado)
- Debian 10 o superior
- Cualquier distribución Linux compatible con Nginx

### Acceso al Servidor
- Acceso root o sudo
- Conexión SSH al servidor
- Puerto 80 (HTTP) y 443 (HTTPS) abiertos en el firewall

### Software Requerido
El script de despliegue instalará automáticamente:
- Nginx
- PHP 8.1 (o superior) con extensiones necesarias
- PostgreSQL client
- Certbot (opcional, para SSL)

---

## 🚀 Método 1: Despliegue Automático (Recomendado)

### Paso 1: Preparar el Código

1. **Clonar o copiar el repositorio al servidor:**
```bash
cd /var/www
sudo git clone https://github.com/Leonardom97/osm-WEB.git
cd osm-WEB
```

O si ya tienes el código localmente, cópialo al servidor:
```bash
scp -r osm-WEB/ user@your-server:/var/www/
```

### Paso 2: Configurar Variables de Entorno

```bash
cd /var/www/osm-WEB
sudo cp .env.example .env
sudo nano .env
```

Edita el archivo `.env` con tus credenciales:
```ini
# Database - PostgreSQL
DB_PG_HOST=localhost
DB_PG_PORT=5432
DB_PG_NAME=osm2
DB_PG_USER=tu_usuario_postgres
DB_PG_PASSWORD=tu_password_postgres

# Database - SQL Server
DB_SQLSRV_HOST=192.168.150.199
DB_SQLSRV_PORT=1433
DB_SQLSRV_NAME=SVN_G4026_OSM
DB_SQLSRV_USER=tu_usuario_sqlserver
DB_SQLSRV_PASSWORD=tu_password_sqlserver

# Security
SESSION_TIMEOUT=3600
UPLOAD_MAX_SIZE=5242880
ENABLE_DEBUG=false  # IMPORTANTE: false en producción
```

### Paso 3: Ejecutar el Script de Despliegue

```bash
cd /var/www/osm-WEB/deployment/nginx
sudo chmod +x deploy.sh
sudo ./deploy.sh
```

El script:
- ✅ Instalará todos los paquetes necesarios
- ✅ Creará directorios requeridos
- ✅ Configurará permisos de archivos
- ✅ Configurará PHP-FPM
- ✅ Configurará Nginx
- ✅ Reiniciará los servicios

### Paso 4: Editar la Configuración de Nginx

Durante la ejecución del script, se te pedirá que edites la configuración de Nginx:

```bash
sudo nano /etc/nginx/sites-available/osm-web
```

**Reemplaza los siguientes valores:**
- `your-domain.com` → Tu dominio real (ej: `osm.miempresa.com`)
- `/var/www/osm-WEB` → Ruta de tu aplicación (si es diferente)
- Rutas de certificados SSL (si ya los tienes)

### Paso 5: Configurar SSL (Opcional pero Recomendado)

**Opción A: Let's Encrypt (Gratis y Automático)**
```bash
sudo apt install certbot python3-certbot-nginx
sudo certbot --nginx -d tu-dominio.com -d www.tu-dominio.com
```

**Opción B: Certificado Propio**
1. Copia tus certificados al servidor:
```bash
sudo cp tu-certificado.crt /etc/ssl/certs/osm-web.crt
sudo cp tu-clave.key /etc/ssl/private/osm-web.key
sudo chmod 600 /etc/ssl/private/osm-web.key
```

2. Actualiza la configuración de Nginx con las rutas correctas

### Paso 6: Verificar el Despliegue

```bash
# Verificar estado de Nginx
sudo systemctl status nginx

# Verificar estado de PHP-FPM
sudo systemctl status php8.1-fpm

# Ver logs de Nginx
sudo tail -f /var/log/nginx/osm-web-error.log

# Ver logs de PHP
sudo tail -f /var/www/osm-WEB/logs/php_errors.log
```

### Paso 7: Probar la Aplicación

Abre tu navegador y ve a:
- `https://tu-dominio.com`

---

## 🔧 Método 2: Despliegue Manual

Si prefieres configurar manualmente o el script automático no funciona:

### Paso 1: Instalar Paquetes

```bash
sudo apt update
sudo apt install -y nginx php8.1-fpm php8.1-pgsql php8.1-sqlsrv \
    php8.1-mbstring php8.1-xml php8.1-curl php8.1-gd php8.1-zip \
    postgresql-client
```

### Paso 2: Copiar el Código

```bash
sudo mkdir -p /var/www/osm-WEB
# Copiar tus archivos aquí
sudo chown -R www-data:www-data /var/www/osm-WEB
sudo chmod -R 755 /var/www/osm-WEB
```

### Paso 3: Configurar .env

```bash
cd /var/www/osm-WEB
sudo cp .env.example .env
sudo nano .env
# Editar con tus credenciales
sudo chmod 600 .env
sudo chown www-data:www-data .env
```

### Paso 4: Crear Directorios Necesarios

```bash
sudo mkdir -p /var/www/osm-WEB/logs
sudo mkdir -p /var/www/osm-WEB/assets/img/uploads
sudo mkdir -p /var/www/osm-WEB/m_capacitaciones/assets/docs
sudo chown -R www-data:www-data /var/www/osm-WEB/logs
sudo chown -R www-data:www-data /var/www/osm-WEB/assets/img/uploads
sudo chown -R www-data:www-data /var/www/osm-WEB/m_capacitaciones/assets/docs
```

### Paso 5: Configurar PHP

```bash
sudo nano /etc/php/8.1/fpm/php.ini
```

Busca y modifica estas líneas:
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

### Paso 6: Configurar Nginx

```bash
sudo cp deployment/nginx/osm-web.conf /etc/nginx/sites-available/osm-web
sudo nano /etc/nginx/sites-available/osm-web
# Editar configuración (dominio, SSL, etc.)
sudo ln -s /etc/nginx/sites-available/osm-web /etc/nginx/sites-enabled/
sudo rm /etc/nginx/sites-enabled/default  # Remover sitio por defecto
```

### Paso 7: Probar y Reiniciar

```bash
sudo nginx -t
sudo systemctl restart php8.1-fpm
sudo systemctl restart nginx
sudo systemctl enable php8.1-fpm
sudo systemctl enable nginx
```

---

## 🔒 Checklist de Seguridad Post-Despliegue

Después del despliegue, verifica estos puntos de seguridad:

- [ ] `.env` tiene permisos 600 y no es accesible vía web
- [ ] `ENABLE_DEBUG=false` en producción
- [ ] SSL/HTTPS configurado y funcionando
- [ ] Certificado SSL válido
- [ ] Credenciales de base de datos rotadas (diferentes a las del repositorio)
- [ ] Logs funcionando correctamente
- [ ] Directorios de uploads protegidos contra ejecución de PHP
- [ ] Firewall configurado (solo puertos 80, 443, 22)
- [ ] Backups automáticos configurados
- [ ] Monitoreo de logs configurado

---

## 🐛 Solución de Problemas Comunes

### Error: "502 Bad Gateway"
**Causa:** PHP-FPM no está ejecutándose o hay error de configuración

**Solución:**
```bash
sudo systemctl status php8.1-fpm
sudo systemctl restart php8.1-fpm
sudo tail -f /var/log/nginx/osm-web-error.log
```

### Error: "Permission denied" en uploads
**Causa:** Permisos incorrectos

**Solución:**
```bash
sudo chown -R www-data:www-data /var/www/osm-WEB/assets/img/uploads
sudo chmod -R 755 /var/www/osm-WEB/assets/img/uploads
```

### Error: "Database connection failed"
**Causa:** Credenciales incorrectas o base de datos no accesible

**Solución:**
1. Verificar archivo `.env`:
```bash
sudo cat /var/www/osm-WEB/.env
```

2. Probar conexión PostgreSQL:
```bash
psql -h localhost -U tu_usuario -d osm2
```

3. Verificar logs:
```bash
sudo tail -f /var/www/osm-WEB/logs/php_errors.log
```

### Error: "File upload failed"
**Causa:** Tamaño de archivo excede límites

**Solución:**
```bash
# Editar nginx
sudo nano /etc/nginx/sites-available/osm-web
# Buscar: client_max_body_size y aumentar

# Editar PHP
sudo nano /etc/php/8.1/fpm/php.ini
# Buscar: upload_max_filesize y post_max_size y aumentar

# Reiniciar servicios
sudo systemctl restart php8.1-fpm nginx
```

### La aplicación se ve pero sin estilos CSS/JS
**Causa:** Problemas con rutas estáticas o permisos

**Solución:**
```bash
sudo chown -R www-data:www-data /var/www/osm-WEB/assets
sudo chmod -R 755 /var/www/osm-WEB/assets
# Verificar logs de nginx
sudo tail -f /var/log/nginx/osm-web-error.log
```

---

## 📊 Comandos Útiles

### Verificar Estado
```bash
# Estado de Nginx
sudo systemctl status nginx

# Estado de PHP-FPM
sudo systemctl status php8.1-fpm

# Procesos de Nginx
ps aux | grep nginx

# Procesos de PHP-FPM
ps aux | grep php-fpm
```

### Ver Logs
```bash
# Logs de Nginx (acceso)
sudo tail -f /var/log/nginx/osm-web-access.log

# Logs de Nginx (errores)
sudo tail -f /var/log/nginx/osm-web-error.log

# Logs de PHP
sudo tail -f /var/www/osm-WEB/logs/php_errors.log

# Logs del sistema
sudo journalctl -u nginx -f
sudo journalctl -u php8.1-fpm -f
```

### Reiniciar Servicios
```bash
# Reiniciar Nginx
sudo systemctl restart nginx

# Recargar configuración de Nginx (sin interrumpir)
sudo systemctl reload nginx

# Reiniciar PHP-FPM
sudo systemctl restart php8.1-fpm

# Probar configuración de Nginx
sudo nginx -t
```

### Permisos
```bash
# Restaurar permisos completos
sudo chown -R www-data:www-data /var/www/osm-WEB
sudo chmod -R 755 /var/www/osm-WEB
sudo chmod 600 /var/www/osm-WEB/.env
sudo chmod 755 /var/www/osm-WEB/logs
sudo chmod 755 /var/www/osm-WEB/assets/img/uploads
```

---

## 🔄 Actualización de la Aplicación

Para actualizar el código después del despliegue inicial:

```bash
# 1. Backup de la aplicación actual
cd /var/www
sudo tar -czf osm-WEB-backup-$(date +%Y%m%d).tar.gz osm-WEB/

# 2. Obtener nuevos cambios
cd osm-WEB
sudo git pull origin main

# 3. Verificar .env no se sobrescribió
# Si se necesitan nuevas variables, agregar manualmente

# 4. Ajustar permisos si es necesario
sudo chown -R www-data:www-data /var/www/osm-WEB
sudo chmod 600 /var/www/osm-WEB/.env

# 5. Reiniciar servicios
sudo systemctl reload nginx
sudo systemctl restart php8.1-fpm

# 6. Verificar logs
sudo tail -f /var/log/nginx/osm-web-error.log
```

---

## 📞 Soporte

Si encuentras problemas durante el despliegue:

1. **Revisa los logs:**
   - `/var/log/nginx/osm-web-error.log`
   - `/var/www/osm-WEB/logs/php_errors.log`
   - `journalctl -u nginx`

2. **Verifica la configuración:**
   - `sudo nginx -t`
   - `php -v`
   - `sudo systemctl status php8.1-fpm`

3. **Consulta la documentación de seguridad:**
   - `SECURITY_DEPLOYMENT_CHECKLIST.md`
   - `SECURITY_AUDIT_REPORT.md`

---

## ✅ Lista de Verificación Final

Antes de considerar el despliegue completo:

- [ ] Aplicación accesible vía HTTPS
- [ ] SSL funcionando correctamente (candado verde en navegador)
- [ ] Login funciona correctamente
- [ ] Subida de archivos funciona
- [ ] Base de datos conecta correctamente
- [ ] No hay errores en logs
- [ ] `.env` no es accesible públicamente
- [ ] Backups configurados
- [ ] Monitoreo básico configurado
- [ ] Documentación del despliegue guardada

---

¡Tu aplicación osm-WEB debería estar ahora ejecutándose correctamente en Nginx! 🎉
