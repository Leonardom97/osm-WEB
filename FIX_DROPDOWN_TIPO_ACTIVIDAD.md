# Fix: Dropdowns de Tipo de Actividad y Tema no cargaban datos activos

## Problema Original (Issue)
El desplegable de tipo de actividad en `formulario.html` no estaba seleccionando/mostrando los datos activos de la tabla para seleccionar en el formulario. El mismo problema también afectaba al desplegable de temas.

## Análisis del Problema

### Síntomas
- Los dropdowns de "Tipo Actividad" y "Tema" en el formulario de capacitación no mostraban opciones
- La consola del navegador mostraba errores de la API rechazando las peticiones

### Causa Raíz
Discrepancia entre los nombres de columnas solicitados por JavaScript y los permitidos por la whitelist de seguridad en PHP:

**JavaScript** (`formulario.js` línea 17-18):
```javascript
cargarSelect('t-actividad', 'cap_tipo_actividad', 'nombre');
cargarSelect('tema-a', 'cap_tema', 'nombre');
```

**PHP API** (`formulario_api.php` línea 42-44) - ANTES:
```php
'cap_tema' => ['tema'],           // ❌ Incorrecto
'cap_tipo_actividad' => ['tipo_actividad'],  // ❌ Incorrecto
```

**Base de Datos** (`db/osm_postgres.sql`):
```sql
CREATE TABLE "public"."cap_tipo_actividad" (
  "id" int4,
  "nombre" varchar(100)  -- ✓ Nombre real de la columna
);

CREATE TABLE "public"."cap_tema" (
  "id" int4,
  "nombre" varchar(100)  -- ✓ Nombre real de la columna
);
```

## Solución Implementada

### Cambios en el Código
Archivo: `m_capacitaciones/assets/php/formulario_api.php`

```php
// ANTES (líneas 42-44)
'cap_tema' => ['tema'],
'cap_tipo_actividad' => ['tipo_actividad'],

// DESPUÉS
'cap_tema' => ['nombre'],
'cap_tipo_actividad' => ['nombre'],
```

### Impacto del Cambio
1. **Validación de Seguridad**: La whitelist ahora acepta correctamente las peticiones para la columna `nombre`
2. **Filtrado por Estado**: El query continúa filtrando por `estado = 0` para mostrar solo registros activos
3. **Retrocompatibilidad**: No afecta otras funcionalidades existentes

## Verificación y Pruebas

### Test Automatizado
Se creó un script de prueba (`/tmp/test_formulario_api.php`) que verifica:

✓ `cap_proceso` con columna `proceso` - permitido
✓ `cap_lugar` con columna `lugar` - permitido  
✓ `cap_tipo_actividad` con columna `nombre` - permitido (FIX)
✓ `cap_tema` con columna `nombre` - permitido (FIX)
✗ `cap_tipo_actividad` con columna `tipo_actividad` - bloqueado (comportamiento correcto)
✗ `cap_tema` con columna `tema` - bloqueado (comportamiento correcto)

**Resultado**: 6/6 pruebas pasadas ✓

### Sintaxis
- PHP: Sin errores de sintaxis (`php -l`)
- JavaScript: Sin errores de sintaxis (`node -c`)

## Comportamiento Esperado Después del Fix

Cuando un usuario accede a `formulario.html`:

1. El dropdown "Tipo Actividad" carga y muestra:
   - Capacitación
   - Charla
   - Reunión
   - Entrenamiento
   - Inducción
   (Solo los registros con `estado = 0`)

2. El dropdown "Tema" carga y muestra los temas activos configurados en la base de datos (filtrados por `estado = 0`)

## Archivos Modificados
- `m_capacitaciones/assets/php/formulario_api.php` (2 líneas)

## Archivos NO Modificados (pero relacionados)
- `m_capacitaciones/formulario.html` - No requiere cambios
- `m_capacitaciones/assets/js/formulario.js` - Ya estaba correcto
- `db/02_r_update formulario.sql` - Migration que agrega columna `estado`

## Notas Técnicas

### Sistema de Filtrado por Estado
La migración `db/02_r_update formulario.sql` agrega la columna `estado` a las tablas:
- `estado = 0` → Registro activo (se muestra en dropdowns)
- `estado = 1` → Registro inactivo (no se muestra)

La API implementa este filtro en la línea 64-68:
```php
if (in_array($tabla, ['cap_proceso', 'cap_tema', 'cap_lugar', 'cap_tipo_actividad'])) {
    $stmt = $pg->prepare("SELECT id, \"$col\" FROM \"$tabla\" WHERE estado = 0 ORDER BY \"$col\" ASC");
```

### Seguridad
- Se mantiene la whitelist de seguridad para prevenir SQL injection
- Solo se corrigieron los nombres de columna, no se eliminó la validación
- El sistema continúa bloqueando intentos de acceso a columnas no autorizadas

## Recomendaciones

1. **Migración de Base de Datos**: Asegurar que la migración `02_r_update formulario.sql` esté aplicada en todos los ambientes
2. **Documentación**: Mantener actualizada la documentación de la estructura de tablas
3. **Testing**: Probar en el ambiente de desarrollo antes de desplegar a producción

## Referencias
- Issue: "puedes revisar el desplegable de tipo de actividad de formulario.html no esta seleccionando los datos activos por tabla para seleccionar en el formulario"
- Fecha de fix: 2025-11-15
