# Architecture Diagram: items_formularios Solution

## System Overview

```
┌─────────────────────────────────────────────────────────────────┐
│                  items_formularios.html                          │
│  ┌────────┐  ┌─────────┐  ┌────────┐  ┌───────────────┐       │
│  │  Tema  │  │ Proceso │  │ Lugar  │  │ Tipo Actividad│       │
│  │  Tab   │  │   Tab   │  │  Tab   │  │      Tab      │       │
│  └────────┘  └─────────┘  └────────┘  └───────────────┘       │
└─────────────────────────────────────────────────────────────────┘
                            │
                            │ loads
                            ▼
┌─────────────────────────────────────────────────────────────────┐
│              items_formularios.js (JavaScript)                   │
│                                                                  │
│  Functions:                                                      │
│  • loadTemas()        • addTema()                               │
│  • loadProcesos()     • addProceso()                            │
│  • loadLugares()      • addLugar()                              │
│  • loadTActividad()   • addTActividad()                         │
│  • toggleState()      • openEditModal()                         │
│  • updateRowVisual()  • refreshList()                           │
└─────────────────────────────────────────────────────────────────┘
              │                           │
              │ GET requests              │ POST requests
              │ (list data)               │ (mutations)
              ▼                           ▼
┌──────────────────────────┐    ┌────────────────────────┐
│  cap_control_api.php     │    │ items_formulario.php   │
│  (Read Operations)       │    │ (Write Operations)     │
│                          │    │                        │
│  Actions:                │    │  Actions:              │
│  • list_temas            │    │  • add                 │
│  • list_procesos         │    │  • update              │
│  • list_lugares          │    │  • activar             │
│  • list_tactividad       │    │  • inactivar           │
└──────────────────────────┘    └────────────────────────┘
              │                           │
              │ SELECT queries            │ INSERT/UPDATE queries
              ▼                           ▼
┌─────────────────────────────────────────────────────────────────┐
│                    PostgreSQL Database (osm2)                    │
│                                                                  │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐         │
│  │  cap_tema    │  │ cap_proceso  │  │  cap_lugar   │         │
│  ├──────────────┤  ├──────────────┤  ├──────────────┤         │
│  │ id           │  │ id           │  │ id           │         │
│  │ nombre       │  │ proceso      │  │ lugar        │         │
│  │ estado       │  │ estado       │  │ estado       │         │
│  └──────────────┘  └──────────────┘  └──────────────┘         │
│                                                                  │
│  ┌──────────────────┐                                           │
│  │cap_tipo_actividad│                                           │
│  ├──────────────────┤                                           │
│  │ id               │                                           │
│  │ nombre           │                                           │
│  │ estado           │                                           │
│  └──────────────────┘                                           │
│                                                                  │
│  estado: 0 = Active, 1 = Inactive                               │
└─────────────────────────────────────────────────────────────────┘
```

## Data Flow Diagrams

### 1. Loading Data (GET)

```
User opens page or switches tab
        ↓
JavaScript calls loadTemas() / loadProcesos() / loadLugares() / loadTActividad()
        ↓
GET /cap_control_api.php?action=list_[type]
        ↓
cap_control_api.php validates action (whitelist)
        ↓
Executes SELECT query with ORDER BY id
        ↓
Returns JSON:
{
  "success": true,
  "temas": [
    {"id": "1", "nombre": "...", "activo": true},
    {"id": "2", "nombre": "...", "activo": false}
  ]
}
        ↓
JavaScript renders HTML table rows
        ↓
Applies visual styling (green toggle for active, red for inactive)
```

### 2. Adding New Item (POST)

```
User enters name in input field
        ↓
User clicks "Agregar" button
        ↓
JavaScript validates (not empty)
        ↓
POST /items_formulario.php
Body: {"action": "add", "table": "cap_tema", "nombre": "New Item"}
        ↓
items_formulario.php detects correct column name
        ↓
INSERT INTO cap_tema (nombre, estado) VALUES ('New Item', 0)
        ↓
Returns JSON:
{
  "success": true,
  "id": 123,
  "nombre": "New Item",
  "estado": 0
}
        ↓
JavaScript shows success toast
        ↓
Calls loadTemas() to refresh table
        ↓
New item appears in table with green toggle
```

### 3. Editing Item (POST)

```
User clicks edit button (pencil icon)
        ↓
JavaScript opens modal with current name
        ↓
User modifies name and clicks "Guardar"
        ↓
POST /items_formulario.php
Body: {"action": "update", "table": "cap_tema", "id": 1, "nombre": "Updated"}
        ↓
items_formulario.php detects correct column
        ↓
UPDATE cap_tema SET nombre = 'Updated' WHERE id = 1
        ↓
Returns JSON:
{
  "success": true,
  "updated": {"table": "cap_tema", "id": 1, "nombre": "Updated"}
}
        ↓
JavaScript shows success toast and closes modal
        ↓
Calls loadTemas() to refresh table
        ↓
Updated name appears in table
```

### 4. Toggle State (POST)

```
User clicks toggle switch
        ↓
JavaScript shows confirmation dialog
        ↓
User confirms
        ↓
POST /items_formulario.php
Body: {"action": "inactivar", "table": "cap_tema", "id": 1}
        ↓
UPDATE cap_tema SET estado = 1 WHERE id = 1
        ↓
Returns JSON:
{
  "success": true,
  "id": 1,
  "new_value": 1
}
        ↓
JavaScript shows success toast
        ↓
Updates row visual (red toggle, semi-transparent)
        ↓
NO full table reload (optimized)
```

## Component Interaction Matrix

```
┌────────────────┬─────────┬──────────┬─────────┬────────┐
│ Component      │ Reads   │ Writes   │ Depends │ Used   │
│                │ From    │ To       │ On      │ By     │
├────────────────┼─────────┼──────────┼─────────┼────────┤
│ HTML           │ -       │ -        │ CSS,JS  │ User   │
├────────────────┼─────────┼──────────┼─────────┼────────┤
│ CSS            │ -       │ -        │ -       │ HTML   │
├────────────────┼─────────┼──────────┼─────────┼────────┤
│ JS             │ APIs    │ DOM      │ APIs    │ HTML   │
├────────────────┼─────────┼──────────┼─────────┼────────┤
│ cap_control_   │ DB      │ JSON     │ DB conn │ JS     │
│ api.php        │         │          │         │        │
├────────────────┼─────────┼──────────┼─────────┼────────┤
│ items_         │ DB      │ DB,JSON  │ DB conn │ JS     │
│ formulario.php │         │          │         │        │
├────────────────┼─────────┼──────────┼─────────┼────────┤
│ Database       │ Disk    │ Disk     │ -       │ PHP    │
└────────────────┴─────────┴──────────┴─────────┴────────┘
```

## File Dependencies

```
items_formularios.html
  ├── /assets/bootstrap/css/bootstrap.min.css
  ├── /assets/css/bs-theme-overrides.css
  ├── /m_capacitaciones/assets/css/items_formularios.css  [NEW]
  ├── /assets/bootstrap/js/bootstrap.min.js
  ├── /assets/js/sidebar.js
  ├── /m_capacitaciones/assets/js/items_formularios.js
  └── /assets/js/navbar.js

items_formularios.js
  ├── /m_capacitaciones/assets/php/cap_control_api.php  [NEW]
  └── /m_capacitaciones/assets/php/items_formulario.php

cap_control_api.php  [NEW]
  └── /php/db_postgres.php

items_formulario.php
  └── /php/db_postgres.php

db_postgres.php
  └── PostgreSQL Database (osm2)
```

## State Management

```
┌─────────────────────────────────────────────────────────────┐
│                    Application State                        │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  Client Side (JavaScript):                                 │
│  • currentTab (tema/proceso/lugar/tactividad)              │
│  • editModal (bootstrap.Modal instance)                    │
│  • itemsCache (not implemented, loads fresh each time)     │
│                                                             │
│  Server Side (Database):                                   │
│  • cap_tema records with estado                            │
│  • cap_proceso records with estado                         │
│  • cap_lugar records with estado                           │
│  • cap_tipo_actividad records with estado                  │
│                                                             │
│  estado values:                                            │
│    0 = Active (visible, usable)                            │
│    1 = Inactive (hidden, preserved)                        │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

## Security Boundaries

```
┌─────────────────────────────────────────────────────────────┐
│                      Browser (Client)                        │
│  • XSS Protection: escapeHtml() for all dynamic content     │
│  • Input Validation: Empty checks, trim, length limits     │
│  • Confirmation Dialogs: For destructive actions           │
└──────────────────────────┬──────────────────────────────────┘
                           │ HTTPS
                           ▼
┌─────────────────────────────────────────────────────────────┐
│                      Web Server (PHP)                        │
│  • Action Whitelist: Only allowed actions executed          │
│  • SQL Injection: Prepared statements (parameterized)       │
│  • Input Sanitization: trim(), type casting                 │
│  • Column Name Validation: Regex check [a-zA-Z0-9_]        │
│  • Error Handling: Generic errors to client, detailed logs │
└──────────────────────────┬──────────────────────────────────┘
                           │ Local socket
                           ▼
┌─────────────────────────────────────────────────────────────┐
│                  Database (PostgreSQL)                       │
│  • CHECK Constraints: estado IN (0,1)                       │
│  • NOT NULL Constraints: Required fields                    │
│  • Data Types: Enforced by schema                          │
│  • Foreign Keys: (if any, not shown in these tables)       │
└─────────────────────────────────────────────────────────────┘
```

## Error Handling Flow

```
Error Occurs
    ↓
├─ JavaScript Error ────────────────┐
│  • console.error()                 │
│  • showToast(message, true)        │
│  • User sees red toast             │
│                                    │
├─ Network Error ───────────────────┤
│  • Caught by catch block           │
│  • showToast('Error de conexión')  │
│  • Log to console                  │
│                                    │
├─ PHP Error ───────────────────────┤
│  • Caught by try/catch             │
│  • api_log() → error_log           │
│  • respond(['success'=>false])     │
│  • Generic error to client         │
│                                    │
└─ Database Error ──────────────────┘
   • PDO Exception caught
   • api_log() → error_log
   • respond(['error'=>'DB error'])
   • Does not expose SQL details
```

## Column Name Detection Logic

```
items_formulario.php receives table name
    ↓
Query information_schema.columns for that table
    ↓
Get list of column names
    ↓
Search in preference order:
    1. 'nombre'     ← Most common
    2. 'name'
    3. 'titulo'
    4. 'descripcion'
    5. 'lugar'      ← For cap_lugar
    6. 'proceso'    ← For cap_proceso
    7. 'tema'
    8. 'tipo'
    9. 'actividad'
    10. 'label'
    ↓
First match found → use that column
    ↓
No match? → Use first non-id column
    ↓
Still no match? → Error
```

## Toggle Visual States

```
Estado = 0 (Active):
┌─────────────────────────────────────┐
│ ID  Nombre               Opciones   │
├─────────────────────────────────────┤
│ 1   Test Item        [●────○] ✏️   │
│                       GREEN          │
└─────────────────────────────────────┘
Normal opacity (1.0)
Text color: default

Estado = 1 (Inactive):
┌─────────────────────────────────────┐
│ ID  Nombre               Opciones   │
├─────────────────────────────────────┤
│ 2   Inactive Item    [○────●] ✏️   │
│                       RED            │
└─────────────────────────────────────┘
Opacity: 0.5 (semi-transparent)
Text color: muted (#6c757d)
```

---

**Legend:**
- `[NEW]` = Files created by this fix
- `→` = Data flow direction
- `↓` = Sequential step
- `├─` = Branch/alternative path
- `┌─┐` = Container/boundary
