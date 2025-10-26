# Guía de Importación Masiva desde Excel o CSV

## Descripción

Esta guía explica cómo importar múltiples programaciones de capacitaciones desde un archivo Excel (.xlsx, .xls) o CSV (.csv).

## Formato del Archivo

El archivo puede ser Excel o CSV y debe tener las siguientes columnas:

**Nota sobre encabezados**: La primera fila puede contener encabezados (recomendado para claridad) o datos directamente. Si incluyes encabezados, el sistema los detectará automáticamente y los omitirá al procesar.

| Columna | Campo | Tipo | Descripción | Ejemplo | Requerido |
|---------|-------|------|-------------|---------|-----------|
| A | ID_Cargo | Texto | Identificador del cargo desde `adm_cargos` | 117 | Sí |
| B | Sub_Area | Texto | Nombre de la sub área (opcional) | Mantenimiento Industrial | No |
| C | ID_Tema | Número | ID del tema desde `cap_tema` | 1 | Sí |
| D | Frecuencia_Meses | Número | Cada cuántos meses se repite | 12 | Sí |
| E | Rol_Capacitador | Texto | Nombre exacto del rol | Capacitador SIE | Sí |

## Roles de Capacitadores Disponibles

Debes usar **exactamente** uno de estos nombres:
- `Capacitador SIE` - Seguridad Industrial y Emergencias
- `Capacitador GH` - Gestión Humana
- `Capacitador TI` - Tecnología e Informática
- `Capacitador MT` - Mantenimiento

## Obtener IDs de Cargos

Para obtener los IDs de cargos disponibles:

```sql
SELECT id_cargo, cargo, rango_cargo 
FROM adm_cargos 
ORDER BY cargo;
```

Ejemplo de resultado:
```
id_cargo | cargo                                    | rango_cargo
---------|------------------------------------------|------------------
001      | GERENTE GENERAL                          | NO DEFINIDO
003      | GERENTE ADMINISTRATIVO                   | NO DEFINIDO
117      | DIRECTOR DE MANTENIMIENTO INDUSTRIAL     | DIRECTORES
141      | ANALISTA AGRONOMICO                      | ANALISTAS
```

## Obtener IDs de Temas

Para obtener los IDs de temas disponibles:

```sql
SELECT id, nombre 
FROM cap_tema 
ORDER BY nombre;
```

Ejemplo de resultado:
```
id | nombre
---|------------------------------------------
1  | Trabajo en equipo
3  | Principios y criterios RSPO
4  | Inducción Talento humano y gestión administrativa
14 | Clarificación
20 | Socialización de procedimiento PQRS
```

## Ejemplo de Archivo Excel

### Datos de Ejemplo:

| A | B | C | D | E |
|---|---|---|---|---|
| 117 | Mantenimiento Industrial | 1 | 12 | Capacitador GH |
| 117 | Mantenimiento Industrial | 3 | 12 | Capacitador SIE |
| 117 | Mantenimiento Industrial | 4 | 12 | Capacitador GH |
| 141 |  | 14 | 12 | Capacitador TI |
| 116 | Clipa - Sistemas | 14 | 12 | Capacitador TI |

**Nota**: La columna B (Sub_Area) puede estar vacía.

## Pasos para Importar

### 1. Preparar el Archivo

1. Abrir Excel, LibreOffice Calc, o Google Sheets
2. Crear una nueva hoja de cálculo
3. En la **fila 1**, agregar los encabezados (recomendado para identificar columnas):
   - A1: ID_Cargo
   - B1: Sub_Area
   - C1: ID_Tema
   - D1: Frecuencia_Meses
   - E1: Rol_Capacitador

4. Desde la **fila 2 en adelante**, agregar los datos
5. Guardar como archivo Excel (.xlsx o .xls) o CSV (.csv)

**Nota**: Si omites los encabezados y empiezas directamente con datos en la fila 1, el sistema procesará todas las filas. Se recomienda incluir encabezados por claridad.

### 2. Validar los Datos

Antes de importar, verificar que:

✅ Todos los ID_Cargo existen en la base de datos
✅ Todos los ID_Tema existen en la base de datos
✅ Los nombres de Rol_Capacitador son exactos (mayúsculas, minúsculas, espacios)
✅ Las frecuencias son números positivos
✅ No hay filas completamente vacías entre los datos

### 3. Importar en el Sistema

1. Iniciar sesión en el sistema
2. Navegar a **Capacitaciones** → **Programación** (`/m_capacitaciones/programacion.html`)
3. Hacer clic en el botón **"Importar Excel"** (verde, esquina superior derecha)
4. En el modal que aparece:
   - Hacer clic en **"Elegir archivo"**
   - Seleccionar tu archivo Excel
   - Esperar a que aparezca la vista previa
5. Revisar la **Vista Previa**:
   - Verificar que los nombres de cargo, tema y rol se muestren correctamente
   - Si hay errores, se mostrarán en rojo
6. Si todo está correcto, hacer clic en **"Importar"**
7. El sistema mostrará un mensaje con:
   - Cantidad de programaciones importadas exitosamente
   - Advertencias o errores (si los hay)

### 4. Verificar la Importación

Después de importar:

1. La tabla principal se actualizará automáticamente
2. Verificar que todas las programaciones aparezcan en la lista
3. Si es necesario, editar individualmente cualquier programación

## Errores Comunes y Soluciones

### Error: "Fila X: Rol 'XXX' no encontrado"

**Causa**: El nombre del rol no coincide exactamente con los disponibles.

**Solución**: 
- Verificar mayúsculas y minúsculas
- Verificar espacios adicionales
- Usar uno de: Capacitador SIE, Capacitador GH, Capacitador TI, Capacitador MT

### Error: "Fila X: Ya existe esta programación"

**Causa**: Ya existe una programación activa con el mismo cargo, sub_area y tema.

**Solución**: 
- Verificar si la programación ya existe en el sistema
- Si necesitas modificarla, usa la opción de edición en lugar de importar

### Error: "Fila X: Campos requeridos faltantes"

**Causa**: Falta uno o más de los campos obligatorios (ID_Cargo, ID_Tema, Frecuencia, Rol).

**Solución**: 
- Verificar que todas las columnas requeridas tengan valores
- No dejar celdas vacías en columnas obligatorias

### La importación no muestra vista previa

**Causa**: El archivo no se puede leer o está corrupto.

**Solución**: 
- Verificar que el archivo sea .xlsx o .xls
- Guardar el archivo nuevamente desde Excel
- Intentar con un archivo más simple (menos filas)

## Plantilla de Ejemplo

Se incluye un archivo de plantilla en: `/m_capacitaciones/plantilla_importacion.csv`

Este archivo CSV puede ser abierto en Excel, LibreOffice Calc, o Google Sheets y usado como punto de partida. Puedes guardarlo como Excel (.xlsx) si prefieres.

## Actualizaciones Automáticas

Después de una importación exitosa, el sistema automáticamente:

1. ✅ Crea las programaciones en la base de datos
2. ✅ Actualiza las notificaciones para todos los colaboradores afectados
3. ✅ Recalcula el progreso de capacitaciones
4. ✅ Activa las alertas según las fechas y frecuencias

## Recomendaciones

1. **Comenzar con pocas filas**: Importar primero 5-10 programaciones para probar
2. **Usar consultas SQL**: Verificar IDs antes de crear el Excel
3. **Guardar backups**: Exportar las programaciones actuales antes de importar nuevas
4. **Revisar después**: Verificar en la interfaz que todo se importó correctamente
5. **Documentar**: Mantener un registro de qué se importó y cuándo

## Soporte

Para preguntas o problemas con la importación:
- Contactar al administrador del sistema
- Revisar la documentación principal: `TRAINING_MODULE_README.md`
- Verificar los logs del sistema en caso de errores

## Consultas Útiles

### Ver todas las programaciones activas

```sql
SELECT 
    p.id,
    c.cargo,
    p.sub_area,
    t.nombre AS tema,
    p.frecuencia_meses,
    r.nombre AS rol_capacitador
FROM cap_programacion p
INNER JOIN adm_cargos c ON p.id_cargo = c.id_cargo
INNER JOIN cap_tema t ON p.id_tema = t.id
INNER JOIN adm_roles r ON p.id_rol_capacitador = r.id
WHERE p.activo = true
ORDER BY c.cargo, t.nombre;
```

### Contar programaciones por rol

```sql
SELECT 
    r.nombre AS rol,
    COUNT(*) AS total_programaciones
FROM cap_programacion p
INNER JOIN adm_roles r ON p.id_rol_capacitador = r.id
WHERE p.activo = true
GROUP BY r.nombre
ORDER BY total_programaciones DESC;
```

### Ver colaboradores sin capacitaciones programadas

```sql
SELECT 
    c.ac_cedula,
    c.ac_nombre1 || ' ' || c.ac_apellido1 AS nombre,
    ca.cargo
FROM adm_colaboradores c
INNER JOIN adm_cargos ca ON c.ac_id_cargo = ca.id_cargo
LEFT JOIN cap_programacion p ON c.ac_id_cargo = p.id_cargo 
    AND (p.sub_area IS NULL OR p.sub_area = c.ac_sub_area)
    AND p.activo = true
WHERE c.ac_id_situación IN ('A', 'V', 'P')
    AND p.id IS NULL
GROUP BY c.ac_cedula, c.ac_nombre1, c.ac_apellido1, ca.cargo;
```
