# User Tracking Feature - Visual Flow Diagram

## Data Flow for Creating a Training Form

```
┌─────────────────────────────────────────────────────────────────┐
│ 1. User Interface (formulario.html)                             │
│    - User fills out training form                               │
│    - User adds attendees                                        │
│    - User clicks "Guardar y Registrar"                          │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│ 2. JavaScript (formulario.js)                                   │
│    - Validates form data                                        │
│    - Prepares JSON payload                                      │
│    - Sends POST request to formulario_api.php                   │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│ 3. Backend (formulario_api.php)                                 │
│    ┌──────────────────────────────────────────────────────┐    │
│    │ session_start()                                       │    │
│    │ $creado_por = $_SESSION['usuario_id']  ◄─────────────┼────┼── Session Data
│    └──────────────────────────────────────────────────────┘    │
│                                                                  │
│    INSERT INTO cap_formulario (                                 │
│      id_proceso, id_lugar, id_usuario,                          │
│      id_tipo_actividad, id_tema,                                │
│      hora_inicio, hora_final, fecha,                            │
│      observaciones,                                             │
│      creado_por,          ◄──────────────────────────────────── [NEW]
│      fecha_creacion       ◄──────────────────────────────────── [NEW] NOW()
│    ) VALUES (...)                                               │
│                                                                  │
│    Returns: {success: true, id_formulario: X}                   │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│ 4. Database (cap_formulario)                                    │
│    ┌──────┬──────────┬─────────┬──────────────┬──────────────┐ │
│    │ id   │ id_tema  │ fecha   │ creado_por   │fecha_creacion│ │
│    ├──────┼──────────┼─────────┼──────────────┼──────────────┤ │
│    │ 1    │ 26       │2024-... │ 35 (admin)   │2024-10-22... │ │
│    │      │          │         │   [NEW]      │   [NEW]      │ │
│    └──────┴──────────┴─────────┴──────────────┴──────────────┘ │
└─────────────────────────────────────────────────────────────────┘
```

## Data Flow for Editing a Training Form

```
┌─────────────────────────────────────────────────────────────────┐
│ 1. User Interface (ed_formulario.html)                          │
│    - User clicks edit button                                    │
│    - Modal opens                                                │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│ 2. JavaScript (ed_formulario.js)                                │
│    - cargarModal(id) called                                     │
│    - Sends GET request to ed_formulario_api.php?action=leer...  │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│ 3. Backend (ed_formulario_api.php - leer_formulario)            │
│    SELECT f.*, creador.*, editor.*                              │
│    FROM cap_formulario f                                        │
│    LEFT JOIN adm_usuarios creador ON f.creado_por = creador.id │◄─ [NEW]
│    LEFT JOIN adm_usuarios editor ON f.editado_por = editor.id  │◄─ [NEW]
│                                                                  │
│    Returns: {                                                   │
│      formulario: {...},                                         │
│      creador: {nombre1, apellido1},      ◄──────────────────── [NEW]
│      editor: {nombre1, apellido1}        ◄──────────────────── [NEW]
│    }                                                             │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│ 4. JavaScript displays tracking info                            │
│    ┌──────────────────────────────────────────────────────┐    │
│    │ ℹ️ Registro creado por: administrador                │    │
│    │   Última edición por: Lina                           │    │
│    └──────────────────────────────────────────────────────┘    │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│ 5. User makes changes and clicks "Guardar"                      │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│ 6. Backend (ed_formulario_api.php - actualizar_formulario)      │
│    ┌──────────────────────────────────────────────────────┐    │
│    │ session_start()                                       │    │
│    │ $editado_por = $_SESSION['usuario_id'] ◄─────────────┼────┼── Session Data
│    └──────────────────────────────────────────────────────┘    │
│                                                                  │
│    UPDATE cap_formulario SET                                    │
│      id_proceso = ?, id_lugar = ?, ...,                         │
│      editado_por = ?,        ◄──────────────────────────────── [NEW]
│      fecha_edicion = NOW()   ◄──────────────────────────────── [NEW]
│    WHERE id = ?                                                 │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│ 7. Database (cap_formulario)                                    │
│    ┌──────┬──────────┬──────────────┬──────────────┬─────────┐ │
│    │ id   │ id_tema  │ creado_por   │ editado_por  │fecha_ed.│ │
│    ├──────┼──────────┼──────────────┼──────────────┼─────────┤ │
│    │ 1    │ 26       │ 35 (admin)   │ 42 (Lina)    │2024-... │ │
│    │      │          │              │   [NEW]      │ [NEW]   │ │
│    └──────┴──────────┴──────────────┴──────────────┴─────────┘ │
└─────────────────────────────────────────────────────────────────┘
```

## Data Flow for Viewing in Consultation Table

```
┌─────────────────────────────────────────────────────────────────┐
│ 1. User opens Consultas_capacitacion.html                       │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│ 2. JavaScript (consulta-cap.js)                                 │
│    - Loads data from consultas_capacitacion_api.php             │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│ 3. Backend (consultas_capacitacion_api.php)                     │
│    SELECT                                                        │
│      f.id, f.fecha,                                             │
│      TRIM(creador.nombre1 || ' ' || creador.apellido1)          │
│        AS creado_por_nombre,         ◄─────────────────────── [NEW]
│      TRIM(editor.nombre1 || ' ' || editor.apellido1)            │
│        AS editado_por_nombre         ◄─────────────────────── [NEW]
│    FROM cap_formulario f                                        │
│    LEFT JOIN adm_usuarios creador ON f.creado_por = creador.id │
│    LEFT JOIN adm_usuarios editor ON f.editado_por = editor.id  │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│ 4. JavaScript renders table with new column                     │
│    ┌────┬───────┬─────┬────────────────────────────────────┐   │
│    │ ID │ Tema  │ ... │ Registrado por                     │   │
│    ├────┼───────┼─────┼────────────────────────────────────┤   │
│    │ 1  │ BPM   │ ... │ Creado por: administrador          │   │
│    │    │       │     │ Editado por: Lina                  │   │
│    └────┴───────┴─────┴────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────┘
```

## Excel Export Data Flow

```
┌─────────────────────────────────────────────────────────────────┐
│ User clicks export button                                       │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│ JavaScript (consulta-cap.js)                                    │
│    descargarXLSX(tipo) function                                 │
│    ┌──────────────────────────────────────────────────────┐    │
│    │ Headers: ['id', 'Capacitador', ...,                  │    │
│    │          'creado por', 'editado por']  ◄──────────── [NEW]│
│    │                                                       │    │
│    │ Data rows:                                            │    │
│    │   [row.id, row.capacitador, ...,                     │    │
│    │    row.creado_por_nombre,          ◄──────────────── [NEW]│
│    │    row.editado_por_nombre]         ◄──────────────── [NEW]│
│    └──────────────────────────────────────────────────────┘    │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│ XLSX.js library generates Excel file                            │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│ capacitaciones_[tipo].xlsx downloaded                           │
│ Contains two new columns with creator and editor info           │
└─────────────────────────────────────────────────────────────────┘
```

## Database Schema Change

```
Before:
┌────────────────────────────────────────────┐
│ cap_formulario                             │
├────────────────────────────────────────────┤
│ id                  INT4 PRIMARY KEY       │
│ id_proceso          INT4                   │
│ id_lugar            INT4                   │
│ id_usuario          INT4 (responsable)     │
│ id_tipo_actividad   INT4                   │
│ id_tema             INT4                   │
│ hora_inicio         TIME                   │
│ hora_final          TIME                   │
│ fecha               DATE                   │
│ observaciones       TEXT                   │
└────────────────────────────────────────────┘

After:
┌────────────────────────────────────────────┐
│ cap_formulario                             │
├────────────────────────────────────────────┤
│ id                  INT4 PRIMARY KEY       │
│ id_proceso          INT4                   │
│ id_lugar            INT4                   │
│ id_usuario          INT4 (responsable)     │
│ id_tipo_actividad   INT4                   │
│ id_tema             INT4                   │
│ hora_inicio         TIME                   │
│ hora_final          TIME                   │
│ fecha               DATE                   │
│ observaciones       TEXT                   │
│ creado_por          INT4 FK → adm_usuarios │ [NEW]
│ editado_por         INT4 FK → adm_usuarios │ [NEW]
│ fecha_creacion      TIMESTAMP              │ [NEW]
│ fecha_edicion       TIMESTAMP              │ [NEW]
└────────────────────────────────────────────┘
```

## Session Data Used

```
$_SESSION array:
┌──────────────────────────────────────┐
│ Key              │ Value             │
├──────────────────┼───────────────────┤
│ usuario_id       │ 35      ◄──────── Used for tracking
│ usuario          │ 'admin123'        │
│ nombre           │ 'Juan Pérez'      │
│ rol              │ 'Administrador'   │
│ tipo_usuario     │ 'admin'           │
└──────────────────────────────────────┘
```
