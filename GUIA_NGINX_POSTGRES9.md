# Guía de Instalación con Nginx y PostgreSQL 9

## 📋 Requisitos del Sistema

### Software Requerido
- **Sistema Operativo**: Ubuntu 20.04+ / Debian 10+ / CentOS 8+
- **Nginx**: 1.18 o superior
- **PHP**: 7.4 o superior con PHP-FPM
- **PostgreSQL**: 9.x, 10.x, 11.x, 12.x o superior
- **Herramientas**: Navicat (opcional), psql, git

### Extensiones PHP Requeridas
```bash
php-fpm
php-pgsql
php-mbstring
php-json
php-xml
php-curl
php-gd
```

---

## 🔧 Instalación Paso a Paso

### 1. Instalación de Nginx y PHP-FPM

#### Ubuntu/Debian
```bash
# Actualizar repositorios
sudo apt update

# Instalar Nginx
sudo apt install -y nginx

# Instalar PHP y extensiones
sudo apt install -y php7.4-fpm php7.4-pgsql php7.4-mbstring php7.4-json php7.4-xml php7.4-curl php7.4-gd

# Verificar instalación
nginx -v
php -v
```

#### CentOS/RHEL
```bash
# Instalar repositorios EPEL
sudo yum install -y epel-release

# Instalar Nginx
sudo yum install -y nginx

# Instalar PHP y extensiones
sudo yum install -y php74-fpm php74-pgsql php74-mbstring php74-json php74-xml php74-curl php74-gd

# Habilitar servicios
sudo systemctl enable nginx
sudo systemctl enable php-fpm
```

### 2. Instalación de PostgreSQL 9.x

#### Ubuntu/Debian
```bash
# Agregar repositorio de PostgreSQL
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt update

# Instalar PostgreSQL 9.6 (o versión específica)
sudo apt install -y postgresql-9.6 postgresql-contrib-9.6

# Habilitar servicio
sudo systemctl enable postgresql
sudo systemctl start postgresql
```

**Nota**: PostgreSQL 9 ha alcanzado su fin de vida (EOL). Se recomienda usar PostgreSQL 11 o superior para producción. Los scripts son compatibles con ambas versiones.

### 3. Configuración de PostgreSQL

```bash
# Cambiar a usuario postgres
sudo -i -u postgres

# Crear base de datos
createdb osm2

# Configurar contraseña
psql -c "ALTER USER postgres WITH PASSWORD '12345';"

# Salir
exit
```

#### Configurar acceso remoto (opcional)
```bash
# Editar postgresql.conf
sudo nano /etc/postgresql/9.6/main/postgresql.conf

# Descomentar y cambiar:
listen_addresses = 'localhost'  # o '*' para acceso remoto

# Editar pg_hba.conf
sudo nano /etc/postgresql/9.6/main/pg_hba.conf

# Agregar línea (para desarrollo):
host    all             all             127.0.0.1/32            md5

# Reiniciar PostgreSQL
sudo systemctl restart postgresql
```

### 4. Clonar e Instalar la Aplicación OSM

```bash
# Crear directorio web
sudo mkdir -p /var/www/osm-WEB
cd /var/www/osm-WEB

# Clonar repositorio (reemplazar con tu URL)
sudo git clone https://github.com/Leonardom97/osm-WEB.git .

# Establecer permisos
sudo chown -R www-data:www-data /var/www/osm-WEB
sudo chmod -R 755 /var/www/osm-WEB

# Crear directorio para uploads
sudo mkdir -p /var/www/osm-WEB/assets/uploads
sudo chmod -R 775 /var/www/osm-WEB/assets/uploads
```

### 5. Configurar Nginx

```bash
# Copiar configuración de Nginx
sudo cp /var/www/osm-WEB/nginx.conf /etc/nginx/sites-available/osm-web

# Editar configuración según tu entorno
sudo nano /etc/nginx/sites-available/osm-web

# Cambiar los siguientes valores:
# - server_name: tu dominio o IP
# - root: verificar ruta /var/www/osm-WEB
# - fastcgi_pass: verificar versión de PHP (php7.4-fpm.sock)

# Crear enlace simbólico
sudo ln -s /etc/nginx/sites-available/osm-web /etc/nginx/sites-enabled/

# Eliminar configuración por defecto (opcional)
sudo rm /etc/nginx/sites-enabled/default

# Probar configuración
sudo nginx -t

# Si todo está bien, reiniciar Nginx
sudo systemctl restart nginx
```

### 6. Configurar PHP

```bash
# Editar configuración de PHP-FPM
sudo nano /etc/php/7.4/fpm/php.ini

# Ajustar valores recomendados:
upload_max_filesize = 20M
post_max_size = 20M
memory_limit = 256M
max_execution_time = 300

# Reiniciar PHP-FPM
sudo systemctl restart php7.4-fpm
```

### 7. Configurar Conexión a Base de Datos

```bash
# Editar archivo de conexión
sudo nano /var/www/osm-WEB/php/db_postgres.php

# Verificar y ajustar credenciales:
$host = 'localhost';
$db   = 'osm2';
$user = 'postgres';
$pass = '12345';  # Cambiar por tu contraseña segura
$port = '5432';
```

### 8. Importar Base de Datos

#### Opción 1: Base de Datos Nueva (Desde Cero)
```bash
# Importar schema completo
psql -U postgres -d osm2 -f /var/www/osm-WEB/db/osm_postgres.sql

# Verificar importación
psql -U postgres -d osm2 -c "\dt"
```

#### Opción 2: Actualizar Base de Datos Existente
```bash
# Ejecutar script de actualización (PostgreSQL 9 compatible)
psql -U postgres -d osm2 -f /var/www/osm-WEB/db/update_osm_postgres9.sql

# Revisar salida para verificar éxito
```

#### Opción 3: Usar Navicat

1. Abrir Navicat y conectar a PostgreSQL
2. Seleccionar base de datos `osm2`
3. Clic derecho → "Execute SQL File"
4. Seleccionar `/var/www/osm-WEB/db/update_osm_postgres9.sql`
5. Clic en "Start" o "Execute"
6. Revisar mensajes en la ventana de output

### 9. Verificar Instalación

```bash
# Verificar servicios
sudo systemctl status nginx
sudo systemctl status php7.4-fpm
sudo systemctl status postgresql

# Probar conexión a base de datos
psql -U postgres -d osm2 -c "SELECT version();"

# Verificar tablas creadas
psql -U postgres -d osm2 -c "\dt"
```

### 10. Acceder a la Aplicación

```bash
# Abrir navegador y acceder a:
http://tu-servidor-ip
# o
http://tu-dominio.com

# Credenciales por defecto:
# Usuario: 123456789
# Contraseña: Osm1234
```

---

## 🔒 Configuración de Seguridad

### Firewall
```bash
# Permitir HTTP/HTTPS
sudo ufw allow 'Nginx Full'
sudo ufw enable
```

### SSL/TLS con Let's Encrypt (Recomendado para Producción)
```bash
# Instalar Certbot
sudo apt install -y certbot python3-certbot-nginx

# Obtener certificado
sudo certbot --nginx -d tu-dominio.com

# Renovación automática
sudo certbot renew --dry-run
```

### Cambiar Contraseñas por Defecto
```bash
# Conectar a base de datos
psql -U postgres -d osm2

# Cambiar contraseña de usuario admin
UPDATE adm_usuarios 
SET au_contra = MD5('NuevaContraseñaSegura') 
WHERE au_usuario = '123456789';
```

### Proteger Archivos Sensibles
```bash
# Cambiar permisos de archivos de configuración
sudo chmod 640 /var/www/osm-WEB/php/db_postgres.php
sudo chown www-data:www-data /var/www/osm-WEB/php/db_postgres.php

# Evitar acceso directo a archivos SQL
sudo chmod 600 /var/www/osm-WEB/db/*.sql
```

---

## 📊 Compatibilidad PostgreSQL 9

### Diferencias Principales con PostgreSQL 17

Los scripts de actualización (`update_osm_postgres9.sql`) están optimizados para PostgreSQL 9 con las siguientes adaptaciones:

1. **Secuencias tradicionales**: Uso de `CREATE SEQUENCE` y `nextval()` en lugar de `GENERATED BY DEFAULT AS IDENTITY`
2. **Triggers**: Uso de `EXECUTE PROCEDURE` en lugar de `EXECUTE FUNCTION` (compatible con v9)
3. **Verificación de columnas**: Uso de `DO` blocks con `information_schema` para compatibilidad con versiones antiguas
4. **Índices**: Sintaxis explícita con `USING btree` para mejor compatibilidad

### Características Soportadas
- ✅ Secuencias y auto-incremento
- ✅ Triggers y funciones PL/pgSQL
- ✅ Índices B-tree
- ✅ Transacciones (BEGIN/COMMIT)
- ✅ Comentarios en tablas y columnas
- ✅ Constraints y foreign keys

### Limitaciones en PostgreSQL 9.5 y anteriores
- `IF NOT EXISTS` en `ALTER TABLE ADD COLUMN` no está disponible (se usa DO block)
- Algunas funciones JSON avanzadas pueden no estar disponibles
- Performance de índices puede ser menor que en versiones nuevas

---

## 🛠️ Solución de Problemas

### Error: "Connection refused" a PostgreSQL
```bash
# Verificar que PostgreSQL esté corriendo
sudo systemctl status postgresql

# Verificar puerto
sudo netstat -plnt | grep 5432

# Revisar logs
sudo tail -f /var/log/postgresql/postgresql-9.6-main.log
```

### Error: "502 Bad Gateway" en Nginx
```bash
# Verificar PHP-FPM
sudo systemctl status php7.4-fpm

# Revisar logs de Nginx
sudo tail -f /var/log/nginx/osm-error.log

# Verificar socket de PHP-FPM
ls -la /var/run/php/php7.4-fpm.sock
```

### Error: "Permission denied" en archivos
```bash
# Restablecer permisos
sudo chown -R www-data:www-data /var/www/osm-WEB
sudo chmod -R 755 /var/www/osm-WEB
sudo chmod -R 775 /var/www/osm-WEB/assets/uploads
```

### Error al importar SQL en Navicat
- Verificar que la conexión sea exitosa antes de importar
- Asegurarse de seleccionar la base de datos `osm2`
- Usar el script `update_osm_postgres9.sql` en lugar de otros
- Revisar mensajes de error específicos en la ventana de output

---

## 📝 Mantenimiento

### Backup de Base de Datos
```bash
# Crear backup
pg_dump -U postgres -d osm2 > osm2_backup_$(date +%Y%m%d).sql

# Restaurar backup
psql -U postgres -d osm2 < osm2_backup_20251028.sql
```

### Actualizar Aplicación
```bash
cd /var/www/osm-WEB
sudo git pull origin main
sudo chown -R www-data:www-data /var/www/osm-WEB
sudo systemctl reload nginx
```

### Logs
```bash
# Nginx access log
sudo tail -f /var/log/nginx/osm-access.log

# Nginx error log
sudo tail -f /var/log/nginx/osm-error.log

# PostgreSQL log
sudo tail -f /var/log/postgresql/postgresql-9.6-main.log
```

---

## 📚 Recursos Adicionales

- [Documentación de Nginx](https://nginx.org/en/docs/)
- [Documentación de PostgreSQL 9](https://www.postgresql.org/docs/9.6/)
- [PHP-FPM Configuration](https://www.php.net/manual/en/install.fpm.php)
- [Guía de Navicat](https://www.navicat.com/en/support)

---

## ✅ Checklist de Instalación

- [ ] Nginx instalado y corriendo
- [ ] PHP-FPM instalado y corriendo
- [ ] PostgreSQL 9.x instalado y corriendo
- [ ] Base de datos `osm2` creada
- [ ] Aplicación clonada en `/var/www/osm-WEB`
- [ ] Permisos configurados correctamente
- [ ] Configuración de Nginx creada y habilitada
- [ ] Conexión a base de datos configurada
- [ ] Script de actualización SQL ejecutado sin errores
- [ ] Aplicación accesible desde el navegador
- [ ] Login funciona correctamente
- [ ] Contraseñas por defecto cambiadas
- [ ] Firewall configurado
- [ ] SSL/TLS configurado (producción)
- [ ] Backup programado

---

**Nota**: Para producción, se recomienda usar PostgreSQL 11 o superior y configurar SSL/TLS para conexiones seguras.
