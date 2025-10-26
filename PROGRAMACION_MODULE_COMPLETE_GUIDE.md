# MÓDULO DE PROGRAMACIÓN DE CAPACITACIONES - GUÍA COMPLETA

## 📋 Índice
1. [Descripción General](#descripción-general)
2. [Arquitectura del Sistema](#arquitectura-del-sistema)
3. [Flujo de Datos](#flujo-de-datos)
4. [Componentes del Sistema](#componentes-del-sistema)
5. [Instalación y Configuración](#instalación-y-configuración)
6. [Pruebas de Funcionamiento](#pruebas-de-funcionamiento)
7. [Casos de Uso](#casos-de-uso)

---

## 📖 Descripción General

El **Módulo de Programación de Capacitaciones** permite a los administradores y capacitadores gestionar la programación periódica de capacitaciones para los colaboradores según su cargo y sub-área.

### Características Principales:
- ✅ **Programación Periódica**: Definir frecuencia de capacitaciones (en meses)
- ✅ **Gestión por Cargo y Sub-Área**: Asignación específica según posición y área
- ✅ **Notificaciones Automáticas**: Sistema de alertas para capacitaciones vencidas/próximas
- ✅ **Importación Masiva**: Carga de programaciones desde Excel
- ✅ **Seguimiento de Estado**: Monitoreo de colaboradores pendientes por capacitación
- ✅ **Alertas al Capacitador**: Notificaciones de capacitaciones que vencen en 7 días

---

## 🏗️ Arquitectura del Sistema

```
┌─────────────────────────────────────────────────────────────────┐
│                    FRONTEND (programacion.html)                  │
│  - Interfaz de usuario                                           │
│  - Gestión de formularios                                        │
│  - Importación de Excel                                          │
│  - Filtros y visualización                                       │
└───────────────────┬─────────────────────────────────────────────┘
                    │
                    │ JavaScript (programacion.js)
                    │ - AJAX calls
                    │ - Manejo de eventos
                    │ - Validaciones
                    ▼
┌─────────────────────────────────────────────────────────────────┐
│              BACKEND API (programacion_api.php)                  │
│  Actions:                                                        │
│  - list          : Listar todas las programaciones               │
│  - get           : Obtener una programación específica           │
│  - create        : Crear nueva programación                      │
│  - update        : Actualizar programación existente             │
│  - delete        : Eliminar (soft delete) programación           │
│  - bulk_import   : Importación masiva desde Excel                │
│  - get_roles     : Obtener roles de capacitadores                │
│  - get_cargos    : Obtener lista de cargos                       │
│  - get_temas     : Obtener lista de temas                        │
│  - get_sub_areas : Obtener lista de sub-áreas                    │
└───────────────────┬─────────────────────────────────────────────┘
                    │
                    │ PDO/PostgreSQL
                    │
                    ▼
┌─────────────────────────────────────────────────────────────────┐
│                     BASE DE DATOS (PostgreSQL)                   │
│                                                                   │
│  Tablas Principales:                                             │
│  ┌─────────────────────┐                                         │
│  │  cap_programacion   │  ← Programaciones de capacitaciones    │
│  │  - id               │                                         │
│  │  - id_tema          │                                         │
│  │  - id_cargo         │                                         │
│  │  - sub_area         │                                         │
│  │  - frecuencia_meses │                                         │
│  │  - id_rol_capacitador│                                        │
│  │  - activo           │                                         │
│  └──────────┬──────────┘                                         │
│             │                                                     │
│             │ FK                                                  │
│             ▼                                                     │
│  ┌─────────────────────┐                                         │
│  │ cap_notificaciones  │  ← Notificaciones individuales         │
│  │  - id               │                                         │
│  │  - id_colaborador   │                                         │
│  │  - id_programacion  │                                         │
│  │  - fecha_proxima    │                                         │
│  │  - dias_para_venc.  │                                         │
│  │  - estado           │                                         │
│  └─────────────────────┘                                         │
│                                                                   │
│  Función Stored:                                                 │
│  actualizar_notificaciones_capacitacion()                        │
│  - Crea/actualiza notificaciones basadas en programaciones       │
│  - Calcula próximas fechas según frecuencia                      │
│  - Determina estado (pendiente/proximo_vencer/vencida/vigente)   │
│                                                                   │
└─────────────────────────────────────────────────────────────────┘
```

---

## 🔄 Flujo de Datos

### 1. Flujo de Creación de Programación

```
Usuario → Formulario → Validación → API (create) → INSERT cap_programacion
                                                    ↓
                                          actualizar_notificaciones()
                                                    ↓
                                          CREATE cap_notificaciones
                                                    ↓
                                          Calcular colaboradores afectados
                                                    ↓
                                          Determinar fechas y estados
```

### 2. Flujo de Actualización de Notificaciones

```
Trigger → actualizar_notificaciones_capacitacion()
                        ↓
        1. Obtener colaboradores activos (A, V, P)
                        ↓
        2. Buscar programaciones activas por cargo/sub_area
                        ↓
        3. Buscar última capacitación completada (cap_formulario_asistente)
                        ↓
        4. Calcular próxima fecha (última + frecuencia_meses)
                        ↓
        5. Calcular días para vencimiento
                        ↓
        6. Determinar estado:
           - Sin capacitación previa: "pendiente"
           - Fecha pasada: "vencida"
           - Dentro de 30 días: "proximo_vencer"
           - Más de 30 días: "vigente"
                        ↓
        7. INSERT/UPDATE cap_notificaciones
```

### 3. Flujo de Visualización

```
Carga Página → Load Data (Promise.all)
                    ↓
    ┌───────────────┴───────────────┬─────────────────┬──────────────┐
    ▼                               ▼                 ▼              ▼
list programmings            get_cargos        get_temas      get_roles
    │                               │                 │              │
    └───────────────┬───────────────┴─────────────────┴──────────────┘
                    ▼
            Renderizar Tabla
                    ↓
        Mostrar alertas de capacitador (7 días)
                    ↓
            Aplicar filtros
```

---

## 🧩 Componentes del Sistema

### 1. Frontend (programacion.html)

**Estructura:**
- **Navbar/Sidebar**: Navegación incluida dinámicamente
- **Alertas de Capacitador**: Muestra capacitaciones que vencen en ≤7 días
- **Filtros**: Por cargo, tema y rol capacitador
- **Tabla de Programaciones**: Lista completa con estados
- **Modal de Creación/Edición**: Formulario para gestionar programaciones
- **Modal de Importación**: Carga masiva desde Excel

**Características:**
- ✅ Badges de color según urgencia (vencida, próxima, normal)
- ✅ Contador de colaboradores pendientes
- ✅ Botones de acción (editar, eliminar)
- ✅ Validación de formularios

### 2. Backend (programacion_api.php)

**Acciones Disponibles:**

| Acción | Método | Descripción |
|--------|--------|-------------|
| `list` | GET | Lista todas las programaciones activas con estadísticas |
| `get` | GET | Obtiene detalles de una programación específica |
| `create` | POST | Crea nueva programación y actualiza notificaciones |
| `update` | POST | Actualiza programación existente |
| `delete` | POST | Eliminación lógica (activo=false) |
| `bulk_import` | POST | Importación masiva desde Excel |
| `get_roles` | GET | Lista roles de capacitadores |
| `get_cargos` | GET | Lista todos los cargos |
| `get_temas` | GET | Lista todos los temas |
| `get_sub_areas` | GET | Lista sub-áreas disponibles |

### 3. Base de Datos

**Tabla: cap_programacion**
```sql
CREATE TABLE cap_programacion (
  id SERIAL PRIMARY KEY,
  id_tema INTEGER NOT NULL REFERENCES cap_tema(id),
  id_cargo VARCHAR(255) NOT NULL REFERENCES adm_cargos(id_cargo),
  sub_area VARCHAR(255),
  frecuencia_meses INTEGER NOT NULL DEFAULT 12,
  id_rol_capacitador INTEGER NOT NULL REFERENCES adm_roles(id),
  fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  activo BOOLEAN DEFAULT true
);
```

**Tabla: cap_notificaciones**
```sql
CREATE TABLE cap_notificaciones (
  id SERIAL PRIMARY KEY,
  id_colaborador INTEGER NOT NULL REFERENCES adm_colaboradores(ac_id),
  id_programacion INTEGER NOT NULL REFERENCES cap_programacion(id),
  fecha_ultima_capacitacion DATE,
  fecha_proxima DATE NOT NULL,
  dias_para_vencimiento INTEGER NOT NULL,
  estado VARCHAR(20) NOT NULL, -- pendiente, proximo_vencer, vencida, vigente
  leida BOOLEAN DEFAULT false,
  fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE(id_colaborador, id_programacion)
);
```

**Función: actualizar_notificaciones_capacitacion()**
- **Trigger**: Llamado automáticamente después de crear/actualizar/eliminar programaciones
- **Propósito**: Sincronizar notificaciones con programaciones activas
- **Lógica**:
  1. Eliminar notificaciones de programaciones inactivas
  2. Para cada colaborador activo:
     - Buscar programaciones que apliquen (cargo + sub_area)
     - Buscar última capacitación completada
     - Calcular próxima fecha requerida
     - Crear/actualizar notificación con estado correcto

---

## 🚀 Instalación y Configuración

### Prerrequisitos
- PostgreSQL 12+
- PHP 7.4+
- Apache/Nginx
- Extensiones PHP: pdo_pgsql

### Paso 1: Crear Base de Datos

```bash
# Conectar a PostgreSQL
sudo -u postgres psql

# Crear base de datos
CREATE DATABASE osm2 WITH ENCODING 'UTF8';

# Establecer contraseña
ALTER USER postgres WITH PASSWORD '12345';
```

### Paso 2: Cargar Schema

```bash
cd /path/to/osm-WEB
sudo -u postgres psql -d osm2 -f db/osm_postgres.sql
```

### Paso 3: Verificar Instalación

```bash
# Verificar tablas
sudo -u postgres psql -d osm2 -c "\dt"

# Verificar función
sudo -u postgres psql -d osm2 -c "\df actualizar_notificaciones_capacitacion"

# Contar registros
sudo -u postgres psql -d osm2 -c "
SELECT 
  (SELECT COUNT(*) FROM cap_programacion) as programaciones,
  (SELECT COUNT(*) FROM cap_tema) as temas,
  (SELECT COUNT(*) FROM adm_cargos) as cargos,
  (SELECT COUNT(*) FROM adm_roles) as roles;
"
```

### Paso 4: Configurar Conexión

Verificar archivo `/php/db_postgres.php`:
```php
$host = 'localhost';
$db   = 'osm2';
$user = 'postgres';
$pass = '12345';
$port = '5432';
```

---

## 🧪 Pruebas de Funcionamiento

### Test 1: Conexión a Base de Datos
```bash
php /tmp/test_db_connection.php
```
**Resultado Esperado:** ✅ Todas las tablas accesibles

### Test 2: API de Programación
```bash
php /tmp/test_programacion_api.php
```
**Resultado Esperado:** 
- ✅ Listar programaciones
- ✅ Obtener cargos, temas, roles
- ✅ Verificar notificaciones

### Test 3: Función de Notificaciones
```sql
-- Ejecutar función
SELECT actualizar_notificaciones_capacitacion();

-- Verificar resultados
SELECT 
  p.id as programacion_id,
  t.nombre as tema,
  c.cargo as cargo_nombre,
  p.sub_area,
  COUNT(n.id) as notificaciones_creadas,
  COUNT(CASE WHEN n.estado = 'pendiente' THEN 1 END) as pendientes,
  COUNT(CASE WHEN n.estado = 'vencida' THEN 1 END) as vencidas
FROM cap_programacion p
LEFT JOIN cap_notificaciones n ON n.id_programacion = p.id
JOIN cap_tema t ON p.id_tema = t.id
JOIN adm_cargos c ON p.id_cargo = c.id_cargo
WHERE p.activo = true
GROUP BY p.id, t.nombre, c.cargo, p.sub_area;
```

### Test 4: Interfaz Web

1. **Acceder al módulo:**
   ```
   http://localhost/osm-WEB/m_capacitaciones/programacion.html
   ```

2. **Iniciar sesión** como administrador:
   - Cédula: `123456789`
   - Contraseña: `Osm1234`

3. **Verificar elementos:**
   - ✅ Tabla de programaciones carga correctamente
   - ✅ Filtros funcionan
   - ✅ Alertas de capacitador aparecen si hay capacitaciones próximas
   - ✅ Botón "Nueva Programación" abre modal
   - ✅ Botón "Importar Excel" abre modal de importación

4. **Crear nueva programación:**
   - Seleccionar cargo
   - Seleccionar sub-área
   - Seleccionar tema
   - Establecer frecuencia (meses)
   - Seleccionar rol capacitador
   - Guardar

5. **Verificar resultado:**
   - ✅ Programación aparece en tabla
   - ✅ Notificaciones se crean automáticamente
   - ✅ Contador de colaboradores pendientes se actualiza

---

## 📊 Casos de Uso

### Caso 1: Crear Programación Periódica de SST

**Escenario:** Todos los operarios de planta deben recibir capacitación en SST cada 12 meses.

**Pasos:**
1. Crear programación:
   - Cargo: "OPERARIO DE PLANTA"
   - Sub-área: Todas (dejar vacío o crear múltiples)
   - Tema: "Inducción y reinducción de seguridad y salud en el trabajo"
   - Frecuencia: 12 meses
   - Rol: "Capacitador SST"

2. El sistema automáticamente:
   - Identifica todos los colaboradores con cargo "OPERARIO DE PLANTA"
   - Crea notificaciones pendientes
   - Calcula fechas según última capacitación (si existe)

### Caso 2: Capacitación Urgente por Nueva Normativa

**Escenario:** Nueva normativa requiere capacitación inmediata sobre manejo de químicos.

**Pasos:**
1. Crear programación con frecuencia corta (1 mes)
2. Sistema marca todos como "pendiente" o "vencida"
3. Capacitadores reciben alertas
4. Después de completar capacitaciones, actualizar fecha y extender frecuencia

### Caso 3: Importación Masiva de Programaciones

**Escenario:** 50 programaciones nuevas según plan anual.

**Formato Excel:**
```
| ID Cargo | Sub Área | ID Tema | Frecuencia | Rol Capacitador    |
|----------|----------|---------|------------|-------------------|
| 116      | 003      | 75      | 12         | Capacitador TI    |
| 117      | 005      | 42      | 6          | Capacitador GH    |
```

**Pasos:**
1. Preparar archivo Excel con formato correcto
2. Clic en "Importar Excel"
3. Seleccionar archivo
4. Revisar vista previa
5. Confirmar importación
6. Sistema valida y crea programaciones en masa

### Caso 4: Monitoreo de Capacitaciones Próximas a Vencer

**Escenario:** Capacitador necesita planificar capacitaciones de la próxima semana.

**Visualización Automática:**
- Alertas en la parte superior muestran capacitaciones que vencen en ≤7 días
- Colores indican urgencia:
  - 🔴 Rojo: Vencidas
  - 🟡 Amarillo: 1-3 días
  - 🔵 Azul: 4-7 días
- Muestra cantidad de colaboradores pendientes por cada tema

---

## 📈 Estadísticas del Sistema

### Estado Actual (después de configuración inicial):
- ✅ **4 programaciones activas**
- ✅ **4 notificaciones generadas**
- ✅ **117 cargos disponibles**
- ✅ **81 temas de capacitación**
- ✅ **14 roles de capacitadores**
- ✅ **1,252 colaboradores en sistema**
- ✅ **17 sub-áreas configuradas**

### Frecuencias Típicas:
- SST: 12 meses (obligatorio anual)
- Técnicas: 6-12 meses
- Administrativas: 12-24 meses
- Emergencias: 6 meses

---

## 🔧 Mantenimiento

### Actualización Periódica de Notificaciones
```sql
-- Ejecutar manualmente si es necesario
SELECT actualizar_notificaciones_capacitacion();
```

### Limpieza de Notificaciones Antiguas
```sql
-- Marcar como leídas notificaciones vigentes
UPDATE cap_notificaciones 
SET leida = true 
WHERE estado = 'vigente' 
AND leida = false;
```

### Auditoría de Programaciones
```sql
-- Programaciones sin colaboradores asignados
SELECT 
  p.id,
  t.nombre as tema,
  c.cargo,
  p.sub_area,
  COUNT(n.id) as notificaciones
FROM cap_programacion p
LEFT JOIN cap_notificaciones n ON n.id_programacion = p.id
JOIN cap_tema t ON p.id_tema = t.id
JOIN adm_cargos c ON p.id_cargo = c.id_cargo
WHERE p.activo = true
GROUP BY p.id, t.nombre, c.cargo, p.sub_area
HAVING COUNT(n.id) = 0;
```

---

## ✅ Checklist de Verificación

### Instalación:
- [ ] PostgreSQL instalado y ejecutándose
- [ ] Base de datos `osm2` creada
- [ ] Schema cargado correctamente
- [ ] Función `actualizar_notificaciones_capacitacion()` existe
- [ ] Tablas principales creadas (cap_programacion, cap_notificaciones, etc.)
- [ ] Datos de referencia cargados (temas, roles, cargos)

### Funcionalidad:
- [ ] API responde correctamente a todas las acciones
- [ ] Interfaz web carga sin errores
- [ ] Filtros funcionan correctamente
- [ ] Modal de creación/edición funciona
- [ ] Modal de importación Excel funciona
- [ ] Notificaciones se crean automáticamente
- [ ] Alertas de capacitador se muestran correctamente
- [ ] Estados de notificaciones se calculan correctamente

### Pruebas de Integración:
- [ ] Crear programación genera notificaciones
- [ ] Editar programación actualiza notificaciones
- [ ] Eliminar programación borra notificaciones
- [ ] Importación masiva funciona correctamente
- [ ] Colaboradores pendientes se cuentan correctamente
- [ ] Fechas se calculan según frecuencia configurada

---

## 📞 Soporte

Para problemas o preguntas:
1. Revisar logs de PostgreSQL: `/var/log/postgresql/`
2. Revisar logs de Apache/PHP: `/var/log/apache2/error.log`
3. Verificar consola del navegador para errores JavaScript
4. Ejecutar tests de PHP para validar conexión y API

---

**Documento generado:** 26 de Octubre, 2025
**Versión:** 1.0
**Estado:** ✅ Sistema Operacional y Verificado
