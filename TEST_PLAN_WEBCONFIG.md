# Test Plan - Web Configuration Module

## Objetivo
Verificar que el módulo de configuración web funciona correctamente después de las correcciones implementadas.

## Pre-requisitos
- PostgreSQL instalado y ejecutándose
- Base de datos `osm2` creada
- Usuario `postgres` con contraseña `12345` (o configurado en `php/db_postgres.php`)
- Servidor web (Apache/Nginx) ejecutándose con PHP
- Tabla `adm_webmain` creada (ejecutar `db/migration_adm_webmain.sql`)

## Setup de Base de Datos

### 1. Verificar/Crear la Tabla
```bash
psql -U postgres -d osm2 -f db/migration_adm_webmain.sql
```

**Resultado esperado:** Tabla creada con configuración por defecto

### 2. Verificar Instalación
```bash
psql -U postgres -d osm2 -f db/verify_webmain_config.sql
```

**Resultado esperado:**
```
✓ Tabla adm_webmain: EXISTE
✓ Configuración Activa: EXISTE
✓ Registro con is_active = true
```

## Tests Funcionales

### Test 1: API Sin Autenticación (GET)
**Objetivo:** Verificar que la API permite lectura sin autenticación

**Pasos:**
1. Abrir navegador en modo incógnito (sin sesión)
2. Ir a: `http://localhost/php/web_main_api.php?action=get_active`

**Resultado esperado:**
```json
{
  "success": true,
  "data": {
    "id": 1,
    "site_title": "OSM",
    "footer_text": "© OSM 2025",
    "primary_color": "#772e22",
    "is_active": true,
    "theme_name": "Default",
    ...
  }
}
```

**✅ PASS:** API responde con código 200 y datos de configuración
**❌ FAIL:** API responde con código 401 o 403

---

### Test 2: Página de Login Sin Sesión
**Objetivo:** Verificar que la página de login carga y aplica configuración

**Pasos:**
1. Cerrar sesión o usar modo incógnito
2. Abrir: `http://localhost/index.html`
3. Abrir DevTools > Console
4. Verificar que no hay errores 401/403

**Resultado esperado:**
- Página carga correctamente
- Footer muestra el texto configurado
- Colores aplicados según configuración
- Console log: `[web_config.js] Configuración cargada exitosamente`

**✅ PASS:** Página carga con configuración aplicada, sin errores en consola
**❌ FAIL:** Errores 401/403 en consola, o página usa valores predeterminados hardcodeados

---

### Test 3: Cambio de Footer Text
**Objetivo:** Verificar que el cambio de footer se aplica a todas las páginas

**Pasos:**
1. Login como Administrador
2. Ir a: `http://localhost/includes/web_main.html`
3. Cambiar "Texto del Footer" a: `TEST FOOTER - 2025`
4. Guardar configuración
5. Esperar mensaje de éxito
6. Abrir estas páginas en nuevas pestañas:
   - `/index.html` (logout primero)
   - `/panel.html`
   - `/Usuarios.html`
   - `/m_capacitaciones/formulario.html`
   - `/m_agronomia/f_cortes.html`

**Resultado esperado:**
- Todas las páginas muestran: `TEST FOOTER - 2025` en el footer
- El cambio es visible inmediatamente sin limpiar caché

**✅ PASS:** Footer actualizado en TODAS las páginas
**❌ FAIL:** Footer no cambia o solo cambia en algunas páginas

---

### Test 4: Cambio de Color Principal
**Objetivo:** Verificar que el cambio de color se aplica globalmente

**Pasos:**
1. Login como Administrador
2. Ir a: `http://localhost/includes/web_main.html`
3. Cambiar "Color Principal" a: `#0066cc` (azul)
4. Guardar configuración
5. Verificar en `/panel.html`:
   - Botones primarios son azules
   - Sidebar es azul
   - Headers con clase `.text-primary` son azules
   - Enlaces son azules

**Resultado esperado:**
- Todos los elementos principales cambian al color azul
- Sidebar cambia de color inmediatamente
- Botones cambian de color

**✅ PASS:** Color aplicado consistentemente en todos los elementos
**❌ FAIL:** Algunos elementos no cambian de color

---

### Test 5: Prevención de FOUC
**Objetivo:** Verificar que no hay "flash" de contenido sin estilizar

**Pasos:**
1. Configurar un color distintivo (ej: `#ff0000` rojo)
2. Logout
3. Abrir `index.html` con red throttling (DevTools > Network > Slow 3G)
4. Observar la carga de la página

**Resultado esperado:**
- Página permanece oculta hasta que se aplica configuración
- No se ve un "flash" de colores incorrectos
- Página aparece directamente con el color correcto

**✅ PASS:** No hay FOUC, página aparece con estilos correctos
**❌ FAIL:** Se ve un "flash" de colores predeterminados antes de aplicar configuración

---

### Test 6: Protección de Escritura
**Objetivo:** Verificar que solo Administradores pueden modificar configuración

**Pasos:**
1. Login como usuario NO Administrador (si existe otro rol)
2. Intentar acceder: `http://localhost/includes/web_main.html`

**Resultado esperado (si hay control de acceso en HTML):**
- Página no es accesible o muestra mensaje de error

**Pasos alternativos:**
1. Abrir DevTools > Console
2. Ejecutar:
```javascript
fetch('/php/web_main_api.php', {
  method: 'PUT',
  headers: {'Content-Type': 'application/json'},
  body: JSON.stringify({
    id: 1,
    site_title: 'HACK',
    footer_text: 'HACKED',
    primary_color: '#000000',
    is_active: true,
    theme_name: 'Default'
  })
}).then(r => r.json()).then(console.log)
```

**Resultado esperado:**
```json
{
  "success": false,
  "message": "Acceso denegado. Solo administradores..."
}
```

**✅ PASS:** PUT request es rechazado sin autenticación de administrador
**❌ FAIL:** PUT request es aceptado

---

### Test 7: Cambio de Título de Sitio
**Objetivo:** Verificar que el título de la página cambia

**Pasos:**
1. Login como Administrador
2. Ir a: `http://localhost/includes/web_main.html`
3. Cambiar "Título del Sitio" a: `TEST SYSTEM`
4. Guardar
5. Abrir nueva pestaña con `/panel.html`

**Resultado esperado:**
- La pestaña del navegador muestra: `TEST SYSTEM`
- Todas las páginas usan el nuevo título

**✅ PASS:** Título actualizado en todas las páginas
**❌ FAIL:** Título no cambia

---

### Test 8: Temas Guardados
**Objetivo:** Verificar funcionalidad de guardar y aplicar temas

**Pasos:**
1. Login como Administrador
2. Ir a: `http://localhost/includes/web_main.html`
3. Configurar:
   - Color: `#28a745` (verde)
   - Footer: `Tema Verde`
4. Click "Guardar como Nuevo Tema"
5. Nombre: `Verde`
6. Configurar otro tema:
   - Color: `#dc3545` (rojo)
   - Footer: `Tema Rojo`
7. Click "Guardar como Nuevo Tema"
8. Nombre: `Rojo`
9. En "Temas Guardados", click "Aplicar" en tema Verde
10. Verificar que se aplica el tema verde

**Resultado esperado:**
- Ambos temas se guardan
- Se pueden aplicar alternativamente
- La página se recarga con el tema seleccionado

**✅ PASS:** Temas se guardan y aplican correctamente
**❌ FAIL:** Error al guardar o aplicar temas

---

## Tests de Regresión

### Test 9: Todas las Páginas HTML Cargan
**Objetivo:** Verificar que los cambios no rompieron ninguna página

**Pasos:**
Abrir cada página y verificar que carga sin errores en consola:
- [ ] `/index.html`
- [ ] `/panel.html`
- [ ] `/Usuarios.html`
- [ ] `/sesiones.html`
- [ ] `/m_admin/ed_usuario.html`
- [ ] `/m_capacitaciones/formulario.html`
- [ ] `/m_agronomia/f_cortes.html`
- [ ] `/m_agronomia/tb_agronomia.html`

**✅ PASS:** Todas las páginas cargan sin errores
**❌ FAIL:** Alguna página tiene errores JavaScript

---

### Test 10: Selectores de Footer
**Objetivo:** Verificar que los nuevos selectores encuentran todos los footers

**Pasos:**
1. Abrir DevTools en `/panel.html`
2. En Console, ejecutar:
```javascript
document.querySelectorAll('.copyright span, footer .copyright span, .sticky-footer .copyright span, .copyright, footer .copyright, .sticky-footer .copyright').length
```

**Resultado esperado:**
- Número > 0 (al menos 1 elemento encontrado)

**✅ PASS:** Selectores encuentran elementos de footer
**❌ FAIL:** Resultado es 0

---

## Tests de Performance

### Test 11: Tiempo de Carga
**Objetivo:** Verificar que los cambios no afectan negativamente el performance

**Pasos:**
1. Abrir DevTools > Network
2. Recargar `/panel.html`
3. Medir tiempo de carga de `web_config.js`
4. Medir tiempo de respuesta de API

**Resultado esperado:**
- `web_config.js`: < 100ms
- API response: < 200ms
- Página total: < 2 segundos

**✅ PASS:** Tiempos dentro de límites aceptables
**❌ FAIL:** Tiempos excesivos

---

## Resultados del Test

### Summary
| Test | Status | Notes |
|------|--------|-------|
| 1. API Sin Auth | ⬜ | |
| 2. Login Sin Sesión | ⬜ | |
| 3. Cambio Footer | ⬜ | |
| 4. Cambio Color | ⬜ | |
| 5. Prevención FOUC | ⬜ | |
| 6. Protección Escritura | ⬜ | |
| 7. Cambio Título | ⬜ | |
| 8. Temas Guardados | ⬜ | |
| 9. Páginas HTML | ⬜ | |
| 10. Selectores Footer | ⬜ | |
| 11. Performance | ⬜ | |

### Leyenda
- ✅ PASS
- ❌ FAIL
- ⬜ NOT TESTED

---

## Troubleshooting

### Si los tests fallan:

1. **Verificar base de datos:**
   ```bash
   psql -U postgres -d osm2 -c "SELECT * FROM adm_webmain WHERE is_active = true;"
   ```

2. **Verificar permisos de archivos:**
   ```bash
   ls -la php/web_main_api.php
   ls -la assets/js/web_config.js
   ```

3. **Verificar logs del servidor:**
   ```bash
   tail -f /var/log/apache2/error.log
   # o
   tail -f /var/log/nginx/error.log
   ```

4. **Verificar consola del navegador:**
   - Abrir DevTools > Console
   - Buscar errores en rojo
   - Verificar network requests

---

**Ejecutado por:** _______________
**Fecha:** _______________
**Resultado general:** ⬜ PASS / ⬜ FAIL
