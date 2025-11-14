# Deployment Files for osm-WEB

Este directorio contiene todos los archivos necesarios para desplegar la aplicación osm-WEB en un servidor con Nginx.

## 📁 Estructura de Archivos

```
deployment/
├── README.md                          # Este archivo
├── DEPLOYMENT_GUIDE_ES.md            # Guía completa de despliegue en español
├── nginx/
│   ├── osm-web.conf                  # Configuración de Nginx
│   ├── NGINX_CONFIGURATION.md        # Documentación de configuración
│   └── deploy.sh                     # Script de despliegue automático
└── systemd/
    └── osm-web.service               # Servicio systemd (opcional)
```

## 🚀 Inicio Rápido

### Opción 1: Despliegue Automático (Recomendado)

```bash
# 1. Navegar al directorio de nginx
cd deployment/nginx

# 2. Ejecutar el script de despliegue
sudo chmod +x deploy.sh
sudo ./deploy.sh

# 3. Seguir las instrucciones en pantalla
```

El script configurará automáticamente:
- ✅ Nginx
- ✅ PHP-FPM
- ✅ Permisos de archivos
- ✅ Directorios necesarios
- ✅ Configuración de seguridad

### Opción 2: Despliegue Manual

Si prefieres configurar manualmente, consulta:
- **Guía completa:** [DEPLOYMENT_GUIDE_ES.md](./DEPLOYMENT_GUIDE_ES.md)
- **Configuración Nginx:** [nginx/NGINX_CONFIGURATION.md](./nginx/NGINX_CONFIGURATION.md)

## 📋 Requisitos del Sistema

### Software Necesario
- **Sistema Operativo:** Ubuntu 20.04+ o Debian 10+
- **Servidor Web:** Nginx
- **PHP:** 8.1 o superior
- **Bases de Datos:**
  - PostgreSQL 12+
  - SQL Server (con driver PHP)

### Extensiones PHP Requeridas
- php-fpm
- php-pgsql
- php-sqlsrv
- php-mbstring
- php-xml
- php-curl
- php-gd
- php-zip

El script de despliegue instalará automáticamente todas estas dependencias.

## 🔧 Archivos de Configuración

### nginx/osm-web.conf
Archivo de configuración principal de Nginx que incluye:
- Redirección HTTP a HTTPS
- Configuración SSL/TLS
- Headers de seguridad
- Compresión gzip
- Reglas de caché
- Protección contra ejecución de PHP en uploads
- Límites de tamaño de archivos

**Personalización requerida:**
- Reemplazar `your-domain.com` con tu dominio
- Actualizar rutas de certificados SSL
- Ajustar ruta de aplicación si es diferente de `/var/www/osm-WEB`

### systemd/osm-web.service
Servicio systemd opcional para gestión de la aplicación. Incluye:
- Verificación de archivo .env
- Creación de directorios de logs
- Arranque automático con el sistema

## 📖 Guías Disponibles

### 1. DEPLOYMENT_GUIDE_ES.md (Guía Principal)
Guía completa en español que cubre:
- Preparación del servidor
- Instalación de dependencias
- Configuración paso a paso
- Solución de problemas comunes
- Comandos útiles
- Actualización de la aplicación
- Lista de verificación

### 2. nginx/NGINX_CONFIGURATION.md
Documentación técnica de la configuración de Nginx:
- Explicación detallada de cada directiva
- Opciones de configuración SSL
- Configuración de PHP-FPM
- Ajustes de seguridad

## 🔒 Seguridad

Los archivos de configuración incluyen:
- ✅ Headers de seguridad (HSTS, CSP, X-Frame-Options)
- ✅ Prevención de ejecución de PHP en directorios de uploads
- ✅ Protección de archivos sensibles (.env, .git)
- ✅ Configuración SSL/TLS segura
- ✅ Límites de tamaño de archivos
- ✅ Compresión gzip

**Importante:** Después del despliegue, completa la lista de verificación en:
- `../SECURITY_DEPLOYMENT_CHECKLIST.md`

## 🛠️ Uso del Script de Despliegue

### deploy.sh

Script bash interactivo que automatiza el proceso completo de despliegue.

**Características:**
- Instalación automática de paquetes
- Configuración de permisos
- Configuración de PHP-FPM
- Configuración de Nginx
- Verificación de configuración
- Reinicio de servicios

**Ejecución:**
```bash
cd deployment/nginx
sudo chmod +x deploy.sh
sudo ./deploy.sh
```

**Requisitos:**
- Debe ejecutarse como root (usa sudo)
- Conexión a internet para descargar paquetes
- Acceso de escritura a directorios del sistema

## 📝 Configuración Post-Despliegue

Después de ejecutar el despliegue:

1. **Configurar .env:**
```bash
cd /var/www/osm-WEB
sudo cp .env.example .env
sudo nano .env
# Editar con tus credenciales
sudo chmod 600 .env
```

2. **Configurar dominio en Nginx:**
```bash
sudo nano /etc/nginx/sites-available/osm-web
# Reemplazar your-domain.com con tu dominio real
```

3. **Obtener certificado SSL:**
```bash
sudo apt install certbot python3-certbot-nginx
sudo certbot --nginx -d tu-dominio.com
```

4. **Reiniciar servicios:**
```bash
sudo systemctl restart nginx
sudo systemctl restart php8.1-fpm
```

5. **Verificar:**
- Acceder a https://tu-dominio.com
- Revisar logs: `sudo tail -f /var/log/nginx/osm-web-error.log`
- Probar funcionalidades principales

## 🔍 Verificación del Despliegue

### Checklist Rápido
```bash
# 1. Verificar Nginx
sudo systemctl status nginx
sudo nginx -t

# 2. Verificar PHP-FPM
sudo systemctl status php8.1-fpm

# 3. Verificar archivo .env
test -f /var/www/osm-WEB/.env && echo "✓ .env exists" || echo "✗ .env missing"

# 4. Verificar permisos
ls -la /var/www/osm-WEB/.env

# 5. Ver logs
sudo tail -f /var/log/nginx/osm-web-error.log
```

## 🐛 Solución de Problemas

### Problema: 502 Bad Gateway
```bash
# Verificar PHP-FPM
sudo systemctl status php8.1-fpm
sudo systemctl restart php8.1-fpm

# Ver logs
sudo tail -f /var/log/nginx/osm-web-error.log
```

### Problema: Permission Denied
```bash
# Restaurar permisos
sudo chown -R www-data:www-data /var/www/osm-WEB
sudo chmod -R 755 /var/www/osm-WEB
sudo chmod 600 /var/www/osm-WEB/.env
```

### Problema: Database Connection Failed
```bash
# Verificar .env
sudo cat /var/www/osm-WEB/.env

# Probar conexión
psql -h localhost -U usuario -d osm2

# Ver logs PHP
sudo tail -f /var/www/osm-WEB/logs/php_errors.log
```

Para más soluciones, consulta [DEPLOYMENT_GUIDE_ES.md](./DEPLOYMENT_GUIDE_ES.md)

## 📞 Soporte

Si encuentras problemas:

1. **Consulta la documentación:**
   - [DEPLOYMENT_GUIDE_ES.md](./DEPLOYMENT_GUIDE_ES.md) - Guía completa
   - [../SECURITY_DEPLOYMENT_CHECKLIST.md](../SECURITY_DEPLOYMENT_CHECKLIST.md) - Checklist de seguridad
   - [../SECURITY_AUDIT_REPORT.md](../SECURITY_AUDIT_REPORT.md) - Informe de seguridad

2. **Revisa los logs:**
   - Nginx: `/var/log/nginx/osm-web-error.log`
   - PHP: `/var/www/osm-WEB/logs/php_errors.log`
   - System: `journalctl -u nginx` o `journalctl -u php8.1-fpm`

3. **Verifica configuración:**
   - `sudo nginx -t`
   - `php -v`
   - `sudo systemctl status php8.1-fpm`

## 🔄 Actualización

Para actualizar la aplicación después del despliegue inicial:

```bash
# 1. Backup
cd /var/www
sudo tar -czf osm-WEB-backup-$(date +%Y%m%d).tar.gz osm-WEB/

# 2. Actualizar código
cd osm-WEB
sudo git pull origin main

# 3. Verificar .env
# Agregar nuevas variables si es necesario

# 4. Reiniciar
sudo systemctl reload nginx
sudo systemctl restart php8.1-fpm
```

## ✅ Lista de Verificación Final

Antes de considerar el despliegue completo:

- [ ] Script de despliegue ejecutado exitosamente
- [ ] Archivo .env configurado con credenciales correctas
- [ ] Nginx configurado con tu dominio
- [ ] SSL/HTTPS funcionando
- [ ] Aplicación accesible via navegador
- [ ] Login funciona correctamente
- [ ] Upload de archivos funciona
- [ ] Base de datos conecta correctamente
- [ ] Sin errores en logs
- [ ] Backups configurados
- [ ] Documentación de despliegue guardada

---

**¡Tu aplicación osm-WEB está lista para producción!** 🚀

Para más detalles, consulta la [guía completa de despliegue](./DEPLOYMENT_GUIDE_ES.md).
