# Guía de Instalación - Sistema de Capacitaciones v2.0

## Pre-requisitos

- PostgreSQL 12 o superior
- PHP 7.4 o superior con extensión PDO-PGSQL
- Servidor web (Apache/Nginx)
- Acceso de administrador a la base de datos

## Pasos de Instalación

### 1. Backup de la Base de Datos

**IMPORTANTE:** Realizar backup antes de cualquier migración

```bash
pg_dump -U postgres -d osm_db > backup_antes_migracion_$(date +%Y%m%d).sql
```

### 2. Aplicar Migraciones

#### Migración 1: Sub-área por ID

```bash
psql -U postgres -d osm_db -f db/06_fix_sub_area_references.sql
```

**Esta migración realiza:**
- Agrega columna `id_sub_area` a `cap_programacion`
- Migra datos existentes de texto a IDs
- Renombra columna antigua a `sub_area_old` (backup)
- Actualiza función `actualizar_fechas_programacion()`
- Crea función `get_sub_area_nombre()`

**Verificación:**
```sql
-- Verificar migración exitosa
SELECT 
    id, 
    id_cargo, 
    sub_area AS new_id, 
    sub_area_old AS old_text,
    get_sub_area_nombre(sub_area) AS nombre
FROM cap_programacion 
LIMIT 10;
```

#### Migración 2: Deshabilitar Actualización Automática

```bash
psql -U postgres -d osm_db -f db/07_disable_auto_date_updates.sql
```

**Esta migración realiza:**
- Elimina trigger `trigger_actualizar_programacion`
- Crea función `actualizar_fechas_programacion_manual()`
- Permite actualización manual controlada

**Verificación:**
```sql
-- Verificar que el trigger fue removido
SELECT tgname 
FROM pg_trigger 
WHERE tgname = 'trigger_actualizar_programacion';
-- Debe retornar 0 filas

-- Verificar que la función manual existe
SELECT proname 
FROM pg_proc 
WHERE proname = 'actualizar_fechas_programacion_manual';
-- Debe retornar 1 fila
```

### 3. Actualizar Archivos del Sistema

Los siguientes archivos fueron modificados/creados:

#### Archivos Nuevos:
```
m_capacitaciones/
  ├── modulo_malla.html          (NUEVO)
  ├── dashboard.html             (NUEVO)
  ├── assets/
  │   ├── js/
  │   │   ├── modulo_malla.js    (NUEVO)
  │   │   └── dashboard.js       (NUEVO)
  │   └── php/
  │       └── malla_api.php      (NUEVO)
db/
  ├── 06_fix_sub_area_references.sql  (NUEVO)
  └── 07_disable_auto_date_updates.sql (NUEVO)
```

#### Archivos Modificados:
```
m_capacitaciones/
  ├── programacion.html          (MODIFICADO)
  ├── plantilla_importacion.csv  (MODIFICADO)
  ├── assets/
  │   ├── js/
  │   │   └── programacion.js    (MODIFICADO)
  │   └── php/
  │       ├── programacion_api.php    (MODIFICADO)
  │       └── notificaciones_api.php  (MODIFICADO)
assets/
  └── js/
      └── user_trainings.js      (MODIFICADO)
```

### 4. Verificar Permisos

Asegurar que los siguientes roles tienen acceso a los nuevos módulos:

```sql
-- Verificar roles existentes
SELECT * FROM adm_roles 
WHERE nombre LIKE 'Capacitador%' 
   OR nombre IN ('Administrador', 'Aux_Capacitador');

-- Si falta algún rol, agregarlo:
INSERT INTO adm_roles (nombre, descripcion) 
VALUES ('Capacitador_XX', 'Capacitador de área XX');
```

### 5. Configurar Navegación (Opcional)

Agregar enlaces a los nuevos módulos en el sidebar:

Editar el archivo de sidebar para incluir:

```html
<!-- En la sección de Capacitaciones -->
<li>
    <a href="/m_capacitaciones/programacion.html">
        <i class="fas fa-calendar-alt"></i> Programación
    </a>
</li>
<li>
    <a href="/m_capacitaciones/modulo_malla.html">
        <i class="fas fa-table"></i> Módulo Malla
    </a>
</li>
<li>
    <a href="/m_capacitaciones/dashboard.html">
        <i class="fas fa-chart-bar"></i> Dashboard
    </a>
</li>
<li>
    <a href="/m_capacitaciones/formulario.html">
        <i class="fas fa-file-alt"></i> Formulario
    </a>
</li>
```

### 6. Inicializar Datos de Programación

Si ya tienes programaciones existentes sin fechas:

```sql
-- Inicializar fechas para programaciones sin fecha
UPDATE cap_programacion
SET 
    fecha_proxima_capacitacion = CURRENT_DATE + (frecuencia_meses || ' months')::INTERVAL,
    fecha_notificacion_previa = CURRENT_DATE + (frecuencia_meses || ' months')::INTERVAL - INTERVAL '1 month'
WHERE fecha_proxima_capacitacion IS NULL
AND activo = true;
```

### 7. Actualizar Plantilla de Importación

La nueva plantilla usa IDs de sub-área en lugar de nombres:

**Formato Anterior:**
```csv
ID_Cargo,Sub_Area,ID_Tema,Frecuencia_Meses,Rol_Capacitador
117,Mantenimiento Industrial,1,12,Capacitador GH
```

**Formato Nuevo:**
```csv
ID_Cargo,ID_Sub_Area,ID_Tema,Frecuencia_Meses,Rol_Capacitador
117,003,1,12,Capacitador GH
```

**Obtener IDs de sub-áreas:**
```sql
SELECT id_area, area, sub_area 
FROM adm_área 
WHERE sub_area IS NOT NULL 
ORDER BY sub_area;
```

### 8. Pruebas Post-Instalación

#### Prueba 1: Crear Programación

1. Acceder a `programacion.html`
2. Clic en "Nueva Programación"
3. Completar formulario con sub-área
4. Verificar que se guarda correctamente
5. Verificar que aparece en la tabla con el nombre correcto de sub-área

#### Prueba 2: Módulo Malla

1. Acceder a `modulo_malla.html`
2. Verificar que carga colaboradores activos
3. Verificar que muestra capacitaciones asignadas
4. Aplicar filtros y verificar funcionamiento
5. Exportar a Excel y verificar contenido

#### Prueba 3: Dashboard

1. Acceder a `dashboard.html`
2. Verificar estadísticas en cards superiores
3. Verificar Top 10 de cargos y temas
4. Aplicar filtros y verificar tabla
5. Exportar ambos tipos de Excel y verificar contenido

#### Prueba 4: Portal de Usuario

1. Iniciar sesión como colaborador
2. Acceder a `usuarios.html`
3. Verificar que se muestran capacitaciones pendientes
4. Verificar que se muestran capacitaciones programadas

### 9. Configuración de Notificaciones (Opcional)

Para notificaciones automáticas por email, configurar cron job:

```bash
# Ejecutar diariamente a las 8:00 AM
0 8 * * * psql -U postgres -d osm_db -c "SELECT actualizar_notificaciones_capacitacion();"
```

### 10. Monitoreo

#### Logs a Revisar:

**PostgreSQL:**
```bash
tail -f /var/log/postgresql/postgresql-*.log
```

**PHP (Apache):**
```bash
tail -f /var/log/apache2/error.log
```

**Navegador:**
- Abrir DevTools (F12)
- Revisar Console y Network tabs

#### Queries de Monitoreo:

```sql
-- Ver estadísticas generales
SELECT 
    COUNT(DISTINCT ac_id) as total_colaboradores,
    COUNT(*) as total_asignaciones,
    COUNT(CASE WHEN estado = 'al_dia' THEN 1 END) as al_dia,
    COUNT(CASE WHEN estado = 'pendiente' THEN 1 END) as pendientes,
    COUNT(CASE WHEN estado = 'vencida' THEN 1 END) as vencidas
FROM (
    SELECT 
        c.ac_id,
        CASE 
            WHEN uc.ultima_fecha IS NULL AND p.fecha_ultima_capacitacion IS NULL THEN 'pendiente'
            WHEN COALESCE(uc.ultima_fecha, p.fecha_ultima_capacitacion) + (p.frecuencia_meses || ' months')::INTERVAL < CURRENT_DATE THEN 'vencida'
            ELSE 'al_dia'
        END AS estado
    FROM adm_colaboradores c
    INNER JOIN cap_programacion p ON p.id_cargo = c.ac_id_cargo 
    LEFT JOIN (
        SELECT fa.id_colaborador, f.id_tema, MAX(f.fecha) AS ultima_fecha
        FROM cap_formulario_asistente fa
        INNER JOIN cap_formulario f ON fa.id_formulario = f.id
        WHERE fa.estado_aprovacion = 'aprobo'
        GROUP BY fa.id_colaborador, f.id_tema
    ) uc ON c.ac_id = uc.id_colaborador AND p.id_tema = uc.id_tema
    WHERE c.ac_id_situación IN ('A', 'V', 'P')
    AND p.activo = true
) stats;

-- Ver últimas capacitaciones registradas
SELECT 
    f.id,
    f.fecha,
    t.nombre AS tema,
    COUNT(fa.id) AS asistentes,
    COUNT(CASE WHEN fa.estado_aprovacion = 'aprobo' THEN 1 END) AS aprobados
FROM cap_formulario f
LEFT JOIN cap_tema t ON f.id_tema = t.id
LEFT JOIN cap_formulario_asistente fa ON fa.id_formulario = f.id
WHERE f.fecha >= CURRENT_DATE - INTERVAL '30 days'
GROUP BY f.id, f.fecha, t.nombre
ORDER BY f.fecha DESC
LIMIT 10;
```

## Rollback

Si necesitas revertir los cambios:

### Revertir Migración 2 (Triggers):

```sql
-- Restaurar el trigger automático
CREATE TRIGGER trigger_actualizar_programacion
AFTER INSERT ON cap_formulario_asistente
FOR EACH ROW
EXECUTE FUNCTION actualizar_fechas_programacion();
```

### Revertir Migración 1 (Sub-área):

```sql
-- Restaurar columna de texto
ALTER TABLE cap_programacion 
RENAME COLUMN sub_area TO sub_area_id_backup;

ALTER TABLE cap_programacion 
RENAME COLUMN sub_area_old TO sub_area;
```

### Restaurar desde Backup:

```bash
# Restaurar base de datos completa
psql -U postgres -d osm_db < backup_antes_migracion_YYYYMMDD.sql
```

## Soporte Post-Instalación

### Errores Comunes:

**Error: "Column sub_area does not exist"**
- Solución: Aplicar migración 06_fix_sub_area_references.sql

**Error: "No hay datos en la malla"**
- Verificar que existen programaciones activas
- Verificar que colaboradores tienen situación A, V o P
- Verificar matching de cargo y sub_area

**Error: "Cannot read property 'data' of undefined"**
- Verificar que las APIs responden correctamente
- Abrir DevTools y revisar Network tab
- Verificar permisos de sesión

### Contacto

Para soporte adicional:
- Revisar README_COMPLETE_SYSTEM.md
- Revisar README_PROGRAMACION.md
- Consultar logs del sistema
- Contactar al administrador del sistema

## Checklist de Instalación

- [ ] Backup de base de datos realizado
- [ ] Migración 06 aplicada y verificada
- [ ] Migración 07 aplicada y verificada
- [ ] Archivos nuevos copiados al servidor
- [ ] Archivos modificados actualizados
- [ ] Permisos de roles verificados
- [ ] Navegación actualizada (opcional)
- [ ] Datos de programación inicializados
- [ ] Plantilla de importación actualizada
- [ ] Prueba 1: Programación - OK
- [ ] Prueba 2: Módulo Malla - OK
- [ ] Prueba 3: Dashboard - OK
- [ ] Prueba 4: Portal Usuario - OK
- [ ] Notificaciones configuradas (opcional)
- [ ] Monitoreo configurado
- [ ] Documentación revisada
- [ ] Sistema en producción

## Notas Finales

- Mantener backups regulares
- Monitorear logs las primeras semanas
- Capacitar a usuarios clave
- Documentar cualquier cambio adicional
- Actualizar documentación según necesidad
