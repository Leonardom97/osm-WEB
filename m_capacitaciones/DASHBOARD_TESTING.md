# Guía de Pruebas del Dashboard de Capacitaciones

## Descripción
Este documento describe cómo probar el módulo dashboard.html después de las correcciones realizadas.

## Problemas Corregidos

### 1. Carga de Datos
- **Problema**: El dashboard no cargaba ningún dato
- **Solución**: 
  - Mejorada la gestión de errores con logging detallado en consola
  - Agregado manejo de sesiones expiradas
  - Mejorada la visualización de errores al usuario

### 2. Exportación a Excel
- **Problema**: Las funciones de exportación no funcionaban
- **Solución**:
  - Cambiada la carga de biblioteca XLSX de CDN a copia local
  - Agregada verificación de disponibilidad de XLSX
  - Mejorado manejo de errores en exportación
  - Agregadas columna "Situación" en ambas exportaciones
  - Agregados mensajes de éxito después de exportar

### 3. Visualización de Capacitaciones Pendientes
- **Problema**: No se mostraban destacadamente las capacitaciones pendientes
- **Solución**:
  - Agregado resaltado de filas (rojo para vencidas, amarillo para próximas a vencer)
  - Mejorado el Top 10 de Cargos y Temas con pendientes
  - Agregado color-coding para "Días Restantes"
  - Incluido "próximo a vencer" en conteos de pendientes

## Cómo Probar

### Pre-requisitos
1. Servidor web con PHP y PostgreSQL configurado
2. Usuario con sesión activa en el sistema
3. Base de datos con datos de:
   - Colaboradores activos (tabla: adm_colaboradores)
   - Programación de capacitaciones (tabla: cap_programacion)
   - Historial de capacitaciones (tablas: cap_formulario, cap_formulario_asistente)

### Pasos de Prueba

#### 1. Prueba de Carga de Datos
1. Abrir el navegador y navegar a: `m_capacitaciones/dashboard.html`
2. Abrir la consola del navegador (F12 → Console)
3. Verificar mensajes de log:
   ```
   Dashboard initializing...
   XLSX library loaded successfully
   Loading dashboard data...
   Data response status: 200
   Filters response status: 200
   Loaded X records
   ```
4. Verificar que aparezcan:
   - Estadísticas en las tarjetas superiores (Total Colaboradores, Capacitados, Pendientes, Vencidas)
   - Top 10 Cargos con Capacitaciones Pendientes
   - Top 10 Temas con Capacitaciones Pendientes
   - Tabla con detalle de capacitaciones

#### 2. Prueba de Visualización de Pendientes
1. En la tabla principal, verificar:
   - **Filas rojas**: Capacitaciones vencidas (badge "Vencida")
   - **Filas amarillas**: Capacitaciones próximas a vencer (badge "Próximo a Vencer")
   - **Columna "Días"**: 
     * Números negativos en rojo: "X días vencidos"
     * Números ≤ 30 en amarillo: "X días"
     * Números > 30 en verde: "X días"

2. Verificar secciones de resumen:
   - Top 10 Cargos debe mostrar los cargos con más capacitaciones pendientes/vencidas/próximas
   - Top 10 Temas debe mostrar los temas con más capacitaciones pendientes/vencidas/próximas

#### 3. Prueba de Filtros
1. Probar cada filtro individualmente:
   - **Estado**: Seleccionar "Pendiente", "Próximo a Vencer", "Vencida", "Al Día"
   - **Situación**: Seleccionar "Activo (A)", "Vacaciones (V)", "Permiso (P)"
   - **Cargo**: Seleccionar un cargo específico
   - **Sub Área**: Seleccionar un área específica
   - **Tema**: Seleccionar un tema específico
   - **Rol Capacitador**: Seleccionar un rol específico

2. Hacer clic en "Aplicar Filtros"
3. Verificar en consola: `Filtered from X to Y records`
4. Verificar que la tabla se actualice con los datos filtrados
5. Hacer clic en "Limpiar Filtros" y verificar que vuelvan todos los datos

#### 4. Prueba de Exportación a Excel

##### Exportación Detallada
1. Hacer clic en "Exportar Detallado"
2. Verificar en consola: `Exporting detailed Excel...`
3. Debe descargarse un archivo: `Dashboard_Capacitaciones_Detallado_YYYY-MM-DD.xlsx`
4. Abrir el archivo y verificar columnas:
   - Estado
   - Situación
   - Colaborador
   - Cédula
   - Cargo
   - Sub Área
   - Tema
   - Frecuencia (meses)
   - Última Capacitación
   - Próxima Capacitación
   - Días Restantes
   - Rol Capacitador

##### Exportación Resumen
1. Hacer clic en "Exportar Resumen"
2. Verificar en consola: `Exporting summary Excel...`
3. Debe descargarse un archivo: `Dashboard_Capacitaciones_Resumen_YYYY-MM-DD.xlsx`
4. Abrir el archivo y verificar columnas:
   - Colaborador
   - Cédula
   - Cargo
   - Sub Área
   - Situación
   - Al Día
   - Próximas a Vencer
   - Pendientes
   - Vencidas
   - Total Capacitaciones

#### 5. Prueba de Manejo de Errores

##### Sin Sesión
1. Cerrar sesión o borrar cookies
2. Intentar acceder a dashboard.html
3. Debe mostrar: "Su sesión ha expirado. Por favor, inicie sesión nuevamente."
4. Debe redirigir a index.html después de 2 segundos

##### Sin Datos
1. Con base de datos vacía o sin registros
2. Debe mostrar: "No hay registros para mostrar"
3. Estadísticas deben mostrar "0"
4. Secciones de Top 10 deben mostrar: "No hay capacitaciones pendientes"

##### Error de Conexión
1. Detener el servidor de base de datos
2. Recargar la página
3. Debe mostrar alerta de error
4. Verificar en consola el mensaje de error específico

## Mensajes de Consola Esperados

### Carga Exitosa
```
Dashboard initializing...
XLSX library loaded successfully
Loading dashboard data...
Data response status: 200
Filters response status: 200
Data result: {success: true, data: Array(X)}
Filters result: {success: true, data: {...}}
Loaded X records
Statistics: {uniqueEmployees: X, alDiaCount: X, pendientesCount: X, vencidasCount: X, totalRecords: X}
Top cargos with pending trainings: [...]
Top temas with pending trainings: [...]
Rendering X records in table
Dashboard initialized successfully
```

### Al Aplicar Filtros
```
Applying filters...
Filters: {estadoFilter: "vencida", situacionFilter: "", ...}
Filtered from X to Y records
Statistics: {...}
Top cargos with pending trainings: [...]
Top temas with pending trainings: [...]
Rendering Y records in table
```

### Al Exportar
```
Exporting detailed Excel...
Exporting X records
Excel file generated successfully
```

## Solución de Problemas

### Problema: "XLSX library not loaded"
- **Causa**: El archivo xlsx.full.min.js no se cargó
- **Solución**: Verificar que existe `/m_capacitaciones/assets/js/xlsx.full.min.js`

### Problema: "No autorizado"
- **Causa**: Sesión expirada o usuario no logueado
- **Solución**: Iniciar sesión nuevamente

### Problema: No hay datos
- **Causa Posible 1**: No hay colaboradores activos con capacitaciones programadas
- **Solución**: Verificar datos en tablas:
  - `adm_colaboradores` (debe tener colaboradores con `ac_id_situación` = 'A', 'V', o 'P')
  - `cap_programacion` (debe tener programaciones activas)

- **Causa Posible 2**: Error en la consulta SQL
- **Solución**: Revisar logs del servidor PHP y PostgreSQL

### Problema: Exportación no funciona
- **Causa**: XLSX no cargado o error en datos
- **Solución**: Verificar consola del navegador para mensajes de error específicos

## Notas de Implementación

### Archivos Modificados
1. `/m_capacitaciones/dashboard.html` - Cambio de CDN a biblioteca local de XLSX
2. `/m_capacitaciones/assets/js/dashboard.js` - Múltiples mejoras

### Mejoras Implementadas
- Logging comprehensivo para debugging
- Manejo robusto de errores
- Visualización mejorada de pendientes
- Exportación Excel confiable
- Mejor feedback al usuario
- Manejo de sesiones expiradas
- Manejo de datos nulos/faltantes
- Color-coding para estados de capacitación

### Compatibilidad
- Navegadores modernos (Chrome, Firefox, Edge, Safari)
- Bootstrap 5.x
- PostgreSQL 12+
- PHP 7.4+
