# Data Flow Diagram

## Sub Área Selection Flow

```
User Opens programacion.html
         ↓
JavaScript loads page (programacion.js)
         ↓
Calls: GET /programacion_api.php?action=get_sub_areas
         ↓
PHP Query: SELECT DISTINCT sub_area FROM adm_área
         ↓
Returns: ["MANTENIMIENTO INDUSTRIAL", "ALMACEN", "COMPRAS", ...]
         ↓
JavaScript populates dropdown
         ↓
User selects sub_area from dropdown
         ↓
User fills other fields (cargo, tema, frecuencia, rol)
         ↓
Clicks "Guardar"
         ↓
POST /programacion_api.php?action=create
         ↓
Inserts into cap_programacion table
         ↓
Success! Programming entry created
```

## Training Form to Next Date Calculation Flow

```
User Creates Training Form (formulario.html)
         ↓
Selects: Proceso, Lugar, Responsable, Tipo, Tema, Fecha, Hora
         ↓
Adds Attendees (with cédulas)
         ↓
Clicks "Guardar"
         ↓
POST /formulario_api.php?action=save_formulario
         ↓
┌─────────────────────────────────────────┐
│ Transaction Begins                       │
│                                          │
│ 1. Insert into cap_formulario            │
│    - Returns: id_formulario = 2          │
│                                          │
│ 2. For each attendee:                    │
│    Insert into cap_formulario_asistente  │
│    - Links attendee to formulario        │
│                                          │
│ 3. Call actualizar_notificaciones_       │
│    capacitacion()                        │
│    ↓                                     │
│    For each collaborator:                │
│    - Find their cargo and sub_area       │
│    - Find matching cap_programacion      │
│    - Get last training date from         │
│      cap_formulario (fecha)              │
│    - Calculate:                          │
│      next_date = last_date +             │
│                  (frequency * months)    │
│    - Update cap_notificaciones:          │
│      * fecha_ultima_capacitacion = today │
│      * fecha_proxima = calculated date   │
│      * estado = (vigente/proximo/vencida)│
│                                          │
│ Transaction Commits                      │
└─────────────────────────────────────────┘
         ↓
Returns: Success! Form saved, id = 2
         ↓
Notifications automatically updated
```

## Programadas Tab Display Flow

```
User Opens Usuarios.html
         ↓
Page loads, JavaScript executes (user_trainings.js)
         ↓
Calls: GET /progreso_api.php?action=get_scheduled_trainings
         ↓
PHP Checks: $_SESSION['cedula']
         ↓
Query:
  SELECT 
    tema.nombre,
    notif.fecha_ultima_capacitacion,
    notif.fecha_proxima,
    prog.frecuencia_meses,
    notif.estado,
    cargo.cargo,
    prog.sub_area,
    rol.nombre as responsable
  FROM cap_notificaciones notif
  JOIN cap_programacion prog ON notif.id_programacion = prog.id
  JOIN cap_tema tema ON prog.id_tema = tema.id
  JOIN adm_cargos cargo ON prog.id_cargo = cargo.id_cargo
  JOIN adm_roles rol ON prog.id_rol_capacitador = rol.id
  JOIN adm_colaboradores colab ON notif.id_colaborador = colab.ac_id
  WHERE colab.ac_cedula = ?
  ORDER BY notif.fecha_proxima ASC
         ↓
Returns JSON:
[
  {
    "tema": "Seguridad Industrial",
    "fecha_ultima_capacitacion": "2025-01-15",
    "fecha_proxima": "2026-01-15",
    "frecuencia_meses": 12,
    "estado": "vigente",
    "sub_area": "MANTENIMIENTO INDUSTRIAL",
    "responsable": "Capacitador MT",
    "badge_class": "success"
  },
  ...
]
         ↓
JavaScript renders table in "Programadas" tab:

┌─────────────────────────────────────────────────────────────────┐
│ Tema                 │ Última  │ Próxima │ Frecuencia │ Estado  │
├─────────────────────────────────────────────────────────────────┤
│ Seguridad Industrial │ 15/01/  │ 15/01/  │ Cada 12    │ Vigente │
│ MANT. INDUSTRIAL     │  2025   │  2026   │ meses      │  🟢     │
├─────────────────────────────────────────────────────────────────┤
│ Primeros Auxilios    │ 10/05/  │ 10/11/  │ Cada 6     │ Próxima │
│ ADMINISTRACION       │  2025   │  2025   │ meses      │  🟡     │
└─────────────────────────────────────────────────────────────────┘
```

## Complete System Integration

```
┌─────────────────────────────────────────────────────────────────┐
│                        DATABASE (PostgreSQL)                     │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  adm_área                    cap_programacion                   │
│  ├─ id_area                  ├─ id                             │
│  ├─ area                     ├─ id_cargo ──────┐               │
│  └─ sub_area ───┐            ├─ sub_area       │               │
│         │        │            ├─ id_tema        │               │
│         │        └───────────→├─ frecuencia_meses               │
│         │                     └─ id_rol_capacitador             │
│         │                            │                          │
│         │                            ↓                          │
│         │              cap_notificaciones                       │
│         │              ├─ id_colaborador                        │
│         │              ├─ id_programacion ←──┘                  │
│         │              ├─ fecha_ultima_capacitacion             │
│         │              ├─ fecha_proxima (CALCULATED!)           │
│         │              └─ estado                                │
│         │                     ↑                                 │
│         │                     │                                 │
│         │              cap_formulario                           │
│         │              ├─ id                                    │
│         │              ├─ fecha ───┐                            │
│         │              └─ id_tema  │                            │
│         │                     │    │                            │
│         │                     │    └─ Used to calculate         │
│         │                     │       next training date        │
│         │                     │                                 │
│         │              cap_formulario_asistente                 │
│         │              ├─ id_formulario ←──┘                    │
│         └─────────────→├─ cedula                                │
│                        └─ sub_area                              │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘

TRIGGER POINT: When formulario_api.php saves a form
               ↓
FUNCTION CALL: actualizar_notificaciones_capacitacion()
               ↓
CALCULATION:   For each (collaborator, programming) pair:
               next_date = MAX(form.fecha) + prog.frecuencia_meses
               ↓
UPDATE:        cap_notificaciones.fecha_proxima = next_date
```

## Key Points

1. **Sub Área Dropdown**: Always populated from ALL unique values in adm_área table
2. **Automatic Updates**: Forms trigger automatic next date calculations
3. **Programming Link**: Each collaborator+programming creates a notification entry
4. **Date Calculation**: next_date = last_training + frequency_months
5. **Status Updates**: System automatically updates status based on dates
6. **User View**: "Programadas" tab shows all scheduled trainings with next dates
