# Módulo de Configuración Web - Guía de Usuario

## Descripción

El módulo de configuración web permite personalizar aspectos visuales de todo el sitio desde un solo lugar, sin necesidad de editar cada archivo HTML individualmente.

## Cambios que se Pueden Hacer

1. **Título del Sitio**: El texto que aparece en la pestaña del navegador
2. **Texto del Footer**: El texto que aparece en el pie de página de todas las páginas
3. **Color Principal**: El color de botones, enlaces, sidebar y elementos principales
4. **Favicon**: El icono que aparece en la pestaña del navegador
5. **Imagen de Login**: La imagen que aparece en la página de inicio de sesión

## Cómo Usar

### 1. Acceder al Módulo

1. Iniciar sesión como **Administrador**
2. Navegar a: `/includes/web_main.html`
3. Verás la interfaz de configuración

### 2. Cambiar la Configuración Actual

#### Cambiar el Texto del Footer
1. En el campo "Texto del Footer", escribir el nuevo texto
   - Ejemplo: `© Mi Empresa 2025 - Todos los derechos reservados`
2. Hacer clic en "Guardar Configuración"
3. Recargar cualquier página para ver el cambio

#### Cambiar el Color Principal
1. Hacer clic en el selector de color o escribir un código hexadecimal
   - Ejemplo de colores:
     - Azul: `#0066cc`
     - Verde: `#28a745`
     - Rojo: `#dc3545`
     - Naranja: `#fd7e14`
2. Hacer clic en "Guardar Configuración"
3. La página se recargará automáticamente con el nuevo color

#### Cambiar el Título del Sitio
1. En el campo "Título del Sitio", escribir el nuevo título
   - Ejemplo: `Sistema OSM - Gestión Empresarial`
2. Hacer clic en "Guardar Configuración"
3. Abrir una nueva pestaña para ver el nuevo título

#### Cambiar el Favicon
1. Hacer clic en "Elegir archivo" junto a "Icono del Sitio"
2. Seleccionar una imagen (PNG, JPG, ICO)
   - Recomendado: 32x32 o 64x64 píxeles
3. Hacer clic en "Subir"
4. Hacer clic en "Guardar Configuración"
5. El nuevo favicon aparecerá en todas las páginas

#### Cambiar la Imagen de Login
1. Hacer clic en "Elegir archivo" junto a "Imagen de Inicio de Sesión"
2. Seleccionar una imagen (PNG, JPG)
   - Recomendado: Proporción cuadrada o vertical
3. Hacer clic en "Subir"
4. Hacer clic en "Guardar Configuración"
5. Visitar `/index.html` para ver la nueva imagen

### 3. Guardar Temas Personalizados

Si quieres guardar diferentes combinaciones de colores y configuraciones:

1. Configurar todos los campos con los valores deseados
2. Hacer clic en "Guardar como Nuevo Tema"
3. Escribir un nombre descriptivo (ej: "Tema Oscuro", "Tema Navidad")
4. El tema aparecerá en la sección "Temas Guardados"

**Nota**: Solo se pueden guardar máximo 3 temas.

### 4. Aplicar un Tema Guardado

1. En la sección "Temas Guardados", encontrar el tema deseado
2. Hacer clic en el botón "Aplicar" del tema
3. La página se recargará con la nueva configuración
4. Todos los usuarios verán los cambios inmediatamente

## Aplicación Automática de Cambios

**Los cambios se aplican automáticamente en todas las páginas:**
- ✅ Página de Login (`/index.html`)
- ✅ Panel Principal (`/panel.html`)
- ✅ Módulo de Usuarios
- ✅ Módulo de Capacitaciones
- ✅ Módulo de Agronomía
- ✅ Módulo de Báscula
- ✅ Todas las demás páginas del sistema

**No es necesario editar cada archivo HTML individualmente.**

## Solución de Problemas

### Los cambios no se aplican

1. **Verificar que guardaste:**
   - Asegúrate de hacer clic en "Guardar Configuración"
   - Busca el mensaje "Configuración guardada exitosamente"

2. **Limpiar caché del navegador:**
   - Presionar `Ctrl + Shift + R` (Windows/Linux)
   - Presionar `Cmd + Shift + R` (Mac)

3. **Verificar rol de usuario:**
   - Solo los Administradores pueden cambiar la configuración
   - Otros usuarios pueden ver los cambios pero no modificarlos

### Los colores no cambian

1. **Esperar a que se complete la carga:**
   - Después de guardar, la página se recarga automáticamente
   - Esperar 2-3 segundos

2. **Verificar formato del color:**
   - Debe ser hexadecimal: `#` seguido de 6 caracteres
   - Ejemplo correcto: `#ff6600`
   - Ejemplo incorrecto: `ff6600` (falta el #)

### Las imágenes no se muestran

1. **Verificar formato de imagen:**
   - Formatos soportados: PNG, JPG, JPEG
   - Tamaño máximo recomendado: 2MB

2. **Verificar que se subió correctamente:**
   - Hacer clic en "Subir" después de seleccionar el archivo
   - Debe aparecer una vista previa de la imagen
   - El campo de ruta debe llenarse automáticamente

3. **Hacer clic en "Guardar Configuración":**
   - Subir la imagen NO la guarda automáticamente
   - Debes hacer clic en "Guardar Configuración" después

## Configuración Predeterminada

Si algo sale mal, estos son los valores predeterminados:

```
Título del Sitio: OSM
Texto del Footer: © OSM 2025
Color Principal: #772e22 (marrón rojizo)
Favicon: assets/img/Sin título-2.png
Imagen de Login: assets/img/ico.jpg
```

Para restaurar valores predeterminados:
1. Ingresar estos valores manualmente
2. Hacer clic en "Guardar Configuración"

## Recomendaciones

### Para el Color Principal
- Usar colores que contrasten bien con blanco
- Evitar amarillos o colores muy claros (difíciles de leer)
- Probar la legibilidad en diferentes secciones del sitio

### Para el Texto del Footer
- Mantenerlo breve (máximo 200 caracteres)
- Incluir el año actual
- Incluir el nombre de la empresa

### Para las Imágenes
- **Favicon**: 32x32 o 64x64 píxeles, fondo transparente
- **Login**: Proporción cuadrada o vertical, alta resolución

## Características de Seguridad

- Solo usuarios con rol **Administrador** pueden modificar la configuración
- Los cambios se registran en la base de datos con fecha y hora
- La configuración anterior no se pierde (se guarda el historial)
- Las operaciones requieren autenticación activa

## Preguntas Frecuentes

**P: ¿Los cambios afectan a todos los usuarios?**
R: Sí, todos los usuarios verán los cambios inmediatamente en todas las páginas.

**P: ¿Puedo deshacer un cambio?**
R: Sí, si guardaste el tema anterior, puedes aplicarlo nuevamente desde "Temas Guardados".

**P: ¿Cuántos temas puedo guardar?**
R: Máximo 3 temas. Si quieres crear uno nuevo, primero debes eliminar uno existente.

**P: ¿Los cambios requieren reiniciar el servidor?**
R: No, los cambios son inmediatos y no requieren reiniciar nada.

**P: ¿Puedo usar colores con degradados?**
R: No, solo colores sólidos en formato hexadecimal.

---

Para soporte técnico adicional, consultar el documento `WEB_CONFIG_FIXES_DETAILED.md`
