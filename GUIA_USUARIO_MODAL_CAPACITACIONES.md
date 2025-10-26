# Modal de Historial de Capacitaciones - Guía del Usuario

## Descripción General
El Modal de Historial de Capacitaciones es una funcionalidad completa en el Panel de Usuario (`Usuarios.html`) que muestra todos los registros de capacitación del usuario conectado. Incluye funcionalidades de filtrado, ordenamiento y exportación a Excel.

## Características Principales

### 1. Visualización de Datos
El modal muestra los registros de capacitación con las siguientes 15 columnas:

1. **Proceso** - Proceso de capacitación (ej: "Talento Humano", "Logística")
2. **Lugar** - Ubicación de la capacitación (ej: "Oficinas Casa Amarilla", "Sala de Capacitaciones")
3. **Responsable Capacitación** - Nombre del coordinador de la capacitación
4. **Tema** - Tema de la capacitación (ej: "Inducción Talento humano y gestión administrativa")
5. **Tipo de Actividad** - Tipo (ej: "Capacitación", "Charla", "Inducción")
6. **Fecha** - Fecha en que se realizó la capacitación
7. **Hora Inicio** - Hora de inicio
8. **Hora Fin** - Hora de finalización
9. **Estado Aprobación** - Si aprobó, no aprobó, o no aplica
10. **Empresa** - Nombre de la empresa
11. **Cargo** - Cargo del colaborador
12. **Área** - Área de trabajo
13. **Sub-Área** - Sub-área específica
14. **Rango** - Rango del cargo
15. **Situación** - Estado del colaborador (Activo, Vacaciones, etc.)

### 2. Filtrado Automático por Usuario
- El sistema automáticamente filtra los datos según la cédula del usuario conectado
- Solo muestra las capacitaciones en las que el usuario ha participado
- No se necesita configuración adicional

### 3. Búsqueda en Tiempo Real
- Caja de búsqueda en la parte superior del modal
- Busca en todas las 15 columnas simultáneamente
- Actualización instantánea al escribir
- Útil para encontrar capacitaciones específicas por tema, fecha, lugar, etc.

### 4. Ordenamiento por Columnas
- Haga clic en cualquier encabezado de columna para ordenar
- Primer clic: orden ascendente (A-Z, 0-9, fechas antiguas primero)
- Segundo clic: orden descendente (Z-A, 9-0, fechas recientes primero)
- Indicadores visuales muestran la columna y dirección de ordenamiento actual

### 5. Exportación a Excel
- Botón "Exportar a Excel" en la parte superior derecha
- Genera un archivo .xlsx con todos los registros visibles
- Incluye las 15 columnas con encabezados en español
- Columnas con tamaño automático para facilitar lectura
- Nombre del archivo: `Capacitaciones_{cedula}_{fecha}.xlsx`

## Cómo Usar el Modal

### Paso 1: Acceder al Modal
1. Inicie sesión en el sistema OSM
2. Vaya a su Panel de Usuario (menú "Usuario" o `Usuarios.html`)
3. En la tarjeta "Últimas Capacitaciones", haga clic en el botón **"Ver Más"**
4. El modal se abrirá mostrando su historial completo

### Paso 2: Ver los Datos
- La tabla muestra todas sus capacitaciones ordenadas por fecha (más recientes primero)
- Desplácese hacia abajo para ver más registros
- El contador en la parte inferior muestra el total de registros

### Paso 3: Buscar Capacitaciones
Para encontrar capacitaciones específicas:
1. Use la caja de búsqueda en la parte superior
2. Escriba cualquier término: tema, lugar, fecha, responsable, etc.
3. La tabla se actualiza automáticamente mostrando solo registros que coincidan

**Ejemplos de búsqueda:**
- "Inducción" - muestra todas las inducciones
- "2024" - muestra capacitaciones del año 2024
- "Casa Amarilla" - muestra capacitaciones en esa ubicación
- "Talento Humano" - muestra capacitaciones de ese proceso

### Paso 4: Ordenar Datos
Para organizar los datos:
1. Haga clic en el encabezado de cualquier columna
2. Los datos se ordenan según esa columna
3. Haga clic nuevamente para invertir el orden
4. El ícono de flecha indica la dirección actual

**Ejemplos útiles:**
- Ordenar por "Fecha" para ver cronológicamente
- Ordenar por "Tema" para agrupar temas similares
- Ordenar por "Estado Aprobación" para ver primero aprobados o no aprobados

### Paso 5: Exportar a Excel
Para guardar sus datos:
1. Configure los filtros y ordenamiento según necesite
2. Haga clic en el botón **"Exportar a Excel"**
3. El archivo se descarga automáticamente
4. Abra el archivo con Microsoft Excel, LibreOffice, o Google Sheets

**Nota:** La exportación incluye todos sus registros, incluso si no están visibles en la pantalla actual.

## Interpretación de los Datos

### Estado de Aprobación
- **Aprobó**: El colaborador aprobó la capacitación satisfactoriamente
- **No Aprobó**: El colaborador no cumplió los criterios de aprobación
- **No Aplica**: Esta capacitación no requiere aprobación

### Situación del Colaborador
- **Activo**: Colaborador actualmente trabajando
- **Vacaciones**: Colaborador en período de vacaciones
- **Permiso**: Colaborador con permiso temporal
- (Otros estados según configuración de la empresa)

### Fechas y Horas
- Todas las fechas están en formato día/mes/año
- Las horas están en formato 24 horas (HH:MM:SS)
- Si "Hora Fin" muestra "00:00:00", la capacitación no registró hora de finalización

## Solución de Problemas

### El modal no muestra datos
**Posibles causas:**
- No tiene capacitaciones registradas aún
- Su cédula no coincide en el sistema
- Problema de conexión con la base de datos

**Soluciones:**
1. Verifique con el administrador que tiene capacitaciones asignadas
2. Revise la consola del navegador (F12) para mensajes de error
3. Cierre sesión e inicie sesión nuevamente

### La búsqueda no encuentra resultados
**Posibles causas:**
- El término buscado no existe en ningún campo
- Error de ortografía en el término de búsqueda

**Soluciones:**
1. Borre la búsqueda para ver todos los registros
2. Intente términos más generales
3. Verifique la ortografía

### El Excel no se descarga
**Posibles causas:**
- Bloqueador de descargas del navegador
- No hay datos para exportar
- Error de JavaScript

**Soluciones:**
1. Revise que haya datos cargados en la tabla
2. Permita descargas en su navegador
3. Intente con otro navegador (Chrome, Firefox, Edge)
4. Refresque la página y vuelva a intentar

### Las columnas muestran "-"
**Causa:**
- Algunos campos no fueron registrados para esa capacitación específica

**Nota:** Esto es normal. No todas las capacitaciones tienen todos los campos completos.

## Información Técnica

### Tecnologías Utilizadas
- **Frontend**: HTML5, Bootstrap 5, JavaScript
- **Backend**: PHP, PostgreSQL
- **Exportación**: XLSX.js library

### Seguridad
- Autenticación requerida vía sesión PHP
- Solo muestra datos del usuario conectado
- Sin acceso directo a la base de datos desde el navegador
- Validación de sesión en cada petición al servidor

### Compatibilidad
- **Navegadores soportados**: Chrome, Firefox, Safari, Edge (versiones recientes)
- **Dispositivos**: Desktop, tablet, móvil (responsive)
- **Excel**: Compatible con Microsoft Excel 2010+, LibreOffice Calc, Google Sheets

## Contacto y Soporte

Si tiene problemas con el Modal de Historial de Capacitaciones:
1. Contacte al administrador del sistema
2. Proporcione capturas de pantalla del problema
3. Indique su nombre de usuario y cédula
4. Describa los pasos que realizó antes del problema

## Actualizaciones Recientes

### Octubre 2025
- ✅ Corregidos errores de sintaxis SQL
- ✅ Optimizada consulta de base de datos
- ✅ Verificadas todas las 15 columnas funcionan correctamente
- ✅ Documentación completa agregada

---

**Versión del documento:** 1.0  
**Última actualización:** Octubre 2025  
**Sistema:** OSM Web - Módulo de Capacitaciones
