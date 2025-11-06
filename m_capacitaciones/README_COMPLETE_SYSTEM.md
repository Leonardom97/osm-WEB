# Sistema Completo de Gestión de Capacitaciones

## Descripción General

Este sistema proporciona una solución completa para la gestión, seguimiento y reporte de capacitaciones del personal, incluyendo programación automática, matriz de capacitaciones y dashboards ejecutivos.

## Nuevos Módulos Implementados

### 1. Módulo de Programación (programacion.html)
**Mejoras Implementadas:**
- **Almacenamiento por ID**: Sub-área ahora se almacena como ID (referencia a `adm_área.id_area`) en lugar de texto
- **Registro Manual de Fechas**: Campo para registrar manualmente la última fecha de capacitación
- **Cálculo Automático**: Las fechas futuras se calculan automáticamente basadas en la frecuencia
- **Deshabilitación de Triggers**: Ya no se actualizan automáticamente las fechas cuando se crea un formulario

**Campos del Formulario:**
- Cargo (requerido)
- Sub Área (requerido) - ahora usa IDs
- Tema (requerido)
- Frecuencia en meses (requerido)
- Rol Capacitador (requerido)
- Fecha Última Capacitación (opcional) - nuevo campo

### 2. Módulo Malla de Capacitaciones (modulo_malla.html)
**Funcionalidad:**
- Muestra todos los colaboradores activos (situación A, V, P) con sus capacitaciones asignadas
- Calcula automáticamente el estado de cada capacitación
- Determina cuándo fue la última capacitación y cuándo es la próxima
- Exporta a Excel toda la información

**Estados de Capacitación:**
- **Al Día**: La capacitación está vigente
- **Próximo a Vencer**: Faltan 30 días o menos
- **Pendiente**: Nunca se ha realizado
- **Vencida**: Ya pasó la fecha de vencimiento

**Filtros Disponibles:**
- Estado
- Cargo
- Sub Área
- Tema
- Rol Capacitador

### 3. Dashboard de Capacitaciones (dashboard.html)
**Características:**
- **Estadísticas Resumidas**: Cards con totales de colaboradores, capacitaciones al día, pendientes y vencidas
- **Top 10**: Cargos y temas con más capacitaciones pendientes
- **Tabla Detallada**: Todos los registros con información completa
- **Filtros Avanzados**: Por estado, situación, cargo, sub-área, tema y rol
- **Exportaciones**:
  - Excel Detallado: Un registro por cada colaborador-tema
  - Excel Resumen: Un registro por colaborador con contadores

### 4. Portal de Usuario (usuarios.html - mejorado)
**Mejoras:**
- **Capacitaciones Pendientes**: Muestra las capacitaciones que el usuario debe tomar
- **Capacitaciones Programadas**: Todas las capacitaciones asignadas al usuario
- **Información Completa**: Última fecha, próxima fecha, estado y responsable

## Estructura de Base de Datos

### Tablas Principales

#### cap_programacion
```sql
id                          INT
id_tema                     INT (referencia a cap_tema)
id_cargo                    VARCHAR (referencia a adm_cargos.id_cargo)
sub_area                    VARCHAR (referencia a adm_área.id_area) -- AHORA USA IDs
frecuencia_meses            INT
id_rol_capacitador          INT (referencia a adm_roles)
fecha_ultima_capacitacion   DATE -- Registro manual
fecha_proxima_capacitacion  DATE -- Calculado automáticamente
fecha_notificacion_previa   DATE -- Calculado automáticamente
activo                      BOOLEAN
fecha_creacion              TIMESTAMP
```

#### adm_colaboradores
```sql
ac_id                       INT
ac_cedula                   VARCHAR
ac_nombre1, ac_nombre2      VARCHAR
ac_apellido1, ac_apellido2  VARCHAR
ac_empresa                  VARCHAR
ac_id_cargo                 VARCHAR (referencia a adm_cargos)
ac_sub_area                 VARCHAR (referencia a adm_área.id_area)
ac_id_situación             VARCHAR ('A', 'V', 'P', etc.)
ac_rango                    VARCHAR
ac_id_rol                   INT
```

#### cap_formulario_asistente
```sql
id                  INT
id_formulario       INT (referencia a cap_formulario)
cedula              VARCHAR
id_colaborador      INT (referencia a adm_colaboradores)
estado_aprovacion   VARCHAR ('aprobo', 'no_aprobo', 'no_aplica')
cargo               VARCHAR
sub_área            VARCHAR
```

## Lógica de Negocio

### Algoritmo de Matching (Malla)

El sistema hace matching entre colaboradores y programaciones de capacitación usando:

```sql
WHERE programacion.id_cargo = colaborador.ac_id_cargo 
AND (programacion.sub_area = colaborador.ac_sub_area 
     OR ambos son NULL)
AND programacion.activo = true
AND colaborador.ac_id_situación IN ('A', 'V', 'P')
```

### Cálculo de Estados

1. **Pendiente**: No hay registro de capacitación (ni en `fecha_ultima_capacitacion` ni en `cap_formulario_asistente`)

2. **Vencida**: 
   ```
   fecha_ultima_capacitacion + frecuencia_meses < fecha_actual
   ```

3. **Próximo a Vencer**: 
   ```
   fecha_proxima - fecha_actual <= 30 días
   ```

4. **Al Día**: Cualquier otro caso donde hay registro de capacitación

### Cálculo de Fechas

Cuando se registra una `fecha_ultima_capacitacion` en programación:
```javascript
fecha_proxima_capacitacion = fecha_ultima_capacitacion + frecuencia_meses
fecha_notificacion_previa = fecha_proxima_capacitacion - 1 mes
```

## Migraciones de Base de Datos

### Aplicar Migraciones

Ejecutar en orden:

```bash
# 1. Migración de sub_area a IDs
psql -U postgres -d osm_db -f db/06_fix_sub_area_references.sql

# 2. Deshabilitar triggers automáticos
psql -U postgres -d osm_db -f db/07_disable_auto_date_updates.sql
```

### Verificación

```sql
-- Verificar que sub_area ahora almacena IDs
SELECT id, id_cargo, sub_area, sub_area_old FROM cap_programacion;

-- Verificar que el trigger fue removido
SELECT * FROM pg_trigger WHERE tgname = 'trigger_actualizar_programacion';
-- Debe retornar 0 filas

-- Verificar programaciones con fechas
SELECT 
    p.id,
    c.cargo,
    a.sub_area,
    t.nombre AS tema,
    p.fecha_ultima_capacitacion,
    p.fecha_proxima_capacitacion,
    p.frecuencia_meses
FROM cap_programacion p
LEFT JOIN adm_cargos c ON p.id_cargo = c.id_cargo
LEFT JOIN adm_área a ON p.sub_area = a.id_area
LEFT JOIN cap_tema t ON p.id_tema = t.id
WHERE p.activo = true;
```

## APIs Disponibles

### programacion_api.php

**Endpoints:**
- `list`: Lista todas las programaciones activas
- `get`: Obtiene una programación específica
- `create`: Crea una nueva programación
- `update`: Actualiza una programación existente
- `delete`: Desactiva una programación
- `bulk_import`: Importa múltiples programaciones desde Excel
- `get_cargos`: Lista todos los cargos
- `get_temas`: Lista todos los temas
- `get_sub_areas`: Lista todas las sub-áreas (con IDs)
- `get_roles`: Lista roles de capacitadores

### malla_api.php

**Endpoints:**
- `get_malla`: Obtiene la matriz completa de capacitaciones
- `get_summary`: Obtiene estadísticas resumidas
- `get_user_pending_trainings`: Capacitaciones pendientes de un usuario específico
- `get_filters`: Obtiene opciones para filtros

**Ejemplo de Respuesta `get_malla`:**
```json
{
  "success": true,
  "data": [
    {
      "ac_id": 123,
      "ac_cedula": "1234567890",
      "situacion": "A",
      "nombre_completo": "Juan Pérez García",
      "cargo_nombre": "ANALISTA DE INFORMACIÓN",
      "sub_area_nombre": "CLIPA - SISTEMAS",
      "tema_nombre": "PowerBI",
      "frecuencia_meses": 12,
      "rol_capacitador_nombre": "Capacitador TI",
      "ultima_capacitacion": "2024-06-15",
      "proxima_capacitacion": "2025-06-15",
      "dias_restantes": 150,
      "estado": "al_dia"
    }
  ]
}
```

## Plantilla de Importación

### Formato CSV/Excel

El archivo `plantilla_importacion.csv` debe tener el siguiente formato:

```csv
ID_Cargo,ID_Sub_Area,ID_Tema,Frecuencia_Meses,Rol_Capacitador
117,003,1,12,Capacitador GH
141,,14,12,Capacitador TI
116,011,20,12,Capacitador TI
```

**Notas:**
- `ID_Cargo`: ID del cargo de `adm_cargos.id_cargo`
- `ID_Sub_Area`: ID del área de `adm_área.id_area` (puede estar vacío)
- `ID_Tema`: ID del tema de `cap_tema.id`
- `Frecuencia_Meses`: Número entero (1-120)
- `Rol_Capacitador`: Nombre exacto del rol

## Flujo de Trabajo Completo

### 1. Configuración Inicial

```
Administrador en programacion.html:
1. Crear programación (cargo + sub_area + tema + frecuencia + rol)
2. Opcionalmente registrar fecha_ultima_capacitacion
3. Sistema calcula fecha_proxima y fecha_notificacion
```

### 2. Ejecución de Capacitación

```
Capacitador en formulario.html:
1. Registrar capacitación (tema, fecha, responsable)
2. Agregar asistentes con estado "aprobo"
3. Guardar formulario
4. La malla se actualiza automáticamente con nueva fecha
```

### 3. Seguimiento

```
Personal autorizado:
- Ver modulo_malla.html para seguimiento detallado
- Ver dashboard.html para reportes ejecutivos
- Exportar a Excel para análisis externo

Colaboradores en usuarios.html:
- Ver sus capacitaciones pendientes
- Ver su histórico de capacitaciones
- Conocer próximas fechas
```

### 4. Notificaciones

```
Sistema automático:
- Genera notificaciones 1 mes antes del vencimiento
- Solo para usuarios con el rol asignado en la programación
- Visible en programacion.html como alertas
```

## Reportes y Exportaciones

### Exportación desde Malla
**Contenido:** Todos los registros colaborador-tema
**Formato:** Excel con columnas:
- Estado, Colaborador, Cédula, Cargo, Sub Área, Tema
- Frecuencia, Última Capacitación, Próxima Capacitación
- Días Restantes, Rol Capacitador

### Exportación Detallada desde Dashboard
**Contenido:** Igual que la malla
**Uso:** Análisis detallado, auditorías

### Exportación Resumen desde Dashboard
**Contenido:** Un registro por colaborador
**Formato:** Excel con columnas:
- Colaborador, Cédula, Cargo, Sub Área
- Al Día (cantidad), Próximas a Vencer (cantidad)
- Pendientes (cantidad), Vencidas (cantidad)
- Total Capacitaciones

## Permisos y Roles

### Roles con Acceso

**programacion.html:**
- Administrador (completo)
- Capacitadores (todos los tipos)
- Aux_Capacitador

**modulo_malla.html:**
- Administrador
- Capacitadores (todos los tipos)
- Aux_Capacitador

**dashboard.html:**
- Administrador
- Capacitadores (todos los tipos)
- Aux_Capacitador

**usuarios.html:**
- Todos los usuarios (solo ven sus propios datos)

## Resolución de Problemas

### Las fechas no se actualizan
**Solución:** Las fechas ya no se actualizan automáticamente. Debe registrarlas manualmente en programacion.html

### No veo capacitaciones en la malla
**Verificar:**
1. El colaborador tiene situación A, V o P
2. Existe una programación activa para su cargo + sub_area + tema
3. La programación está marcada como `activo = true`

### No aparecen capacitaciones en usuarios.html
**Verificar:**
1. El usuario está autenticado correctamente
2. Su cédula está registrada en `adm_colaboradores`
3. Tiene situación activa (A, V, P)
4. Existen programaciones para su cargo + sub_area

### Error al importar Excel
**Verificar:**
1. Formato del archivo (CSV o Excel)
2. IDs de cargos existen en `adm_cargos`
3. IDs de sub_areas existen en `adm_área`
4. IDs de temas existen en `cap_tema`
5. Nombres de roles son exactos (case-sensitive)

### Datos incorrectos en sub_area
**Solución:** Aplicar migración 06_fix_sub_area_references.sql

## Mantenimiento

### Actualización Periódica de Notificaciones

```sql
-- Ejecutar mensualmente para recalcular notificaciones
SELECT actualizar_notificaciones_capacitacion();
```

### Limpieza de Datos Antiguos

```sql
-- Desactivar programaciones obsoletas (ejemplo: más de 2 años sin usar)
UPDATE cap_programacion
SET activo = false
WHERE fecha_ultima_capacitacion < CURRENT_DATE - INTERVAL '2 years'
AND activo = true;
```

### Backup Recomendado

```bash
# Backup de tablas críticas
pg_dump -U postgres -d osm_db \
  -t cap_programacion \
  -t cap_formulario \
  -t cap_formulario_asistente \
  -t adm_colaboradores \
  > backup_capacitaciones_$(date +%Y%m%d).sql
```

## Soporte

Para problemas o consultas:
1. Revisar los logs de PostgreSQL
2. Revisar la consola del navegador (F12)
3. Verificar permisos del usuario en `adm_usuario_roles`
4. Consultar documentación en README_PROGRAMACION.md

## Changelog

### v2.0 - Sistema Completo
- Implementado módulo malla
- Implementado dashboard ejecutivo
- Migración a IDs para sub_area
- Registro manual de fechas
- Exportaciones múltiples
- Portal de usuario mejorado

### v1.0 - Sistema Base
- Módulo de programación básico
- Triggers automáticos
- Notificaciones por rol
