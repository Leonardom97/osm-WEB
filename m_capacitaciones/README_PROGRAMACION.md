# Sistema de Programación de Capacitaciones

## Descripción General

Este módulo permite gestionar la programación de capacitaciones según las necesidades de cada cargo y sub-área, con actualizaciones automáticas basadas en las capacitaciones realizadas.

## Características Principales

### 1. Gestión de Programación

El módulo de programación (`programacion.html`) permite:

- **Crear programaciones** especificando:
  - Cargo (desde tabla `adm_cargos`)
  - Sub-área (desde tabla `adm_área` columna `sub_area`)
  - Tema (desde tabla `cap_tema`)
  - Frecuencia en meses (cada cuánto tiempo se debe repetir)
  - Rol capacitador responsable (desde tabla `adm_roles`)

- **Visualizar programaciones** con la siguiente información:
  - Última capacitación realizada
  - Próxima capacitación programada
  - Fecha de notificación previa (1 mes antes de la próxima capacitación)
  - Colaboradores pendientes

### 2. Actualización Automática de Fechas

Cuando se crea un formulario de capacitación en `formulario.html`:

1. El sistema identifica la programación correspondiente comparando:
   - **Tema**: El tema de la capacitación debe coincidir
   - **Cargo**: El cargo de los asistentes debe coincidir
   - **Sub-área**: La sub-área de los asistentes debe coincidir

2. Si se encuentra coincidencia, **actualiza automáticamente**:
   - `fecha_ultima_capacitacion`: Se actualiza con la fecha más reciente
   - `fecha_proxima_capacitacion`: Se calcula sumando la frecuencia a la última capacitación
   - `fecha_notificacion_previa`: Se calcula como 1 mes antes de la próxima capacitación

### 3. Sistema de Notificaciones por Rol

Las notificaciones se muestran según el rol del usuario:

- Solo los usuarios con rol de **capacitador** asignado a una programación verán las alertas de esa programación
- Las alertas se activan cuando se alcanza la `fecha_notificacion_previa` (1 mes antes)
- Los roles de capacitador disponibles son:
  - Capacitador TI
  - Capacitador GH (Gestión Humana)
  - Capacitador SIE (Sistema Integrado)
  - Capacitador MT (Mantenimiento)
  - Capacitador IND (Industrial)
  - Capacitador ADM (Administrativo)
  - Capacitador AGR (Agronomía)

## Flujo de Trabajo

### Ejemplo Práctico

**Escenario**: Capacitación de PowerBI para Analistas de Información

1. **En programacion.html** se crea un registro:
   ```
   Tema: PowerBI
   Cargo: ANALISTA DE INFORMACION
   Sub-área: CLIPA - SISTEMAS
   Frecuencia: 12 meses
   Rol Capacitador: Capacitador TI
   ```

2. **El sistema calcula automáticamente**:
   ```
   Próxima Capacitación: [Hoy + 12 meses]
   Notificación Previa: [Hoy + 11 meses]
   ```

3. **Cuando el Capacitador TI** crea un formulario en `formulario.html`:
   - Selecciona tema "PowerBI"
   - Agrega asistentes que son "ANALISTA DE INFORMACION" de "CLIPA - SISTEMAS"
   - Marca el estado como "aprobo"

4. **El sistema actualiza automáticamente** la programación:
   ```
   Última Capacitación: [Fecha del formulario]
   Próxima Capacitación: [Fecha del formulario + 12 meses]
   Notificación Previa: [Fecha del formulario + 11 meses]
   ```

5. **Notificaciones**:
   - Solo el usuario con rol "Capacitador TI" verá la alerta
   - La alerta aparecerá 1 mes antes de la próxima capacitación
   - La alerta mostrará cuántos colaboradores están pendientes

## Estructura de Tablas

### cap_programacion
```sql
id                          INT
id_tema                     INT (referencia a cap_tema)
id_cargo                    VARCHAR (referencia a adm_cargos.id_cargo)
sub_area                    VARCHAR (referencia a adm_área.sub_area)
frecuencia_meses            INT (frecuencia en meses)
id_rol_capacitador          INT (referencia a adm_roles)
fecha_ultima_capacitacion   DATE (última capacitación realizada)
fecha_proxima_capacitacion  DATE (próxima capacitación programada)
fecha_notificacion_previa   DATE (1 mes antes de la próxima)
activo                      BOOLEAN
fecha_creacion              TIMESTAMP
```

### cap_formulario
```sql
id                  INT
id_proceso          INT
id_lugar            INT
id_usuario          INT
id_tipo_actividad   INT
id_tema             INT (referencia a cap_tema)
fecha               DATE (fecha de la capacitación)
...otros campos...
```

### cap_formulario_asistente
```sql
id                  INT
id_formulario       INT (referencia a cap_formulario)
cedula              VARCHAR
id_colaborador      INT (referencia a adm_colaboradores)
estado_aprobacion   VARCHAR ('aprobo', 'no_aprobo', 'no_aplica')
cargo               VARCHAR (nombre del cargo)
sub_área            VARCHAR (nombre de la sub-área)
...otros campos...
```

## Instalación y Configuración

### 1. Aplicar Migración de Base de Datos

Ejecutar el script de migración:

```bash
psql -U postgres -d osm_db -f db/04_update_cap_programacion.sql
```

Este script:
- Agrega las nuevas columnas a `cap_programacion`
- Agrega la columna `id_colaborador` a `cap_formulario_asistente`
- Crea la función `actualizar_fechas_programacion()`
- Crea el trigger que actualiza automáticamente las fechas
- Inicializa fechas para programaciones existentes

### 2. Verificar Configuración

1. Verificar que las columnas se crearon:
```sql
\d cap_programacion
```

2. Verificar que el trigger se creó:
```sql
SELECT * FROM pg_trigger WHERE tgname = 'trigger_actualizar_programacion';
```

## Notas Técnicas

### Lógica de Coincidencia

El trigger `actualizar_fechas_programacion()` usa la siguiente lógica para encontrar programaciones:

```sql
WHERE p.id_tema = [tema_del_formulario]
  AND p.id_cargo = [cargo_del_asistente]
  AND (p.sub_area = [sub_area_del_asistente] OR ambos son NULL)
  AND p.activo = true
  AND asistente.estado_aprobacion = 'aprobo'
```

### Frecuencia de Actualización

- Las fechas se actualizan **inmediatamente** al guardar un formulario
- Solo se actualizan si hay asistentes con estado "aprobo"
- Solo se actualizan programaciones activas

### Sistema de Notificaciones

Las notificaciones se basan en:
- `fecha_notificacion_previa`: Cuando esta fecha es menor o igual a hoy, se muestra la alerta
- Solo para el rol asignado en `id_rol_capacitador`
- Se muestran hasta 30 días después de vencidas

## Resolución de Problemas

### Las fechas no se actualizan automáticamente

Verificar:
1. El trigger está activo: `SELECT * FROM pg_trigger WHERE tgname = 'trigger_actualizar_programacion';`
2. Los asistentes tienen `id_colaborador` asignado
3. Los asistentes tienen estado 'aprobo'
4. El cargo y sub-área coinciden exactamente con la programación

### No veo notificaciones

Verificar:
1. Tu usuario tiene el rol asignado en la programación
2. La tabla `adm_usuario_roles` tiene tu rol correctamente asignado
3. La `fecha_notificacion_previa` ya pasó o es hoy

### Las fechas se calculan incorrectamente

Verificar:
1. La frecuencia está en meses (no días ni años)
2. El trigger está usando la versión correcta de la función

## Mantenimiento

### Regenerar todas las fechas

Si necesitas regenerar las fechas de todas las programaciones:

```sql
-- Recalcular basándose en capacitaciones existentes
SELECT inicializar_fechas_programacion();

-- O actualizar manualmente una programación específica
UPDATE cap_programacion
SET 
  fecha_proxima_capacitacion = fecha_ultima_capacitacion + (frecuencia_meses * INTERVAL '1 month'),
  fecha_notificacion_previa = fecha_ultima_capacitacion + (frecuencia_meses * INTERVAL '1 month') - INTERVAL '1 month'
WHERE id = [id_programacion];
```

### Actualizar notificaciones

Para recalcular todas las notificaciones:

```sql
SELECT actualizar_notificaciones_capacitacion();
```

## Soporte

Para problemas o preguntas, revisar:
1. Los logs de PostgreSQL para errores del trigger
2. La consola del navegador para errores de JavaScript
3. Los archivos de log de PHP para errores de API
