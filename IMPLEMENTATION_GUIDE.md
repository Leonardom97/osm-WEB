# Guía de Implementación del Módulo de Capacitaciones

## Descripción General

Esta guía detalla la implementación del módulo final de Programación de Capacitaciones según las especificaciones técnicas. El sistema utiliza `cap_notificaciones` como tabla operativa, mantiene la columna `cedula` para auditoría, y ejecuta recálculos desde PHP y mediante cron diario.

## Decisiones Clave

- **Umbral "próximo vencer"**: 30 días
- **Columna cedula**: NUNCA se elimina, se mantiene para auditoría
- **Tabla operativa**: `cap_notificaciones` (no se crea `cap_schedule`)
- **Recálculo**: Invocado desde PHP (endpoints `programacion_save.php` y `formulario_save.php`) y por cron diario
- **NO triggers obligatorios** en base de datos

## Fases de Implementación

### FASE A - Preparación (OBLIGATORIO)

1. **Backup de Base de Datos**
   ```bash
   pg_dump -U postgres -d your_database > backup_$(date +%Y%m%d_%H%M%S).sql
   ```

2. **Ejecutar en STAGING primero**
   - Aplicar todos los cambios en un entorno de staging idéntico a producción
   - Realizar pruebas completas
   - Solo después migrar a producción

3. **Notificar ventana de mantenimiento** (opcional, si es necesario)

### FASE B - Modificaciones en Base de Datos

**Ejecutar el script de migración:**

```bash
psql -U postgres -d your_database -f db/migration_cap_id_colaborador.sql
```

**¿Qué hace este script?**

1. Añade columna `id_colaborador` a `cap_formulario_asistente`
2. Pobla `id_colaborador` mapeando desde `adm_colaboradores` usando cédulas normalizadas
3. Añade columna `cedula` a `cap_notificaciones` (para auditoría)
4. Crea índices para performance:
   - `idx_cfa_id_colaborador`
   - `idx_notif_id_colaborador`
   - `idx_notif_fecha_proxima`
   - `idx_notif_estado`
   - `idx_cfa_cedula`
5. Genera reporte de cédulas sin mapear para revisión manual

**Revisar resultados:**

El script imprimirá estadísticas como:
```
cap_formulario_asistente mapping results:
Successfully mapped: 150 records
Unmapped (need manual review): 5 records
```

**Acción requerida:** Revisar las cédulas sin mapear y corregir en `adm_colaboradores` o en la tabla de asistentes.

### FASE C - Lógica de Cálculo

La función `actualizar_notificaciones_capacitacion()` ya existe e implementa las reglas correctas:

**Reglas implementadas:**
- `fecha_proxima = fecha_ultima + (frecuencia_meses months)`
- `dias_para_vencimiento = fecha_proxima - current_date`
- Estados:
  - `fecha_ultima IS NULL` → 'pendiente'
  - `dias_para_vencimiento < 0` → 'vencida'
  - `dias_para_vencimiento <= 30` → 'proximo_vencer'
  - `else` → 'vigente'

**No se requieren cambios** en la función.

### FASE D - Cambios en Backend PHP

#### 1. `programacion_api.php` (YA IMPLEMENTADO)

Los endpoints `create`, `update` y `delete` ya llaman a:
```php
$pg->query("SELECT actualizar_notificaciones_capacitacion()");
```

#### 2. `formulario_api.php` (MODIFICADO)

**Cambios implementados:**

1. Al guardar asistentes, se busca `id_colaborador` por cédula normalizada:
   ```php
   $cedula_normalizada = preg_replace('/\D/', '', $asistente['cedula']);
   // Lookup en adm_colaboradores
   ```

2. Se inserta `id_colaborador` en `cap_formulario_asistente`:
   ```sql
   INSERT INTO cap_formulario_asistente (
     id_formulario, cedula, id_colaborador, ...
   ) VALUES (?, ?, ?, ...)
   ```

3. Se registra en log las cédulas sin mapear

4. Después de insertar, se invoca:
   ```php
   $pg->query("SELECT actualizar_notificaciones_capacitacion()");
   ```

5. Se retorna información de auditoría:
   ```json
   {
     "success": true,
     "id_formulario": 123,
     "asistentes_mapeados": 10,
     "asistentes_total": 12,
     "asistentes_sin_mapear": [
       {"cedula": "12345678", "nombre": "JUAN PEREZ"}
     ],
     "warning": "Algunos asistentes no pudieron ser mapeados..."
   }
   ```

### FASE E - Frontend (YA IMPLEMENTADO)

**Archivos:**
- `programacion.html` - Interfaz de gestión con IDs correctos
- `programacion.js` - Lógica completa de CRUD y filtros

**IDs de formulario (como especificado):**
- Form: `form_programacion`
- Hidden: `prog_id` → `programacionId`
- Cargo: `select_cargo` → `inputCargo`
- Sub Área: `select_area` → `inputSubArea`
- Tema: `select_tema` → `inputTema`
- Frecuencia: `input_frecuencia` → `inputFrecuencia`
- Rol: `select_rol` → `inputRolCapacitador`
- Activo: `input_activo` (checkbox - implementado en backend)
- Guardar: `btn_guardar_programacion` → `btnGuardar`
- Tabla: `tb_programacion` → `#tableProgramaciones tbody`

### FASE F - Cron Job Diario

**Opción 1: Crontab manual**

1. Editar crontab:
   ```bash
   crontab -e
   ```

2. Agregar línea:
   ```bash
   5 0 * * * PGPASSWORD=$DB_PASSWORD psql -h localhost -U postgres -d your_database -c "SELECT actualizar_notificaciones_capacitacion();" >> /var/log/cap_notif_recalc.log 2>&1
   ```

**Opción 2: Usar script de configuración**

```bash
chmod +x db/cron_setup.sh
./db/cron_setup.sh
```

Editar el script primero con las credenciales correctas.

**Verificar que funciona:**
```bash
tail -f /var/log/cap_notif_recalc.log
```

### FASE G - Importación desde Excel

**Ya implementado en `programacion.html`:**

1. Clic en "Importar Excel"
2. Seleccionar archivo .xlsx con formato:
   - Columna A: ID Cargo
   - Columna B: Sub Área (opcional)
   - Columna C: ID Tema
   - Columna D: Frecuencia (meses)
   - Columna E: Nombre Rol Capacitador
3. Revisar vista previa
4. Clic en "Importar"

El endpoint `bulk_import` se encarga de:
- Validar datos
- Evitar duplicados
- Insertar programaciones
- Ejecutar recálculo global

### FASE H - Validaciones y QA

**Checklist de pruebas:**

- [ ] **AC1**: Crear programación → se actualiza `cap_programacion` y se ejecuta recálculo
- [ ] **AC2**: Guardar formulario → `id_colaborador` se puebla en >99% de casos
- [ ] **AC3**: `cap_notificaciones` se actualiza con fechas/estados correctos
- [ ] **AC4**: Cron diario actualiza estados consistentemente
- [ ] **AC5**: Importación Excel funciona sin duplicados
- [ ] **AC6**: Columna `cedula` nunca se elimina, permanece para auditoría

**Pruebas específicas:**

1. **Crear programación:**
   ```
   Cargo: POLINIZADOR
   Sub Área: POLINIZACION
   Tema: Seguridad Industrial
   Frecuencia: 12 meses
   Rol: Capacitador SIE
   → Verificar registro en cap_programacion
   → Verificar llamada a actualizar_notificaciones_capacitacion()
   ```

2. **Guardar formulario con asistentes:**
   ```
   Agregar 5 asistentes con cédulas válidas
   → Verificar id_colaborador poblado
   → Verificar cap_notificaciones actualizado
   → Verificar fecha_proxima = fecha + frecuencia
   ```

3. **Cambiar frecuencia:**
   ```
   Editar programación, cambiar frecuencia de 12 a 6 meses
   → Verificar fecha_proxima se recalcula
   ```

4. **Recalculo diario (simular):**
   ```sql
   SELECT actualizar_notificaciones_capacitacion();
   -- Verificar estados cambian según días
   ```

### FASE I - Reporting y Monitoreo

**Logs a monitorear:**

1. **PHP error log:**
   ```bash
   tail -f /var/log/php/error.log | grep "Cedula not found"
   ```

2. **Cron log:**
   ```bash
   tail -f /var/log/cap_notif_recalc.log
   ```

**Consultas útiles:**

1. **Ver cédulas sin mapear:**
   ```sql
   SELECT cedula, COUNT(*) as ocurrencias
   FROM cap_formulario_asistente
   WHERE id_colaborador IS NULL
   GROUP BY cedula
   ORDER BY ocurrencias DESC;
   ```

2. **Ver notificaciones próximas a vencer:**
   ```sql
   SELECT c.ac_cedula, c.ac_nombre1, c.ac_apellido1,
          t.nombre as tema, n.fecha_proxima, n.dias_para_vencimiento
   FROM cap_notificaciones n
   JOIN adm_colaboradores c ON n.id_colaborador = c.ac_id
   JOIN cap_programacion p ON n.id_programacion = p.id
   JOIN cap_tema t ON p.id_tema = t.id
   WHERE n.estado = 'proximo_vencer'
   ORDER BY n.dias_para_vencimiento;
   ```

3. **Performance de recálculo:**
   ```sql
   EXPLAIN ANALYZE 
   SELECT actualizar_notificaciones_capacitacion();
   ```

## Criterios de Aceptación

- **AC1**: ✅ `programacion_save` crea/edita y dispara recálculo puntual
- **AC2**: ⏳ `formulario_save` guarda asistentes con `id_colaborador` poblado para >99%
- **AC3**: ⏳ `cap_notificaciones` se actualiza correctamente
- **AC4**: ⏳ Cron diario actualiza estados consistentemente
- **AC5**: ✅ Importación Excel completa sin duplicados
- **AC6**: ✅ Columna `cedula` permanece para auditoría

## Plan de Rollback

**Si algo falla, ejecutar:**

```sql
BEGIN;

-- Eliminar índices
DROP INDEX IF EXISTS idx_cfa_id_colaborador;
DROP INDEX IF EXISTS idx_notif_id_colaborador;
DROP INDEX IF EXISTS idx_notif_fecha_proxima;
DROP INDEX IF EXISTS idx_notif_estado;
DROP INDEX IF EXISTS idx_cfa_cedula;

-- Eliminar columnas (ADVERTENCIA: esto borra datos)
-- Solo usar si es absolutamente necesario
ALTER TABLE cap_formulario_asistente DROP COLUMN IF EXISTS id_colaborador;
ALTER TABLE cap_notificaciones DROP COLUMN IF EXISTS cedula;

COMMIT;
```

**Luego restaurar backup:**
```bash
psql -U postgres -d your_database < backup_YYYYMMDD_HHMMSS.sql
```

## Notas Operativas

1. **Mantener `cedula` es correcto** - No eliminar, es para auditoría
2. **Recálculo puntual preferible** - Pero usamos global por simplicidad
3. **No triggers complejos** - Usamos PHP para mayor control
4. **Logs son importantes** - Revisar periódicamente asistentes sin mapeo
5. **Foreign keys opcionales** - Solo añadir después de mapear 100%

## Siguientes Pasos (Post-Implementación)

1. Monitorear logs durante primera semana
2. Corregir cédulas sin mapear según aparezcan
3. Re-ejecutar UPDATE para mapear cédulas corregidas
4. Considerar función de recálculo puntual (futura optimización)
5. Documentar proceso para equipo de soporte

## Contacto y Soporte

Para dudas o problemas durante la implementación, consultar:
- Este documento
- Comentarios en `migration_cap_id_colaborador.sql`
- Logs de error de PHP y PostgreSQL
