# Migración de Sincronización de Colaboradores - EMPLE_COD

## Descripción del Cambio

Se ha modificado el sistema de sincronización de colaboradores desde SQL Server a PostgreSQL para usar el identificador único `EMPLE_COD` de la tabla `TEMPLEADOS` como clave primaria `ac_id` en la tabla `adm_colaboradores`.

## Cambios Realizados

### 1. Archivo `php/funciones_sync.php`

#### Modificaciones en `getColaboradoresSQLServer()`
- Se agregó el campo `EMPLE_COD` en la consulta SELECT para obtener el identificador único de cada empleado.

#### Modificaciones en `syncAllColaboradores()`
- **Antes**: La sincronización verificaba la existencia de registros usando múltiples filtros de correlación (cédula, situación, sub_area, cargo, empresa).
- **Ahora**: La sincronización usa directamente `EMPLE_COD` como `ac_id` para identificar registros.

**Comportamiento nuevo:**
1. **INSERT**: Si `EMPLE_COD` no existe en PostgreSQL, se inserta con `ac_id = EMPLE_COD`
2. **UPDATE**: Si `EMPLE_COD` ya existe, se actualizan todos los campos del registro basándose en `ac_id`
3. Se eliminó la lógica compleja de correlación por múltiples campos

#### Funciones Eliminadas
- `getInsertSQL()`: Ya no es necesaria porque la lógica de INSERT/UPDATE es más simple ahora

### 2. Migración de Base de Datos

#### Archivo `db/migration_emple_cod.sql`
Este script realiza las siguientes modificaciones en PostgreSQL:

1. **Elimina el auto-increment** del campo `ac_id`:
   ```sql
   ALTER TABLE adm_colaboradores ALTER COLUMN ac_id DROP DEFAULT;
   ```

2. **Elimina la constraint única compuesta**: 
   - Se elimina `unique_colaborador` que validaba la combinación de (ac_cedula, ac_id_situación, ac_sub_area, ac_id_cargo, ac_empresa)
   - Ya no es necesaria porque ahora usamos `ac_id` (EMPLE_COD) como identificador único

3. **Documenta el cambio** con un comentario en la columna

## Instrucciones de Aplicación

### Paso 1: Aplicar Migración de Base de Datos

```bash
# Conectarse a PostgreSQL
psql -U postgres -d osm2

# Ejecutar el script de migración
\i /ruta/a/db/migration_emple_cod.sql
```

### Paso 2: Verificar la Migración

```sql
-- Verificar que ac_id ya no tiene DEFAULT
SELECT column_name, column_default 
FROM information_schema.columns 
WHERE table_name = 'adm_colaboradores' AND column_name = 'ac_id';

-- Verificar que se eliminó la constraint
SELECT constraint_name 
FROM information_schema.table_constraints 
WHERE table_name = 'adm_colaboradores' AND constraint_name = 'unique_colaborador';
```

### Paso 3: Ejecutar Primera Sincronización

```bash
cd /ruta/a/php
php sync_colaboradores.php
```

**Importante**: La primera sincronización después de aplicar estos cambios:
- Los registros existentes en PostgreSQL con `ac_id` diferente a su `EMPLE_COD` correspondiente NO serán actualizados automáticamente
- Solo se actualizarán los registros donde `ac_id` coincida con `EMPLE_COD`
- Los nuevos empleados se insertarán correctamente con `ac_id = EMPLE_COD`

### Paso 4: (Opcional) Migrar Datos Existentes

Si necesitas actualizar los registros existentes para que coincidan con los valores de `EMPLE_COD`, deberás ejecutar un script de migración de datos adicional que:

1. Obtenga el mapeo entre registros actuales y sus correspondientes `EMPLE_COD`
2. Actualice los `ac_id` existentes (con cuidado de las foreign keys)
3. O elimine registros antiguos y permita que la próxima sincronización los recree con los IDs correctos

## Beneficios del Cambio

1. **Identificación única**: Cada empleado tiene un ID único que no cambia sin importar cambios en situación, cargo o área
2. **Sincronización más eficiente**: Solo una verificación por `ac_id` en lugar de múltiples filtros
3. **Menos lógica condicional**: El código es más simple y fácil de mantener
4. **Trazabilidad**: El mismo ID en ambos sistemas (SQL Server y PostgreSQL)
5. **Evita duplicados**: No se crean registros duplicados cuando cambia la situación o el cargo de un empleado

## Consideraciones

- Las referencias foreign key a `adm_colaboradores.ac_id` seguirán funcionando correctamente
- El campo `ac_id` sigue siendo la primary key de la tabla
- La secuencia `asistente_id_seq` ya no se usa para `ac_id` pero permanece en la base de datos por compatibilidad
- Si dos registros en SQL Server comparten el mismo `EMPLE_COD`, el segundo sobrescribirá al primero (esto no debería ocurrir si `EMPLE_COD` es verdaderamente único)

## Rollback (En caso de problemas)

Si necesitas revertir los cambios:

```sql
-- Restaurar el auto-increment
ALTER TABLE adm_colaboradores ALTER COLUMN ac_id SET DEFAULT nextval('asistente_id_seq'::regclass);

-- Restaurar la constraint única
ALTER TABLE adm_colaboradores ADD CONSTRAINT unique_colaborador 
UNIQUE (ac_cedula, ac_id_situación, ac_sub_area, ac_id_cargo, ac_empresa);
```

Y revertir los cambios en `php/funciones_sync.php` usando git:
```bash
git checkout HEAD~1 -- php/funciones_sync.php
```
