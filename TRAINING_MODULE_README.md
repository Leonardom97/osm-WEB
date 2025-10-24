# Módulo de Programación y Seguimiento de Capacitaciones

## Descripción General

Este módulo permite programar, rastrear y notificar capacitaciones basadas en cargos y sub-áreas específicas. Incluye un sistema completo de notificaciones, seguimiento de progreso y gestión de capacitaciones.

## Características Principales

### 1. Programación de Capacitaciones
- **Ubicación**: `/m_capacitaciones/programacion.html`
- Permite crear programaciones de capacitaciones por:
  - Cargo específico
  - Sub área (opcional)
  - Tema de capacitación
  - Frecuencia en meses (periodicidad)
  - Rol del capacitador responsable

### 2. Roles de Capacitadores
Se han agregado 4 nuevos roles especializados:
- **Capacitador SIE**: Seguridad Industrial y Emergencias
- **Capacitador GH**: Gestión Humana
- **Capacitador TI**: Tecnología e Informática
- **Capacitador MT**: Mantenimiento

### 3. Sistema de Notificaciones
- **Ubicación**: Campanita en el navbar (esquina superior derecha)
- Muestra alertas de capacitaciones:
  - **Vencidas**: En rojo
  - **Próximas a vencer**: En amarillo (últimos 30 días)
  - **Pendientes**: En azul
- Actualización automática cada 5 minutos
- Contador de notificaciones sin leer

### 4. Perfil de Usuario Mejorado
- **Ubicación**: `/Usuarios.html`
- Muestra:
  - **Barra de progreso**: Porcentaje de capacitaciones completadas
  - **Últimas 5 capacitaciones**: Historial reciente con fechas
  - **Capacitaciones pendientes**: Lista de capacitaciones por realizar
  - **Capacitaciones completadas**: Historial completo en pestaña separada

### 5. Gestión de Sesiones Mejorada
- **Ubicación**: `/sesiones.html`
- Nuevas características:
  - Botón "Ver detalles" en sesiones activas
  - Modal con información completa del usuario:
    - Datos personales
    - Progreso de capacitaciones
    - Últimas capacitaciones realizadas
    - Historial de sesiones

## Instalación y Configuración

### 1. Ejecutar Migración de Base de Datos

```bash
psql -U your_user -d web_osm -f db/migration_training_scheduling.sql
```

Esta migración crea:
- Tabla `cap_programacion`: Almacena las programaciones
- Tabla `cap_notificaciones`: Gestiona las alertas
- Vista `v_progreso_capacitaciones`: Calcula el progreso
- Función `actualizar_notificaciones_capacitacion()`: Actualiza notificaciones automáticamente
- 4 nuevos roles de capacitadores

### 2. Configurar Permisos

Asegurar que los usuarios con rol de administrador o capacitador tengan acceso al módulo de programación.

### 3. Importación Masiva desde Excel

El módulo permite importar múltiples programaciones desde un archivo Excel con el siguiente formato:

| Columna | Descripción | Ejemplo |
|---------|-------------|---------|
| A | ID Cargo | 117 |
| B | Sub Área (opcional) | Mantenimiento Industrial |
| C | ID Tema | 1 |
| D | Frecuencia en meses | 12 |
| E | Nombre del Rol | Capacitador SIE |

**Pasos para importar:**
1. Ir a `/m_capacitaciones/programacion.html`
2. Clic en "Importar Excel"
3. Seleccionar archivo Excel (.xlsx o .xls)
4. Revisar vista previa
5. Clic en "Importar"

## APIs Disponibles

### Programación API
- **Archivo**: `/m_capacitaciones/assets/php/programacion_api.php`
- **Acciones**:
  - `list`: Listar todas las programaciones
  - `get`: Obtener una programación específica
  - `create`: Crear nueva programación
  - `update`: Actualizar programación
  - `delete`: Desactivar programación
  - `bulk_import`: Importar múltiples programaciones
  - `get_roles`: Obtener roles de capacitadores
  - `get_cargos`: Obtener lista de cargos
  - `get_temas`: Obtener lista de temas

### Notificaciones API
- **Archivo**: `/m_capacitaciones/assets/php/notificaciones_api.php`
- **Acciones**:
  - `get_my_notifications`: Obtener notificaciones del usuario actual
  - `get_unread_count`: Contador de notificaciones sin leer
  - `mark_as_read`: Marcar notificación como leída
  - `mark_all_as_read`: Marcar todas como leídas
  - `get_by_role`: Obtener notificaciones por rol de capacitador
  - `get_statistics`: Estadísticas de notificaciones

### Progreso API
- **Archivo**: `/m_capacitaciones/assets/php/progreso_api.php`
- **Acciones**:
  - `get_my_progress`: Obtener progreso del usuario actual
  - `get_user_progress`: Obtener progreso de usuario específico
  - `get_my_trainings`: Obtener capacitaciones programadas y completadas
  - `get_last_trainings`: Obtener últimas N capacitaciones
  - `get_pending_trainings`: Obtener capacitaciones pendientes
  - `get_all_progress`: Obtener progreso de todos los colaboradores

## Flujo de Trabajo

### Para Administradores/Capacitadores:

1. **Configurar Programación**:
   - Acceder a `/m_capacitaciones/programacion.html`
   - Crear programaciones manualmente o importar desde Excel
   - Definir frecuencia y responsables

2. **Revisar Notificaciones**:
   - Sistema actualiza automáticamente notificaciones
   - Ver capacitaciones pendientes por rol asignado

3. **Registrar Capacitación**:
   - Usar el módulo existente de formularios
   - El sistema actualiza automáticamente el progreso

### Para Colaboradores:

1. **Ver Notificaciones**:
   - Campanita en navbar muestra capacitaciones pendientes
   - Colores indican urgencia

2. **Revisar Progreso**:
   - Acceder a `/Usuarios.html`
   - Ver barra de progreso y estado de capacitaciones

3. **Completar Capacitaciones**:
   - Asistir a capacitación programada
   - El responsable registra la asistencia

## Mantenimiento

### Actualizar Notificaciones Manualmente

```sql
SELECT actualizar_notificaciones_capacitacion();
```

### Ver Progreso de Todos los Colaboradores

```sql
SELECT * FROM v_progreso_capacitaciones
ORDER BY porcentaje_completado ASC;
```

### Desactivar Programación

```sql
UPDATE cap_programacion 
SET activo = false 
WHERE id = [ID];
```

## Solución de Problemas

### Las notificaciones no aparecen
1. Verificar que el usuario es colaborador activo
2. Ejecutar: `SELECT actualizar_notificaciones_capacitacion();`
3. Verificar que existen programaciones activas para el cargo

### El progreso no se actualiza
1. Verificar que las capacitaciones están registradas en `cap_formulario_asistente`
2. Verificar que la cédula coincide exactamente
3. Ejecutar query de la vista `v_progreso_capacitaciones` manualmente

### Error al importar Excel
1. Verificar formato del archivo (debe ser .xlsx o .xls)
2. Verificar que los IDs de cargo existen en `adm_cargos`
3. Verificar que los IDs de tema existen en `cap_tema`
4. Verificar que los nombres de roles son exactos

## Archivos Modificados/Creados

### Base de Datos
- `db/migration_training_scheduling.sql` - Migración completa

### Backend (PHP)
- `m_capacitaciones/assets/php/programacion_api.php` - API de programación
- `m_capacitaciones/assets/php/notificaciones_api.php` - API de notificaciones
- `m_capacitaciones/assets/php/progreso_api.php` - API de progreso
- `php/session_management_api.php` - Mejorado con endpoint para sesiones por cédula
- `php/session_manager.php` - Agregado campo de cédula en sesiones activas

### Frontend (HTML)
- `m_capacitaciones/programacion.html` - Interfaz de programación
- `Usuarios.html` - Mejorado con progreso y tabs de capacitaciones
- `sesiones.html` - Mejorado con modal de detalles de usuario
- `includes/navbar.html` - Activado sistema de notificaciones

### Frontend (JavaScript)
- `m_capacitaciones/assets/js/programacion.js` - Lógica de programación
- `assets/js/user_trainings.js` - Lógica de visualización de capacitaciones
- `assets/js/navbar.js` - Lógica de notificaciones
- `assets/js/sesiones.js` - Lógica de detalles de usuario

## Próximos Pasos Sugeridos

1. **Automatización**: Configurar cron job para ejecutar `actualizar_notificaciones_capacitacion()` diariamente
2. **Reportes**: Crear reportes de cumplimiento por área/cargo
3. **Email**: Integrar notificaciones por correo electrónico
4. **Dashboard**: Crear dashboard gerencial con KPIs de capacitación
5. **Certificados**: Generar certificados automáticos de capacitación

## Soporte

Para reportar problemas o solicitar mejoras, contactar al equipo de desarrollo o crear un issue en el repositorio.
