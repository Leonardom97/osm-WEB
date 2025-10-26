# Guía de Instalación - Módulo de Configuración Web

## 🎯 Resumen

Este módulo te permite gestionar desde un solo lugar:
- ✅ Título del sitio (pestaña del navegador)
- ✅ Texto del footer ("© OSM 2025")
- ✅ Icono del sitio (favicon)
- ✅ Imagen de inicio de sesión
- ✅ Color principal del tema
- ✅ Guardar hasta 3 temas diferentes

**Acceso:** Solo administradores pueden usar este módulo.

---

## 📋 Pasos de Instalación

### 1. Ejecutar la Migración de Base de Datos

Conecta a tu base de datos PostgreSQL y ejecuta:

```bash
psql -U postgres -d osm2 -f db/migration_adm_webmain.sql
```

O si prefieres usar pgAdmin:
1. Abre pgAdmin
2. Conecta a la base de datos `osm2`
3. Abre el archivo `db/migration_adm_webmain.sql`
4. Ejecuta el script

**Verificación:**
```sql
-- Verifica que la tabla se creó
SELECT * FROM adm_webmain;
```

Deberías ver 1 registro con la configuración por defecto.

---

## 🎨 Uso del Módulo

### Acceder a la Configuración

1. Inicia sesión como **administrador**
2. En el menú lateral, ve a: **Administrador** → **Configuración Web**
3. Se abrirá la página de configuración

### Cambiar el Título del Sitio

1. En el campo "Título del Sitio", ingresa el nuevo título
2. Este aparecerá en la pestaña del navegador de todas las páginas
3. Clic en "Guardar Configuración"

### Cambiar el Texto del Footer

1. En el campo "Texto del Footer", ingresa el nuevo texto
2. Ejemplo: "© OSM 2025 - Todos los derechos reservados"
3. Este texto aparecerá en el pie de todas las páginas
4. Clic en "Guardar Configuración"

### Cambiar el Icono del Sitio

1. En "Icono del Sitio (Favicon)":
   - Clic en "Seleccionar archivo"
   - Elige una imagen (JPG, PNG, GIF, WEBP)
   - Clic en "Subir"
2. La ruta se llenará automáticamente
3. Verás una vista previa de la imagen
4. Clic en "Guardar Configuración"

### Cambiar la Imagen de Inicio de Sesión

1. En "Imagen de Inicio de Sesión":
   - Clic en "Seleccionar archivo"
   - Elige una imagen (JPG, PNG, GIF, WEBP)
   - Clic en "Subir"
2. La ruta se llenará automáticamente
3. Verás una vista previa de la imagen
4. Clic en "Guardar Configuración"

### Cambiar el Color del Tema

1. En "Color Principal":
   - Clic en el selector de color
   - Elige tu color preferido
   - O ingresa un código hexadecimal (ej: #772e22)
2. El color afectará:
   - Sidebar (menú lateral)
   - Botones
   - Enlaces
   - Elementos activos
3. Clic en "Guardar Configuración"

### Guardar Temas Personalizados

1. Configura todos los valores como desees
2. Clic en "Guardar como Nuevo Tema"
3. Ingresa un nombre descriptivo (ej: "Tema Navidad", "Tema Verano")
4. El tema se guardará para uso futuro

**Límite:** Máximo 3 temas guardados.

### Cambiar entre Temas

1. Mira la sección "Temas Guardados" en la parte inferior
2. Verás tarjetas con cada tema guardado
3. Clic en "Aplicar" en el tema que desees activar
4. Los cambios se aplicarán inmediatamente en todas las páginas

---

## 🔍 Verificación de Cambios

Después de guardar la configuración:

1. **Título**: 
   - Abre cualquier página
   - Mira la pestaña del navegador
   - Debe mostrar el nuevo título

2. **Footer**:
   - Desplázate al final de cualquier página
   - Verifica el nuevo texto en el pie de página

3. **Icono**:
   - Mira la pestaña del navegador
   - Debe mostrar el nuevo icono

4. **Imagen de Login**:
   - Cierra sesión
   - Mira la imagen en el lado izquierdo de la página de login

5. **Color del Tema**:
   - Observa el menú lateral
   - Observa los botones
   - Deben reflejar el nuevo color

---

## ⚠️ Notas Importantes

### Seguridad
- ✅ Solo usuarios con rol "Administrador" pueden acceder
- ✅ Los colaboradores NO pueden ver ni modificar estas configuraciones
- ✅ Se valida la sesión en cada operación

### Imágenes
- **Tamaño máximo**: 5 MB por archivo
- **Formatos permitidos**: JPG, PNG, GIF, WEBP
- **Recomendaciones**:
  - Favicon: 512x512 píxeles o similar
  - Login: 800x600 píxeles o proporcional

### Límites
- **Temas guardados**: Máximo 3
- Si necesitas guardar uno nuevo, elimina uno existente primero

### Colores
- Usa el formato hexadecimal: #RRGGBB
- Ejemplos válidos: #772e22, #FF5733, #00A8FF
- El sistema genera automáticamente los colores complementarios

---

## 🐛 Solución de Problemas

### No puedo acceder a la página de configuración
**Problema**: Aparece error 403 o "Acceso denegado"
**Solución**: 
- Verifica que tu usuario tenga rol "Administrador"
- Verifica que tu sesión esté activa
- Intenta cerrar sesión y volver a iniciar

### Los cambios no se aplican
**Problema**: Guardo la configuración pero no veo cambios
**Solución**:
- Refresca la página (F5 o Ctrl+R)
- Limpia la caché del navegador
- Verifica que la base de datos tenga el registro actualizado

### Error al subir imágenes
**Problema**: "Error al subir el archivo"
**Solución**:
- Verifica que el archivo sea menor a 5 MB
- Verifica que el formato sea JPG, PNG, GIF o WEBP
- Verifica los permisos de la carpeta `assets/img/uploads`

### El color no se aplica correctamente
**Problema**: El color se guarda pero algunos elementos no cambian
**Solución**:
- Usa el formato hexadecimal correcto (#772e22)
- Refresca completamente la página
- Verifica que no haya CSS personalizado que sobrescriba los colores

---

## 📞 Soporte

Si encuentras algún problema o necesitas ayuda:

1. Revisa el archivo `WEB_CONFIG_README.md` (documentación técnica completa)
2. Revisa el archivo `BEFORE_AFTER_COMPARISON.md` (comparación antes/después)
3. Consulta con el equipo de desarrollo

---

## ✅ Lista de Verificación Post-Instalación

Después de instalar, verifica:

- [ ] La migración de base de datos se ejecutó sin errores
- [ ] Existe 1 registro en la tabla `adm_webmain`
- [ ] Puedes acceder a la página de configuración como administrador
- [ ] Los colaboradores NO pueden acceder a la página de configuración
- [ ] Puedes cambiar el título y se refleja en las páginas
- [ ] Puedes cambiar el footer y se refleja en las páginas
- [ ] Puedes subir imágenes sin errores
- [ ] Puedes cambiar el color del tema y se aplica correctamente
- [ ] Puedes guardar un tema nuevo
- [ ] Puedes cambiar entre temas guardados

---

## 🎉 ¡Listo!

Tu sistema ahora tiene un módulo completo de gestión de configuración web. 

**Recuerda:** Todos los cambios se aplicarán inmediatamente en todas las páginas del sitio, sin necesidad de editar código o reiniciar el servidor.
