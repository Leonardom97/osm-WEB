# Implementación de Relación Proceso-Tema

## Resumen Ejecutivo

Se ha implementado exitosamente un sistema de gestión de relaciones entre Procesos y Temas para los formularios de capacitación. Esta solución permite:

1. **Configurar** qué temas están disponibles para cada proceso
2. **Gestionar** estas relaciones desde una interfaz web intuitiva
3. **Filtrar automáticamente** los temas según el proceso seleccionado en los formularios

## ¿Qué se implementó?

### 1. Base de Datos
Se creó la tabla `cap_proceso_tema` que almacena las relaciones entre procesos y temas:

```sql
CREATE TABLE cap_proceso_tema (
  id SERIAL PRIMARY KEY,
  id_proceso int4 NOT NULL,
  id_tema int4 NOT NULL,
  activo bool DEFAULT true,
  fecha_creacion timestamp DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_proceso) REFERENCES cap_proceso(id),
  FOREIGN KEY (id_tema) REFERENCES cap_tema(id),
  UNIQUE (id_proceso, id_tema)
);
```

**Datos iniciales cargados:**
- **Proceso Administrativo** (9 temas):
  - Socialización de procedimiento PQRS
  - Excel
  - Análisis e datos
  - Diseño Web
  - Herramientas de Google
  - Herramientas ofimáticas
  - Mantenimiento de cámaras
  - Power Bi
  - SAP

- **Proceso Compras y almacén** (1 tema):
  - Rotación de inventario

### 2. Interfaz de Gestión (items_formularios.html)

Se agregó una nueva pestaña llamada **"Relación Proceso Tema"** donde puedes:

- **Ver** todas las relaciones existentes en una tabla
- **Agregar** nuevas relaciones seleccionando proceso y tema
- **Activar/Desactivar** relaciones con un botón toggle
- **Eliminar** relaciones que ya no necesites

**Ubicación:** `/m_capacitaciones/items_formularios.html`

### 3. Filtrado Automático (formulario.html)

En el formulario de capacitación, ahora cuando seleccionas un proceso:
- El campo "Tema" se actualiza automáticamente
- Solo muestra los temas asociados a ese proceso
- Si no hay temas para el proceso, muestra "No hay temas para este proceso"
- Si no seleccionas proceso, muestra todos los temas disponibles

**Ubicación:** `/m_capacitaciones/formulario.html`

### 4. API Backend (proceso_tema_api.php)

Se creó un endpoint API que soporta las siguientes operaciones:

| Acción | Descripción |
|--------|-------------|
| `list` | Lista todas las relaciones proceso-tema |
| `add` | Agrega una nueva relación |
| `delete` | Elimina una relación |
| `toggle` | Activa/desactiva una relación |
| `get_temas_by_proceso` | Obtiene temas filtrados por proceso |
| `get_procesos` | Lista todos los procesos |
| `get_all_temas` | Lista todos los temas |

**Ubicación:** `/m_capacitaciones/assets/php/proceso_tema_api.php`

## Cómo usar la nueva funcionalidad

### Para Administradores: Gestionar Relaciones

1. Abre tu navegador y ve a: `[TU_URL]/m_capacitaciones/items_formularios.html`
2. Inicia sesión como Administrador
3. Haz clic en la pestaña **"Relación Proceso Tema"**
4. Para agregar una nueva relación:
   - Selecciona un **Proceso** del primer dropdown
   - Selecciona un **Tema** del segundo dropdown
   - Haz clic en **"Agregar Relación"**
5. Para desactivar una relación: haz clic en el botón toggle (cambia de verde a gris)
6. Para eliminar una relación: haz clic en el botón de basura (ícono rojo)

### Para Capacitadores: Usar el Formulario Filtrado

1. Abre el formulario de capacitación: `[TU_URL]/m_capacitaciones/formulario.html`
2. En el campo **"Proceso"**, selecciona el proceso deseado (ej: "Administrativo")
3. Observa cómo el campo **"Tema"** se actualiza automáticamente mostrando solo los temas relevantes
4. Selecciona el tema apropiado de la lista filtrada
5. Completa el resto del formulario normalmente

## Instalación

### Paso 1: Ejecutar la migración de base de datos

Conecta a tu base de datos PostgreSQL y ejecuta:

```bash
psql -U postgres -d osm2 -f db/09_create_cap_proceso_tema.sql
```

O desde pgAdmin/otra herramienta, ejecuta el contenido del archivo `db/09_create_cap_proceso_tema.sql`

### Paso 2: Verificar la instalación

Ejecuta esta consulta para verificar:

```sql
SELECT COUNT(*) FROM cap_proceso_tema;
```

Deberías ver 10 registros iniciales.

### Paso 3: Listo para usar

Los archivos ya están en su lugar. Solo actualiza tu navegador y las nuevas funcionalidades estarán disponibles.

## Agregar más relaciones

Si necesitas agregar más relaciones manualmente en la base de datos:

```sql
-- Ejemplo: Agregar relación entre proceso "Producción industrial" (id=1) y tema "BPM e inocuidad alimentaria" (id=23)
INSERT INTO cap_proceso_tema (id_proceso, id_tema)
VALUES (1, 23)
ON CONFLICT (id_proceso, id_tema) DO NOTHING;
```

Pero es más fácil usar la interfaz web en items_formularios.html 😊

## Preguntas Frecuentes

**P: ¿Puedo tener un tema asociado a múltiples procesos?**
R: Sí, un tema puede estar asociado a varios procesos diferentes.

**P: ¿Qué pasa si desactivo una relación?**
R: La relación se mantiene en la base de datos pero no se usará para filtrar temas en los formularios.

**P: ¿Puedo eliminar permanentemente una relación?**
R: Sí, usando el botón de eliminar en la interfaz. Esto borra el registro de la base de datos.

**P: ¿Qué sucede si un proceso no tiene temas asociados?**
R: El formulario mostrará "No hay temas para este proceso" y el usuario no podrá continuar hasta seleccionar otro proceso.

**P: ¿Los usuarios ven esta funcionalidad?**
R: Los usuarios solo ven el efecto (filtrado de temas). Solo los administradores pueden gestionar las relaciones.

## Seguridad

Esta implementación incluye:
- ✅ Protección contra inyección SQL (consultas preparadas)
- ✅ Validación de entrada (verificación de IDs numéricos)
- ✅ Protección contra XSS (escape de HTML)
- ✅ Restricciones de integridad referencial (foreign keys)
- ✅ Headers de seguridad HTTP

## Archivos Modificados/Creados

| Archivo | Tipo | Descripción |
|---------|------|-------------|
| `db/09_create_cap_proceso_tema.sql` | Nuevo | Migración de base de datos |
| `m_capacitaciones/assets/php/proceso_tema_api.php` | Nuevo | API backend |
| `m_capacitaciones/items_formularios.html` | Modificado | Nueva pestaña agregada |
| `m_capacitaciones/assets/js/items_formularios.js` | Modificado | Lógica de gestión de relaciones |
| `m_capacitaciones/assets/js/formulario.js` | Modificado | Lógica de filtrado de temas |

## Soporte

Si encuentras algún problema:
1. Revisa el archivo `TESTING_PROCESO_TEMA.md` para instrucciones de troubleshooting
2. Verifica la consola del navegador (F12) para errores JavaScript
3. Revisa los logs de PHP en el servidor

## Próximos Pasos Sugeridos

1. Agregar más relaciones proceso-tema según necesites
2. Capacitar a los administradores en el uso de la nueva pestaña
3. Informar a los capacitadores sobre el nuevo filtrado automático
4. Considerar agregar un reporte de relaciones proceso-tema para análisis
