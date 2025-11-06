# System Flow Diagram - Training Programming Module

## Overall System Architecture

```
┌─────────────────────────────────────────────────────────────────────────┐
│                        TRAINING PROGRAMMING SYSTEM                       │
└─────────────────────────────────────────────────────────────────────────┘

┌──────────────────────┐         ┌──────────────────────┐
│   programacion.html  │         │   formulario.html    │
│                      │         │                      │
│  • View trainings    │         │  • Create training   │
│  • Create schedule   │         │  • Add attendees     │
│  • See dates         │         │  • Mark approved     │
│  • Get alerts        │         │                      │
└──────────┬───────────┘         └───────────┬──────────┘
           │                                 │
           │ API Calls                       │ API Calls
           ▼                                 ▼
┌──────────────────────┐         ┌──────────────────────┐
│  programacion_api    │         │   formulario_api     │
│                      │         │                      │
│  • CRUD operations   │         │  • Save training     │
│  • Initialize dates  │         │  • Save attendees    │
│  • Get alerts        │         │                      │
└──────────┬───────────┘         └───────────┬──────────┘
           │                                 │
           │ SQL Queries                     │ INSERT
           ▼                                 ▼
┌────────────────────────────────────────────────────────┐
│              PostgreSQL Database                        │
│                                                         │
│  ┌─────────────────┐      ┌─────────────────────────┐ │
│  │cap_programacion │      │cap_formulario_asistente │ │
│  │                 │      │                         │ │
│  │• tema           │      │• tema (indirect)        │ │
│  │• cargo          │◄─────┤• cargo                  │ │
│  │• sub_area       │Match │• sub_area               │ │
│  │• frequency      │      │• estado_aprovacion      │ │
│  │• dates          │      └─────────────────────────┘ │
│  └─────────────────┘                ▲                 │
│           ▲                          │                 │
│           │                          │ TRIGGER         │
│           │                          │                 │
│           │      ┌───────────────────┴──────────────┐  │
│           │      │ actualizar_fechas_programacion() │  │
│           │      │                                  │  │
│           │      │ When: INSERT on asistente        │  │
│           │      │ Does: Update matching dates      │  │
│           └──────┤ Match: tema + cargo + sub_area   │  │
│                  └──────────────────────────────────┘  │
└────────────────────────────────────────────────────────┘
```

## Data Flow - Creating a Training Schedule

```
USER ACTION: Create Programacion
         │
         ▼
┌─────────────────────────────────────────────────────────┐
│ 1. User fills form in programacion.html                 │
│    - Cargo: ANALISTA DE INFORMACION                     │
│    - Sub-área: CLIPA - SISTEMAS                         │
│    - Tema: PowerBI                                      │
│    - Frecuencia: 12 meses                               │
│    - Rol: Capacitador TI                                │
└─────────────────────┬───────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────────┐
│ 2. programacion_api.php processes                       │
│    - Validates input                                    │
│    - Calculates initial dates:                          │
│      • fecha_proxima: today + 12 months                 │
│      • fecha_notificacion: today + 11 months            │
└─────────────────────┬───────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────────┐
│ 3. Database stores record                               │
│    cap_programacion:                                    │
│    ├─ id_tema: 45                                       │
│    ├─ id_cargo: '116'                                   │
│    ├─ sub_area: 'CLIPA - SISTEMAS'                      │
│    ├─ frecuencia_meses: 12                              │
│    ├─ id_rol_capacitador: 21                            │
│    ├─ fecha_ultima_capacitacion: NULL                   │
│    ├─ fecha_proxima_capacitacion: 2025-12-15            │
│    └─ fecha_notificacion_previa: 2025-11-15             │
└─────────────────────────────────────────────────────────┘
```

## Data Flow - Completing a Training

```
USER ACTION: Complete Training in formulario.html
         │
         ▼
┌─────────────────────────────────────────────────────────┐
│ 1. User creates training                                 │
│    - Tema: PowerBI                                      │
│    - Fecha: 2024-12-15                                  │
│    - Adds attendees:                                    │
│      • Juan Perez (ANALISTA, CLIPA-SISTEMAS)           │
│      • Maria Lopez (ANALISTA, CLIPA-SISTEMAS)          │
│    - Marks both as "aprobo"                             │
└─────────────────────┬───────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────────┐
│ 2. formulario_api.php saves                             │
│    - Creates cap_formulario record                      │
│    - Creates cap_formulario_asistente records           │
└─────────────────────┬───────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────────┐
│ 3. Trigger fires: actualizar_fechas_programacion()      │
│    FOR EACH asistente record:                           │
│    a) Get tema from formulario                          │
│    b) Get cargo_id from asistente's cargo name          │
│    c) Get sub_area from asistente                       │
│    d) Find matching programacion:                       │
│       WHERE tema = 45                                   │
│         AND cargo = '116'                               │
│         AND sub_area = 'CLIPA - SISTEMAS'               │
│         AND estado_aprovacion = 'aprobo'                │
│    e) Update dates:                                     │
│       • fecha_ultima: 2024-12-15                        │
│       • fecha_proxima: 2025-12-15                       │
│       • fecha_notificacion: 2025-11-15                  │
└─────────────────────┬───────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────────┐
│ 4. Database updated                                     │
│    cap_programacion (ID=123):                           │
│    ├─ fecha_ultima_capacitacion: 2024-12-15 ← UPDATED  │
│    ├─ fecha_proxima_capacitacion: 2025-12-15 ← UPDATED │
│    └─ fecha_notificacion_previa: 2025-11-15 ← UPDATED  │
└─────────────────────────────────────────────────────────┘
```

## Notification Flow

```
TIMELINE: Notification Lifecycle

Day 0 (2024-12-15)
├─ Training completed
└─ Dates updated:
   • Next: 2025-12-15
   • Alert: 2025-11-15

      ↓ Time passes...

Day 335 (2025-11-15) ← NOTIFICATION DATE
├─ User with "Capacitador TI" role logs in
└─ Alert appears:
   ┌────────────────────────────────────────┐
   │ ⚠️ Capacitaciones que Vencen Pronto    │
   │                                        │
   │ • PowerBI - ANALISTA DE INFORMACION    │
   │   (CLIPA - SISTEMAS)                   │
   │   Vence en 30 días (2025-12-15)        │
   │   2 colaborador(es) pendiente(s)       │
   │   Rol: Capacitador TI                  │
   └────────────────────────────────────────┘

      ↓ Time passes...

Day 358 (2024-12-08) ← 7 DAYS BEFORE
├─ Alert changes to WARNING (yellow):
   "Vence en 7 días"

      ↓ Time passes...

Day 365 (2025-12-15) ← DUE DATE
├─ Alert changes to DANGER (red):
   "Vence HOY"

      ↓ Time passes...

Day 395 (2026-01-14) ← 30 DAYS OVERDUE
├─ Alert still visible (red):
   "Vencida hace 30 días"
└─ Grace period ends, alert hidden after this

      ↓ OR ↓

New Training Completed
├─ Cycle repeats
└─ Dates recalculated automatically
```

## Matching Logic Flowchart

```
┌─────────────────────────────────────────────┐
│ New attendee inserted in formulario         │
│ estado_aprovacion = 'aprobo'                │
└─────────────────┬───────────────────────────┘
                  │
                  ▼
         ┌────────────────────┐
         │ Get formulario     │
         │ details:           │
         │ • id_tema          │
         │ • fecha            │
         └────────┬───────────┘
                  │
                  ▼
         ┌────────────────────┐
         │ Get attendee       │
         │ details:           │
         │ • cargo name       │
         │ • sub_area         │
         └────────┬───────────┘
                  │
                  ▼
         ┌────────────────────┐
         │ Lookup cargo_id    │
         │ from cargo name    │
         └────────┬───────────┘
                  │
                  ▼
         ┌────────────────────┐
         │ Search for         │
         │ programacion:      │
         │                    │
         │ ┌──Match Tema?────┐│
         │ │      Yes        ││
         │ └────────┬─────────┘│
         │          ▼          │
         │ ┌──Match Cargo?───┐│
         │ │      Yes        ││
         │ └────────┬─────────┘│
         │          ▼          │
         │ ┌─Match Sub Area?─┐│
         │ │      Yes        ││
         │ └────────┬─────────┘│
         │          ▼          │
         │ ┌───Is Active?────┐│
         │ │      Yes        ││
         │ └────────┬─────────┘│
         └──────────┼──────────┘
                    │
                    ▼
            ┌───────────────┐
            │ MATCH FOUND!  │
            └───────┬───────┘
                    │
                    ▼
         ┌──────────────────────┐
         │ Update dates:         │
         │                       │
         │ ultima = GREATEST(    │
         │   current_ultima,     │
         │   training_fecha      │
         │ )                     │
         │                       │
         │ proxima = ultima +    │
         │   (frequency months)  │
         │                       │
         │ notificacion =        │
         │   proxima - 1 month   │
         └───────────────────────┘
```

## Role-Based Access Flowchart

```
┌──────────────────────────────────────────────────┐
│ User logs in to programacion.html                │
└─────────────────┬────────────────────────────────┘
                  │
                  ▼
         ┌────────────────────┐
         │ Get user's roles   │
         │ from session       │
         └────────┬───────────┘
                  │
                  ▼
         ┌────────────────────┐
         │ Query programacion │
         │ WHERE              │
         │ id_rol_capacitador │
         │ IN (user_roles)    │
         └────────┬───────────┘
                  │
                  ▼
         ┌────────────────────┐
         │ Filter by          │
         │ notification date: │
         │ • Alert date passed│
         │ • Not too old      │
         │   (< 30 days)      │
         └────────┬───────────┘
                  │
                  ▼
         ┌────────────────────┐
         │ Display alerts:    │
         │                    │
         │ User: Juan (TI)    │
         │ Sees: PowerBI      │
         │       Excel        │
         │                    │
         │ User: Maria (GH)   │
         │ Sees: Inducción    │
         │       Nómina       │
         └────────────────────┘
```

## Database Trigger Pseudo-code

```sql
TRIGGER: actualizar_fechas_programacion()
FIRES: AFTER INSERT ON cap_formulario_asistente
FOR EACH ROW:

BEGIN
    -- Step 1: Get training info
    tema_id = SELECT id_tema 
              FROM cap_formulario 
              WHERE id = NEW.id_formulario;
              
    fecha = SELECT fecha 
            FROM cap_formulario 
            WHERE id = NEW.id_formulario;
    
    -- Step 2: Get cargo ID from name
    cargo_id = SELECT id_cargo 
               FROM adm_cargos 
               WHERE cargo = NEW.cargo 
               LIMIT 1;
    
    -- Step 3: Get sub_area
    sub_area = NEW.sub_área;
    
    -- Step 4: Only process if approved
    IF NEW.estado_aprovacion != 'aprobo' THEN
        RETURN NEW;
    END IF;
    
    -- Step 5: Update matching programacion
    UPDATE cap_programacion
    SET 
        fecha_ultima_capacitacion = GREATEST(
            COALESCE(fecha_ultima_capacitacion, fecha),
            fecha
        ),
        fecha_proxima_capacitacion = 
            fecha + (frecuencia_meses * INTERVAL '1 month'),
        fecha_notificacion_previa = 
            fecha + (frecuencia_meses * INTERVAL '1 month') 
                  - INTERVAL '1 month'
    WHERE 
        id_tema = tema_id
        AND id_cargo = cargo_id
        AND (sub_area = sub_area OR both NULL)
        AND activo = true;
    
    RETURN NEW;
END;
```

## Example: Complete Lifecycle

```
┌──────────────────────────────────────────────────────────────────────┐
│ Month 0: January 2024                                                │
├──────────────────────────────────────────────────────────────────────┤
│ Action: Create programacion                                          │
│ Result:                                                              │
│   • fecha_ultima: NULL                                               │
│   • fecha_proxima: January 2025 (12 months)                         │
│   • fecha_notificacion: December 2024 (11 months)                   │
└──────────────────────────────────────────────────────────────────────┘

                          ↓ Time: 4 months

┌──────────────────────────────────────────────────────────────────────┐
│ Month 4: May 2024                                                    │
├──────────────────────────────────────────────────────────────────────┤
│ Action: Complete first training (May 15, 2024)                      │
│ Result:                                                              │
│   • fecha_ultima: May 15, 2024 ← UPDATED                            │
│   • fecha_proxima: May 15, 2025 ← UPDATED                           │
│   • fecha_notificacion: April 15, 2025 ← UPDATED                    │
└──────────────────────────────────────────────────────────────────────┘

                          ↓ Time: 11 months

┌──────────────────────────────────────────────────────────────────────┐
│ Month 15: April 2025                                                 │
├──────────────────────────────────────────────────────────────────────┤
│ Date: April 15, 2025                                                │
│ Event: NOTIFICATION DATE REACHED                                     │
│ Result:                                                              │
│   • Alert appears for Capacitador TI                                │
│   • Shows: "Vence en 30 días"                                       │
│   • Lists pending collaborators                                     │
└──────────────────────────────────────────────────────────────────────┘

                          ↓ Time: 1 month

┌──────────────────────────────────────────────────────────────────────┐
│ Month 16: May 2025                                                   │
├──────────────────────────────────────────────────────────────────────┤
│ Action: Complete second training (May 10, 2025)                     │
│ Result:                                                              │
│   • fecha_ultima: May 10, 2025 ← UPDATED                            │
│   • fecha_proxima: May 10, 2026 ← UPDATED                           │
│   • fecha_notificacion: April 10, 2026 ← UPDATED                    │
│   • Alert disappears                                                │
└──────────────────────────────────────────────────────────────────────┘

                     ↓ Cycle continues forever...
```

## Key Concepts Visual

```
┌─────────────────────────────────────────────────────────────────────┐
│                         DATE CALCULATIONS                            │
└─────────────────────────────────────────────────────────────────────┘

Last Training Date: 2024-05-15
                    │
                    │ + frequency (12 months)
                    ▼
Next Training Date: 2025-05-15
                    │
                    │ - 1 month
                    ▼
Notification Date:  2025-04-15 ← Alert starts showing

┌─────────────────────────────────────────────────────────────────────┐
│                         MATCHING LOGIC                               │
└─────────────────────────────────────────────────────────────────────┘

Programacion Record:
├─ Tema: PowerBI (ID: 45)
├─ Cargo: ANALISTA DE INFORMACION (ID: '116')
└─ Sub-área: CLIPA - SISTEMAS

        ⊕ MUST MATCH ⊕

Formulario Asistente:
├─ From formulario with tema ID: 45 ✓
├─ With cargo name lookup to ID: '116' ✓
└─ With sub_área: CLIPA - SISTEMAS ✓

        ⇒ DATES UPDATED ⇐

┌─────────────────────────────────────────────────────────────────────┐
│                    ROLE-BASED VISIBILITY                             │
└─────────────────────────────────────────────────────────────────────┘

Programacion for PowerBI:
├─ Assigned to: Capacitador TI (Role ID: 21)

User Juan:
├─ Has role: Capacitador TI (ID: 21)
└─ Can see: ✓ PowerBI alert

User Maria:
├─ Has role: Capacitador GH (ID: 20)
└─ Can see: ✗ No PowerBI alert
```

This completes the visual documentation of the training programming system!
