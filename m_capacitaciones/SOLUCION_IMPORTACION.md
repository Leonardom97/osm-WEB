# Solución de Importación de Programaciones con Referencias a Base de Datos

## Problema Original

El usuario tenía un archivo `MATRIZ.xlsx` con una hoja "PROGRAMACION" que contenía datos en formato de texto legible por humanos:

```
Sub Area                    | Cargo                                  | Tema                 | Frecuencia | Rol
Mantenimiento Industrial    | DIRECTOR DE MANTENIMIENTO INDUSTRIAL  | Riesgo Psicosocial   | 12         | Capacitador SIE
```

El sistema necesitaba que estos datos se transformaran a referencias de IDs de base de datos:

```
sub_area | cargo | tema | frecuencia | rol
003      | 117   | 49   | 12         | Capacitador SIE
```

## Solución Implementada

### 1. Script de Transformación (`transform_matriz.py`)

Se creó un script Python que:

1. **Lee el archivo original `MATRIZ.xlsx`**
   - Hoja "PROGRAMACION" con nombres en texto
   - Hoja "DIM" con mapeo de temas a roles

2. **Mapea nombres a IDs de base de datos**
   - Sub Áreas: Nombre → ID de 3 dígitos (tabla `adm_área`)
   - Cargos: Nombre → ID de cargo (tabla `adm_cargos`)
   - Temas: Nombre → ID numérico (tabla `cap_tema`)
   - Roles: Mantiene el nombre (tabla `adm_roles`)

3. **Genera archivo de salida `matriz_importable.xlsx`**
   - Formato listo para importar en la aplicación web
   - Con IDs en lugar de nombres
   - 1,583 filas transformadas exitosamente de 1,685 totales

### 2. Estructura de Tablas de Base de Datos

El sistema trabaja con las siguientes tablas relacionadas:

#### Tabla `cap_programacion` (Programaciones)
```sql
CREATE TABLE cap_programacion (
    id SERIAL PRIMARY KEY,
    id_cargo VARCHAR REFERENCES adm_cargos(id_cargo),
    sub_area VARCHAR REFERENCES adm_área(id_area),
    id_tema INTEGER REFERENCES cap_tema(id),
    frecuencia_meses INTEGER,
    id_rol_capacitador INTEGER REFERENCES adm_roles(id),
    fecha_proxima_capacitacion DATE,
    fecha_notificacion_previa DATE,
    activo BOOLEAN DEFAULT true
);
```

#### Relaciones:
- `cap_programacion.id_cargo` → `adm_cargos.id_cargo`
- `cap_programacion.sub_area` → `adm_área.id_area`
- `cap_programacion.id_tema` → `cap_tema.id`
- `cap_programacion.id_rol_capacitador` → `adm_roles.id`

### 3. Formato de Archivo para Importación

El archivo Excel debe tener esta estructura exacta:

| Columna | Nombre | Tipo | Ejemplo | Descripción |
|---------|--------|------|---------|-------------|
| A | Cargo ID | String | '117' | ID del cargo de `adm_cargos` |
| B | Sub Área ID | String | '003' | ID del área de `adm_área` (3 dígitos) |
| C | Tema ID | Integer | 49 | ID del tema de `cap_tema` |
| D | Frecuencia | Integer | 12 | Meses entre capacitaciones |
| E | Rol Capacitador | String | 'Capacitador SIE' | Nombre del rol de `adm_roles` |

### 4. Archivos Creados

1. **`transform_matriz.py`**: Script de transformación
   - Contiene diccionarios completos de mapeo
   - Procesa automáticamente ambas hojas del Excel
   - Genera estadísticas y reporta errores

2. **`matriz_importable.xlsx`**: Archivo transformado
   - 1,583 filas listas para importar
   - Formato correcto con IDs de base de datos
   - Incluye validación de datos

3. **`ejemplo_importacion.xlsx`**: Ejemplo simple
   - 5 filas de ejemplo para referencia
   - Muestra el formato correcto
   - Útil como plantilla

4. **`README_IMPORTACION.md`**: Documentación completa
   - Explicación detallada del proceso
   - Guía de uso paso a paso
   - Solución de problemas comunes

## Mapeo de Datos - Ejemplos

### Ejemplo 1: Director de Mantenimiento Industrial

**Entrada (MATRIZ.xlsx):**
```
Sub Area: Mantenimiento Industrial
Cargo: DIRECTOR DE MANTENIMIENTO INDUSTRIAL
Tema: Riesgo Psicosocial
Frecuencia: 12
```

**Salida (matriz_importable.xlsx):**
```
Cargo ID: 117
Sub Área ID: 003
Tema ID: 49
Frecuencia: 12
Rol: Capacitador SIE
```

**En Base de Datos:**
```sql
INSERT INTO cap_programacion 
(id_cargo, sub_area, id_tema, frecuencia_meses, id_rol_capacitador)
VALUES ('117', '003', 49, 12, 19);
```

### Ejemplo 2: Director de Planta

**Entrada (MATRIZ.xlsx):**
```
Sub Area: Planta Extractora
Cargo: DIRECTOR DE PLANTA
Tema: BPM e inocuidad alimentaria
Frecuencia: 12
```

**Salida (matriz_importable.xlsx):**
```
Cargo ID: 043
Sub Área ID: 016
Tema ID: 23
Frecuencia: 12
Rol: Capacitador IND
```

## Uso del Sistema

### Para Transformar un Archivo Nuevo:

```bash
cd m_capacitaciones
python3 transform_matriz.py
```

### Para Importar en la Web:

1. Abrir `programacion.html`
2. Clic en "Importar Excel"
3. Seleccionar `matriz_importable.xlsx`
4. Revisar vista previa
5. Clic en "Importar"

## Validaciones del Sistema

### En el Frontend (JavaScript):
- Verifica que el archivo tenga mínimo 5 columnas
- Valida que el rol exista en la lista de roles cargados
- Muestra vista previa con nombres resueltos

### En el Backend (PHP):
- Valida campos requeridos (cargo, sub_area, tema, frecuencia, rol)
- Verifica que no existan duplicados (cargo + sub_area + tema)
- Confirma que los IDs existan en las tablas correspondientes
- Calcula automáticamente fechas de próxima capacitación

## Estadísticas de Transformación

Última ejecución de `transform_matriz.py`:

```
Total rows processed: 1,685
Successfully transformed: 1,583
Success rate: 94%

Missing mappings:
- Cargo: 95 rows (cargos no encontrados en DB)
- Sub Area: 0 rows (todos mapeados correctamente)
- Tema: 7 rows (temas no encontrados en DB)
- Rol: 0 rows (todos mapeados correctamente)
```

## Temas y Cargos Faltantes

### Cargos que deben agregarse a la DB:
- GERENTE AGRONOMICO
- GERENTE FINANCIERO
- GANCHERO
- Etc. (ver log de transform_matriz.py)

### Temas que deben agregarse a la DB:
- Trabajo en caliente (ID sugerido: 83)
- Control de energias peligrosas (ID sugerido: 84)
- Seguridad vial (ID sugerido: 85)
- Soldador Mecanico (ID sugerido: 86)
- Uso eficiente de maquinaria agrícola (ID sugerido: 87)
- Actualizacion tributaria (ID sugerido: 82)

## Ventajas de esta Solución

1. **Integridad Referencial**: Todas las relaciones están basadas en IDs, garantizando consistencia
2. **Validación Automática**: El sistema valida que los IDs existan antes de importar
3. **Prevención de Duplicados**: No permite programaciones duplicadas
4. **Trazabilidad**: Fácil seguimiento de relaciones entre tablas
5. **Escalabilidad**: Fácil agregar nuevos cargos, temas o áreas
6. **Mantenibilidad**: Código limpio y bien documentado

## Próximos Pasos Recomendados

1. **Agregar Temas Faltantes**: Ejecutar INSERT en `cap_tema` para los temas nuevos
2. **Agregar Cargos Faltantes**: Ejecutar INSERT en `adm_cargos` para los cargos nuevos
3. **Re-ejecutar Transformación**: Con los datos completos, lograr 100% de transformación
4. **Importar Datos**: Usar la interfaz web para importar `matriz_importable.xlsx`
5. **Verificar Resultados**: Revisar que las programaciones se crearon correctamente

## Contacto y Soporte

Para preguntas o problemas:
- Revisar `README_IMPORTACION.md` para guía detallada
- Consultar logs de `transform_matriz.py` para errores específicos
- Verificar estructura de tablas en `/db/osm_postgres.sql`
