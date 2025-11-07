# Guía de Importación de Programación de Capacitaciones

## Descripción General

Este módulo permite importar programaciones de capacitación desde archivos Excel utilizando referencias directas a los IDs de las tablas de la base de datos.

## Estructura de la Base de Datos

Las programaciones de capacitación dependen de las siguientes tablas:

### 1. `adm_área` - Sub Áreas
Contiene las sub áreas organizacionales con sus IDs:
- **id_area**: Código de 3 dígitos (ej: '003', '011', '012')
- **sub_area**: Nombre del área (ej: 'Mantenimiento Industrial', 'CLIPA - Sistemas')

Ejemplos:
- `003` → Mantenimiento Industrial
- `011` → CLIPA - Sistemas
- `012` → Contabilidad

### 2. `adm_cargos` - Cargos
Contiene los cargos/posiciones con sus IDs:
- **id_cargo**: Código de cargo (ej: '117', '043')
- **cargo**: Nombre del cargo (ej: 'DIRECTOR DE MANTENIMIENTO INDUSTRIAL')

Ejemplos:
- `117` → DIRECTOR DE MANTENIMIENTO INDUSTRIAL
- `043` → DIRECTOR DE PLANTA
- `068` → DIRECTOR LOGISTICA, COSECHA Y MANTENIMIENTO

### 3. `cap_tema` - Temas de Capacitación
Contiene los temas de capacitación con sus IDs:
- **id**: ID numérico secuencial
- **nombre**: Nombre del tema

Ejemplos:
- `47` → Autocuidado
- `49` → Riesgo Psicosocial
- `53` → Inducción y reinducción de seguridad y salud en el trabajo

### 4. `adm_roles` - Roles de Capacitadores
Contiene los roles de los capacitadores:
- **id**: ID numérico
- **nombre**: Nombre del rol (ej: 'Capacitador SIE', 'Capacitador GH')

Ejemplos:
- Capacitador SIE
- Capacitador GH
- Capacitador TI
- Capacitador MT

## Formato del Archivo Excel para Importación

El archivo Excel debe tener la siguiente estructura en la hoja "programacion":

| Columna A | Columna B | Columna C | Columna D | Columna E |
|-----------|-----------|-----------|-----------|-----------|
| **Cargo ID** | **Sub Área ID** | **Tema ID** | **Frecuencia** | **Rol Capacitador** |
| 117 | 003 | 49 | 12 | Capacitador SIE |
| 043 | 016 | 23 | 12 | Capacitador IND |
| 068 | 001 | 47 | 6 | Capacitador SIE |

### Descripción de Columnas:

1. **Cargo ID** (Columna A): ID del cargo de la tabla `adm_cargos` (ej: '117')
2. **Sub Área ID** (Columna B): ID del área de la tabla `adm_área` (ej: '003')
3. **Tema ID** (Columna C): ID del tema de la tabla `cap_tema` (ej: 49)
4. **Frecuencia** (Columna D): Frecuencia en meses para repetir la capacitación (número)
5. **Rol Capacitador** (Columna E): Nombre del rol del capacitador de la tabla `adm_roles`

## Proceso de Transformación desde MATRIZ.xlsx

Si tiene un archivo `MATRIZ.xlsx` con nombres en lugar de IDs, use el script de transformación:

### Uso del Script `transform_matriz.py`

```bash
cd m_capacitaciones
python3 transform_matriz.py
```

Este script:
1. Lee la hoja "PROGRAMACION" de `MATRIZ.xlsx`
2. Mapea los nombres a sus IDs correspondientes en la base de datos
3. Consulta la hoja "DIM" para obtener los roles de capacitadores
4. Genera `matriz_importable.xlsx` con los IDs correctos listos para importar

### Ejemplo de Transformación:

**Entrada (MATRIZ.xlsx):**
| Sub Area | Cargo | Temas de capacitacion | FRECUENCIA | ROL |
|----------|-------|----------------------|------------|-----|
| Mantenimiento Industrial | DIRECTOR DE MANTENIMIENTO INDUSTRIAL | Riesgo Psicosocial | 12 | (fórmula) |

**Salida (matriz_importable.xlsx):**
| Cargo ID | Sub Área ID | Tema ID | Frecuencia | Rol Capacitador |
|----------|-------------|---------|------------|-----------------|
| 117 | 003 | 49 | 12 | Capacitador SIE |

## Importación en la Interfaz Web

### Pasos para Importar:

1. Abra el módulo de **Programación de Capacitaciones** (`programacion.html`)
2. Haga clic en el botón **"Importar Excel"**
3. Seleccione el archivo Excel (`matriz_importable.xlsx`)
4. Revise la vista previa de los datos
5. Haga clic en **"Importar"**

### Vista Previa:

El sistema mostrará una vista previa de los datos antes de la importación, resolviendo los IDs a sus nombres correspondientes para verificación.

### Validaciones:

El sistema valida:
- Que los IDs de cargo, tema y rol existan en la base de datos
- Que no existan duplicados (misma combinación cargo + sub_area + tema)
- Que todos los campos requeridos estén presentes

## Notas Importantes

### Sub Área es Obligatoria
A diferencia de versiones anteriores, **sub_area es ahora un campo obligatorio** y debe contener un ID válido de la tabla `adm_área`.

### Frecuencia por Defecto
Si no se especifica frecuencia, el sistema usa **12 meses** por defecto.

### Fecha de Próxima Capacitación
Durante la importación masiva, el sistema calcula automáticamente:
- `fecha_proxima_capacitacion`: Fecha actual + frecuencia en meses
- `fecha_notificacion_previa`: Fecha próxima - 1 mes

Para programaciones individuales, se debe especificar manualmente la fecha de próxima capacitación.

### Roles de Capacitadores Válidos

Los roles válidos son:
- Capacitador SIE
- Capacitador GH
- Capacitador TI
- Capacitador MT
- Capacitador IND
- Capacitador ADM
- Capacitador AGR
- Administrador
- Capacitador
- Aux_Capacitador

## Resolución de Problemas

### Error: "Cargo not found"
El ID de cargo no existe en la tabla `adm_cargos`. Verifique el ID correcto en la base de datos.

### Error: "Sub Area not found"
El ID de sub área no existe en la tabla `adm_área`. Verifique el ID correcto (debe ser de 3 dígitos, ej: '003').

### Error: "Tema not found"
El ID de tema no existe en la tabla `cap_tema`. Verifique el ID correcto o agregue el tema a la base de datos.

### Error: "Rol not found"
El nombre del rol no existe en la tabla `adm_roles`. Verifique que el nombre esté escrito exactamente como en la base de datos.

### Error: "Ya existe esta programación"
Ya existe una programación con la misma combinación de cargo + sub_area + tema. No se pueden tener duplicados.

## Mantenimiento del Script de Transformación

Si se agregan nuevos cargos, temas o sub áreas a la base de datos, actualice los diccionarios correspondientes en `transform_matriz.py`:
- `SUB_AREAS_DB`
- `CARGOS_DB`
- `TEMAS_DB`

## Estadísticas de la Última Transformación

Al ejecutar `transform_matriz.py`, obtendrá estadísticas como:

```
============================================================
TRANSFORMATION COMPLETE
============================================================
Total rows processed: 1685
Successfully transformed: 1583
Missing cargo mappings: 95
Missing sub_area mappings: 0
Missing tema mappings: 7
Missing rol mappings: 0

Output file: matriz_importable.xlsx
```

Las filas con datos faltantes se reportan en el log de errores para su corrección.

## Soporte

Para más información o soporte, consulte:
- Documentación de la base de datos: `/db/osm_postgres.sql`
- API de programación: `/m_capacitaciones/assets/php/programacion_api.php`
- Interfaz JavaScript: `/m_capacitaciones/assets/js/programacion.js`
