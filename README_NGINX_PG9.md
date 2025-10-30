# 🚀 Actualización Nginx y PostgreSQL 9 - README

## 📌 Inicio Rápido

Este PR agrega soporte completo para **Nginx** y compatibilidad con **PostgreSQL 9.x** para la aplicación OSM Web.

### ¿Qué hay de nuevo?

✅ **Configuración Nginx** lista para usar  
✅ **Script SQL consolidado** compatible con PostgreSQL 9.x  
✅ **Compatible con Navicat** y otras herramientas  
✅ **Documentación completa** en español  

---

## 📚 Documentación

### 🎯 Empezar Aquí

Si es tu primera vez implementando estos cambios, lee en este orden:

1. **[IMPLEMENTACION_COMPLETA_NGINX_PG9.md](IMPLEMENTACION_COMPLETA_NGINX_PG9.md)** ← EMPIEZA AQUÍ
   - Resumen ejecutivo de todo
   - Lista de archivos creados/modificados
   - Instrucciones de uso rápidas
   - Checklist completo

2. **[GUIA_NGINX_POSTGRES9.md](GUIA_NGINX_POSTGRES9.md)**
   - Guía paso a paso completa
   - Instalación de Nginx, PHP-FPM, PostgreSQL
   - Configuración de seguridad
   - Troubleshooting

3. **[RESUMEN_CAMBIOS_NGINX_PG9.md](RESUMEN_CAMBIOS_NGINX_PG9.md)**
   - Detalles técnicos de cada cambio
   - Comparaciones antes/después
   - Tabla de compatibilidad

4. **[VALIDACION_CAMBIOS.md](VALIDACION_CAMBIOS.md)**
   - Checklist de validación
   - Tests sugeridos
   - Comandos de verificación

---

## 📁 Archivos Importantes

### Archivos de Configuración

| Archivo | Descripción | Uso |
|---------|-------------|-----|
| `nginx.conf` | Configuración de Nginx | Copiar a `/etc/nginx/sites-available/` |
| `php/db_postgres.php` | Conexión PostgreSQL | Actualizar credenciales |

### Scripts SQL

| Archivo | Descripción | Cuándo Usar |
|---------|-------------|-------------|
| `db/osm_postgres.sql` | Schema completo (main) | Instalación nueva |
| `db/update_osm_postgres9.sql` | Actualización consolidada | Base de datos existente |
| `db/migration_adm_webmain.sql` | Migración web config | Opcional (incluido en update) |
| `db/migration_cap_id_colaborador.sql` | Migración capacitaciones | Opcional (incluido en update) |

### Documentación

| Archivo | Descripción |
|---------|-------------|
| `IMPLEMENTACION_COMPLETA_NGINX_PG9.md` | Resumen ejecutivo completo |
| `GUIA_NGINX_POSTGRES9.md` | Guía de instalación detallada |
| `RESUMEN_CAMBIOS_NGINX_PG9.md` | Detalles técnicos de cambios |
| `VALIDACION_CAMBIOS.md` | Checklist de validación |

---

## ⚡ Instalación Rápida

### Opción 1: Base de Datos Nueva

```bash
# 1. Instalar Nginx (si no está instalado)
sudo apt install nginx php7.4-fpm

# 2. Configurar Nginx
sudo cp nginx.conf /etc/nginx/sites-available/osm-web
sudo ln -s /etc/nginx/sites-available/osm-web /etc/nginx/sites-enabled/
sudo nginx -t && sudo systemctl reload nginx

# 3. Crear base de datos
sudo -u postgres createdb osm2

# 4. Importar schema completo
psql -U postgres -d osm2 -f db/osm_postgres.sql

# 5. Aplicar actualizaciones
psql -U postgres -d osm2 -f db/update_osm_postgres9.sql
```

### Opción 2: Actualizar Base de Datos Existente

```bash
# 1. Backup
pg_dump -U postgres -d osm2 > backup_$(date +%Y%m%d).sql

# 2. Aplicar actualización
psql -U postgres -d osm2 -f db/update_osm_postgres9.sql

# 3. Verificar
psql -U postgres -d osm2 -c "SELECT * FROM adm_webmain;"
```

### Opción 3: Usar Navicat

1. Abrir Navicat
2. Conectar a PostgreSQL
3. Seleccionar base de datos `osm2`
4. Execute SQL File → `db/update_osm_postgres9.sql`
5. Clic en "Start"
6. Revisar output

---

## ✅ Verificación

### Verificar Base de Datos
```sql
-- Debe retornar 1 fila
SELECT * FROM adm_webmain;

-- Debe retornar > 0
SELECT COUNT(*) FROM cap_formulario_asistente WHERE id_colaborador IS NOT NULL;

-- Debe retornar 6 índices
SELECT COUNT(*) FROM pg_indexes WHERE indexname LIKE 'idx_%' AND schemaname = 'public';
```

### Verificar Nginx
```bash
sudo nginx -t                  # Debe decir "OK"
sudo systemctl status nginx    # Debe estar "active"
curl -I http://localhost       # Debe retornar "200 OK"
```

### Verificar Aplicación
```bash
# Abrir en navegador: http://tu-servidor
# Login: 123456789 / Osm1234
```

---

## 🔧 Compatibilidad

### PostgreSQL
- ✅ PostgreSQL 9.5+
- ✅ PostgreSQL 9.6 (recomendado mínimo)
- ✅ PostgreSQL 10.x
- ✅ PostgreSQL 11.x (recomendado producción)
- ✅ PostgreSQL 12.x+

### Herramientas
- ✅ Navicat Premium
- ✅ Navicat for PostgreSQL
- ✅ pgAdmin 4
- ✅ DBeaver
- ✅ psql (command line)

### Servidores Web
- ✅ Nginx 1.18+
- ✅ PHP 7.4+ con PHP-FPM
- ✅ Ubuntu 20.04+
- ✅ Debian 10+
- ✅ CentOS 8+

---

## 🔒 Seguridad

### ✅ Implementado
- Headers de seguridad en Nginx
- Restricción de archivos sensibles
- Transacciones SQL completas
- Sin SQL injection (parámetros preparados)
- CodeQL scan pasado (sin vulnerabilidades)

### ⚠️ Requerido
- Cambiar contraseña de PostgreSQL por defecto
- Cambiar contraseña de usuario admin
- Configurar SSL/TLS (Let's Encrypt)
- Configurar firewall

```bash
# Cambiar contraseña de PostgreSQL
sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD 'NuevaContraseña';"

# Cambiar contraseña de admin
psql -U postgres -d osm2 -c "UPDATE adm_usuarios SET au_contra = MD5('NuevaContraseña') WHERE au_usuario = '123456789';"

# Instalar SSL con Let's Encrypt
sudo certbot --nginx -d tu-dominio.com

# Configurar firewall
sudo ufw allow 'Nginx Full'
sudo ufw enable
```

---

## 📊 Características

### Nginx
- 🔒 Headers de seguridad
- 🚀 Caché de archivos estáticos (30 días)
- 🗜️ Compresión GZIP
- ⏱️ Timeouts extendidos (300s)
- 📤 Límite de uploads: 20MB
- 🔐 SSL/TLS ready
- 📝 Logs separados

### PostgreSQL 9
- 🔄 Secuencias tradicionales
- 🔧 EXECUTE PROCEDURE
- ✅ DO blocks para compatibilidad
- 📋 information_schema checks
- 🚀 Índices optimizados (6 nuevos)
- 📝 Comentarios en schema

### SQL Update Script
- 🔄 Idempotente (ejecutable múltiples veces)
- 🔐 Transaccional (TODO o NADA)
- ✅ Verificaciones automáticas
- 📊 Reportes de mapeo
- 📝 Mensajes detallados
- 🗂️ 4 secciones organizadas

---

## 🆘 Ayuda

### Problemas Comunes

**Error: Connection refused a PostgreSQL**
```bash
sudo systemctl start postgresql
```

**Error: 502 Bad Gateway**
```bash
sudo systemctl start php7.4-fpm
```

**Error: Permission denied**
```bash
sudo chown -R www-data:www-data /var/www/osm-WEB
```

### Logs
```bash
# Nginx error log
sudo tail -f /var/log/nginx/osm-error.log

# PostgreSQL log
sudo tail -f /var/log/postgresql/postgresql-*.log

# PHP-FPM log
sudo tail -f /var/log/php7.4-fpm.log
```

---

## 📞 Soporte

### Documentación Completa
- 📖 [GUIA_NGINX_POSTGRES9.md](GUIA_NGINX_POSTGRES9.md) - Guía completa
- 📊 [RESUMEN_CAMBIOS_NGINX_PG9.md](RESUMEN_CAMBIOS_NGINX_PG9.md) - Detalles técnicos
- ✅ [VALIDACION_CAMBIOS.md](VALIDACION_CAMBIOS.md) - Checklist
- 🎯 [IMPLEMENTACION_COMPLETA_NGINX_PG9.md](IMPLEMENTACION_COMPLETA_NGINX_PG9.md) - Resumen ejecutivo

### Recursos Externos
- [Nginx Docs](https://nginx.org/en/docs/)
- [PostgreSQL 9 Docs](https://www.postgresql.org/docs/9.6/)
- [PHP-FPM](https://www.php.net/manual/en/install.fpm.php)

---

## 📝 Notas

### Importante
- ✅ `osm_postgres.sql` NO fue modificado (intacto)
- ✅ `update_osm_postgres9.sql` es SEPARADO y se ejecuta DESPUÉS
- ✅ Sin breaking changes - todo retrocompatible
- ✅ Scripts idempotentes - ejecutables múltiples veces
- ✅ Datos existentes preservados

### Próximos Pasos
1. Leer [IMPLEMENTACION_COMPLETA_NGINX_PG9.md](IMPLEMENTACION_COMPLETA_NGINX_PG9.md)
2. Seguir [GUIA_NGINX_POSTGRES9.md](GUIA_NGINX_POSTGRES9.md)
3. Ejecutar scripts SQL
4. Configurar Nginx
5. Verificar funcionamiento
6. Completar checklist de seguridad

---

## 🎉 ¡Listo!

Todos los cambios están **implementados**, **documentados** y **verificados**.

**Estado**: ✅ Completo  
**Listo para**: Staging/Producción  
**Fecha**: 2025-10-28

---

**¿Dudas?** Consulta la documentación detallada en los archivos mencionados.
