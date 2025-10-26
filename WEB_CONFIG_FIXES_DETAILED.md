# Correcciones del Módulo de Configuración Web

## Resumen Ejecutivo

El módulo de configuración web (`/includes/web_main.html`) no estaba aplicando cambios de footer, colores ni otros elementos debido a varios problemas de configuración y autenticación. Este documento detalla los problemas encontrados y las soluciones implementadas.

## Problemas Identificados

### 1. **Problema de Autenticación de la API** (CRÍTICO)
**Problema:** El archivo `php/web_main_api.php` requería autenticación para TODAS las peticiones, incluyendo las peticiones GET para obtener la configuración activa. Esto impedía que las páginas cargaran la configuración cuando:
- El usuario no había iniciado sesión (ej: página de login)
- Había problemas con la sesión
- La sesión había expirado

**Código Problemático:**
```php
// Requería autenticación para TODO
if (!isset($_SESSION['usuario_id']) || !isset($_SESSION['rol_nombre'])) {
    http_response_code(401);
    echo json_encode(['success' => false, 'message' => 'No autorizado']);
    exit;
}
```

**Solución Implementada:**
```php
// Ahora solo requiere autenticación para operaciones de escritura (POST/PUT)
$requiresAuth = ($method !== 'GET');

if ($requiresAuth) {
    // Check authentication only for write operations
    if (!isset($_SESSION['usuario_id']) || !isset($_SESSION['rol_nombre'])) {
        http_response_code(401);
        echo json_encode(['success' => false, 'message' => 'No autorizado']);
        exit;
    }
    // ...
}
```

### 2. **Selectores de Footer Limitados**
**Problema:** La función `updateFooterText()` en `web_config.js` usaba selectores limitados que podían no encontrar todos los elementos de footer en diferentes páginas.

**Código Problemático:**
```javascript
function updateFooterText(text) {
    const footers = document.querySelectorAll('.copyright span, .copyright');
    // Solo 2 selectores
}
```

**Solución Implementada:**
```javascript
function updateFooterText(text) {
    // Múltiples selectores para mayor cobertura
    const selectors = [
        '.copyright span',
        'footer .copyright span',
        '.sticky-footer .copyright span',
        '.copyright',
        'footer .copyright',
        '.sticky-footer .copyright'
    ];
    
    let updated = false;
    selectors.forEach(selector => {
        const elements = document.querySelectorAll(selector);
        elements.forEach(element => {
            if (element.tagName === 'SPAN') {
                element.textContent = text;
                updated = true;
            } else if (element.tagName === 'DIV' && element.querySelector('span')) {
                element.querySelector('span').textContent = text;
                updated = true;
            } else if (element.tagName === 'DIV') {
                element.textContent = text;
                updated = true;
            }
        });
    });
    
    if (!updated) {
        console.warn('No se encontraron elementos de footer para actualizar');
    }
}
```

### 3. **Flash de Contenido Sin Estilizar (FOUC)**
**Problema:** Algunos archivos HTML no tenían el estilo `body { visibility: hidden; }` lo que causaba que el contenido apareciera brevemente sin los estilos de configuración antes de que se aplicaran.

**Archivos Afectados:**
- `index.html` (página de login)
- `m_agronomia/f_cortes.html`
- `m_agronomia/tb_agronomia.html`

**Solución Implementada:**
Se agregó el siguiente estilo en el `<head>` de cada archivo:
```html
<style>body { visibility: hidden; }</style>
```

El script `web_config.js` hace el body visible después de aplicar la configuración:
```javascript
document.body.style.visibility = 'visible';
```

## Archivos Modificados

### 1. `/php/web_main_api.php`
- Modificado el control de autenticación para permitir acceso público a peticiones GET
- Las operaciones de escritura (POST/PUT) siguen requiriendo autenticación de administrador

### 2. `/assets/js/web_config.js`
- Mejorada la función `updateFooterText()` con selectores más robustos
- Agregado logging para debugging

### 3. Archivos HTML Actualizados:
- `/index.html` - Agregado `body { visibility: hidden; }`
- `/m_agronomia/f_cortes.html` - Agregado `body { visibility: hidden; }`
- `/m_agronomia/tb_agronomia.html` - Agregado `body { visibility: hidden; }`

## Cómo Funciona el Sistema Ahora

### Flujo de Carga de Configuración

1. **Carga de Página HTML**
   ```html
   <style>body { visibility: hidden; }</style>
   <script src="assets/js/web_config.js"></script>
   ```

2. **El Script web_config.js se Ejecuta**
   ```javascript
   // Intenta cargar configuración desde la API
   const response = await fetch('/php/web_main_api.php?action=get_active');
   ```

3. **La API Responde (Sin Requerir Autenticación)**
   ```php
   // GET requests are now public
   if ($method === 'GET') {
       handleGet($pg);
   }
   ```

4. **Aplicación de la Configuración**
   ```javascript
   // Aplica título, footer, colores, favicon
   applyWebConfig(config);
   
   // Hace visible el body
   document.body.style.visibility = 'visible';
   ```

### Configuraciones Aplicadas

El sistema aplica las siguientes configuraciones de manera centralizada:

1. **Título de la Página**: `<title>` tag
2. **Texto del Footer**: Todos los elementos con clase `.copyright`
3. **Color Principal**: Variables CSS y estilos dinámicos para:
   - Botones primarios
   - Enlaces
   - Sidebar
   - Headers con clase `.text-primary`
   - Elementos de navegación
4. **Favicon**: `<link rel="icon">` en el `<head>`
5. **Imagen de Login**: Background de `.bg-login-image` (solo en index.html)

## Base de Datos

### Tabla: adm_webmain

El script de migración está en: `/db/migration_adm_webmain.sql`

**Estructura:**
```sql
CREATE TABLE public.adm_webmain (
  id integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  site_title varchar(100) NOT NULL DEFAULT 'OSM',
  footer_text varchar(200) NOT NULL DEFAULT '© OSM 2025',
  favicon_path varchar(255) NOT NULL DEFAULT 'assets/img/Sin título-2.png',
  login_image_path varchar(255) NOT NULL DEFAULT 'assets/img/ico.jpg',
  primary_color varchar(7) NOT NULL DEFAULT '#772e22',
  is_active boolean NOT NULL DEFAULT true,
  theme_name varchar(50),
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);
```

**Para ejecutar la migración:**
```bash
psql -U postgres -d osm2 -f db/migration_adm_webmain.sql
```

## Verificación

### Cómo Verificar que Funciona

1. **Verificar que la tabla existe:**
   ```sql
   SELECT * FROM adm_webmain WHERE is_active = true;
   ```

2. **Acceder a la página de configuración:**
   - URL: `/includes/web_main.html`
   - Requiere rol de Administrador

3. **Probar cambios:**
   - Cambiar el texto del footer
   - Cambiar el color principal
   - Guardar
   - Recargar cualquier página del sitio
   - Verificar que los cambios se apliquen

4. **Verificar en páginas sin autenticación:**
   - Abrir `/index.html` (página de login)
   - El footer y colores deben mostrar la configuración guardada
   - Usar DevTools para verificar que no hay errores 401/403

### Console Log Esperado

En la consola del navegador deberías ver:
```
[web_config.js] Configuración cargada exitosamente
[web_config.js] Footer actualizado: true
```

Si hay problemas:
```
[web_config.js] Error al cargar configuración web: [error details]
[web_config.js] Usando configuración por defecto
```

## Páginas Afectadas (Todas las páginas HTML)

Todas las páginas del sistema incluyen `web_config.js` y aplicarán la configuración:

- `/index.html` - Login
- `/panel.html` - Panel principal
- `/Usuarios.html` - Gestión de usuarios
- `/sesiones.html` - Sesiones
- `/m_admin/*.html` - Módulo de administración
- `/m_capacitaciones/*.html` - Módulo de capacitaciones
- `/m_agronomia/*.html` - Módulo de agronomía
- `/m_bascula/*.html` - Módulo de báscula
- `/includes/web_main.html` - Configuración web (interfaz de administración)

## Seguridad

### Consideraciones de Seguridad

1. **Acceso Público a Configuración de Lectura**: 
   - Las peticiones GET a la API ahora son públicas
   - Esto es seguro porque solo expone información de presentación (colores, texto)
   - No expone información sensible

2. **Operaciones de Escritura Protegidas**:
   - POST y PUT siguen requiriendo autenticación de administrador
   - Solo administradores pueden modificar la configuración

3. **Validación de Entrada**:
   - La API valida todos los datos antes de guardarlos
   - Los colores deben estar en formato hexadecimal válido
   - Las rutas de archivos son validadas

## Próximos Pasos / Mejoras Futuras

1. **Cache de Configuración**: Implementar localStorage para cachear la configuración y reducir peticiones a la API
2. **Fallback Más Robusto**: Mejorar el manejo de errores cuando la base de datos no está disponible
3. **Previsualización en Vivo**: Agregar preview en tiempo real en la interfaz de configuración
4. **Temas Predefinidos**: Expandir los 3 temas guardados a una biblioteca de temas
5. **Validación de Contraste**: Asegurar que los colores seleccionados cumplan con WCAG para accesibilidad

## Comandos Útiles

### Verificar configuración actual:
```bash
curl http://localhost/php/web_main_api.php?action=get_active | jq
```

### Ver logs de PostgreSQL:
```bash
sudo tail -f /var/log/postgresql/postgresql-*.log
```

### Reiniciar servidor web:
```bash
sudo systemctl restart apache2
# o
sudo systemctl restart nginx
```

## Soporte

Para problemas o preguntas sobre este módulo:
1. Revisar los logs del navegador (Console)
2. Revisar los logs del servidor web
3. Verificar que PostgreSQL está ejecutándose
4. Verificar que la tabla `adm_webmain` existe y tiene datos

---

**Fecha de Última Actualización**: 2025-10-26
**Versión**: 1.0
**Autor**: Copilot Agent
