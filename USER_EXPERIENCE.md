# User Experience Guide

## What Users Will See

### 1. Programación Page (programacion.html)

#### Before:
```
┌────────────────────────────────────────┐
│ Nueva Programación                     │
├────────────────────────────────────────┤
│                                        │
│ Cargo:    [▼ Seleccione...        ]   │
│                                        │
│ Sub Área: [________________]           │ ← User had to type manually
│                                        │
│ Tema:     [▼ Seleccione...        ]   │
│                                        │
└────────────────────────────────────────┘
```

#### After:
```
┌────────────────────────────────────────┐
│ Nueva Programación                     │
├────────────────────────────────────────┤
│                                        │
│ Cargo:    [▼ Seleccione...        ]   │
│                                        │
│ Sub Área: [▼ Seleccione...        ]   │ ← Now a dropdown!
│           ├─ MANTENIMIENTO INDUSTRIAL  │
│           ├─ ALMACEN                   │
│           ├─ COMPRAS                   │
│           ├─ CLIPA - SISTEMAS          │
│           └─ ...                       │
│                                        │
│ Tema:     [▼ Seleccione...        ]   │
│                                        │
└────────────────────────────────────────┘
```

**Benefits:**
- ✅ No typos or inconsistencies
- ✅ Faster data entry
- ✅ Standardized sub-area names
- ✅ Better data quality

---

### 2. User Profile Page (Usuarios.html)

#### Before:
```
┌──────────────────────────────────────────────────────────┐
│ Capacitaciones Asignadas                                 │
├──────────────────────────────────────────────────────────┤
│                                                          │
│  [Pendientes] [Realizadas]                               │ ← Only 2 tabs
│                                                          │
│  Shows pending trainings...                              │
│                                                          │
└──────────────────────────────────────────────────────────┘
```

#### After:
```
┌──────────────────────────────────────────────────────────┐
│ Capacitaciones Asignadas                                 │
├──────────────────────────────────────────────────────────┤
│                                                          │
│  [Pendientes] [Programadas] [Realizadas]                 │ ← NEW TAB!
│                                                          │
│  ┌────────────────────────────────────────────────────┐  │
│  │ Programadas Tab Content:                           │  │
│  ├────────────────────────────────────────────────────┤  │
│  │                                                    │  │
│  │ Tema                │ Última │ Próxima │ Frecuencia│  │
│  ├─────────────────────┴────────┴─────────┴──────────┤  │
│  │ Seguridad Industrial│ 15/01/ │ 15/01/  │ Cada 12  │  │
│  │ MANT. INDUSTRIAL    │  2025  │  2026   │ meses    │  │
│  │                     │        │         │ [Vigente]│  │
│  ├─────────────────────┼────────┼─────────┼──────────┤  │
│  │ Primeros Auxilios   │ 10/05/ │ 10/11/  │ Cada 6   │  │
│  │ ADMINISTRACION      │  2025  │  2025   │ meses    │  │
│  │                     │        │         │ [Próximo]│  │
│  ├─────────────────────┼────────┼─────────┼──────────┤  │
│  │ Uso de EPP          │ Sin    │ Hoy     │ Cada 12  │  │
│  │ PLANTA EXTRACTORA   │registro│         │ meses    │  │
│  │                     │        │         │[Pendiente]│  │
│  └─────────────────────┴────────┴─────────┴──────────┘  │
│                                                          │
└──────────────────────────────────────────────────────────┘
```

**Benefits:**
- ✅ See all scheduled trainings in one place
- ✅ Know when next training is due
- ✅ See frequency of each training
- ✅ Color-coded status for quick identification
- ✅ Track training history (last date)

---

### 3. Automatic Date Calculation

#### Scenario: Complete a Training Form

**Step 1:** Create training form on 2025-10-23
```
┌────────────────────────────────────────┐
│ Nuevo Formulario de Capacitación      │
├────────────────────────────────────────┤
│ Tema: Seguridad Industrial            │
│ Fecha: 23/10/2025                     │
│ Asistentes:                           │
│   - Juan Pérez (123456)               │
│   - María García (789012)             │
│                                       │
│ [Guardar]                             │
└────────────────────────────────────────┘
```

**Step 2:** System automatically calculates next dates

For Juan Pérez (has programming: Seguridad Industrial, every 12 months):
```
Last training:  23/10/2025
Frequency:      12 months
Next training:  23/10/2026  ← Calculated automatically!
Status:         Vigente     ← Because it's in the future
```

For María García (has programming: Seguridad Industrial, every 12 months):
```
Last training:  23/10/2025
Frequency:      12 months
Next training:  23/10/2026  ← Calculated automatically!
Status:         Vigente     ← Because it's in the future
```

**Step 3:** Users can see it in their profile

When Juan opens Usuarios.html → Programadas tab:
```
┌──────────────────────────────────────────────────────────┐
│ Seguridad Industrial    │ 23/10/2025 │ 23/10/2026 │ 12 m│
│ MANTENIMIENTO INDUSTRIAL│            │            │[✓]  │
└──────────────────────────────────────────────────────────┘
```

---

### 4. Status Badge Colors

The "Programadas" tab uses color-coded badges:

```
🟢 Vigente (Green)
   - Next training date is more than 30 days away
   - Training is current and up-to-date

🟡 Próxima a vencer (Yellow)
   - Next training date is within 30 days
   - Training needs to be scheduled soon

🔴 Vencida (Red)
   - Next training date has passed
   - Training is overdue

🔵 Pendiente (Blue)
   - No training has been completed yet
   - First training needs to be scheduled
```

**Example Display:**
```
┌─────────────────────────────────────────────────┐
│ Tema              │ Próxima    │ Estado         │
├─────────────────────────────────────────────────┤
│ Seguridad         │ 15/12/2026 │ 🟢 Vigente     │
│ Primeros Auxilios │ 05/11/2025 │ 🟡 Próxima     │
│ Manejo de Crisis  │ 01/09/2025 │ 🔴 Vencida     │
│ Ergonomía         │ Hoy        │ 🔵 Pendiente   │
└─────────────────────────────────────────────────┘
```

---

### 5. Complete Workflow Example

**Scenario:** New employee "Carlos López" joins the company

1. **Admin creates programming:**
   - Cargo: OPERARIO
   - Sub Área: MANTENIMIENTO INDUSTRIAL (selected from dropdown)
   - Tema: Seguridad Industrial
   - Frecuencia: 12 meses
   - Rol: Capacitador MT
   
2. **System automatically creates notification:**
   - For all employees with cargo OPERARIO and sub-area MANT. INDUSTRIAL
   - Carlos López gets a notification
   - Status: Pendiente (no training yet)
   - Next date: Today
   
3. **Carlos sees in his Usuarios.html → Programadas:**
   ```
   ┌────────────────────────────────────────────────┐
   │ Seguridad Industrial  │ Sin registro │ Hoy    │
   │ MANT. INDUSTRIAL      │              │        │
   │ Cada 12 meses         │              │[Pendiente]│
   └────────────────────────────────────────────────┘
   ```
   
4. **Trainer schedules and completes training on 2025-10-25:**
   - Creates form with Carlos as attendee
   - Saves form
   - System calculates: next = 2025-10-25 + 12 months = 2026-10-25
   
5. **Carlos sees updated info:**
   ```
   ┌────────────────────────────────────────────────┐
   │ Seguridad Industrial  │ 25/10/2025 │ 25/10/2026│
   │ MANT. INDUSTRIAL      │            │           │
   │ Cada 12 meses         │            │ [Vigente] │
   └────────────────────────────────────────────────┘
   ```
   
6. **Time passes... 11 months later (September 2026):**
   - System automatically updates status to "Próxima a vencer"
   - Carlos sees:
   ```
   ┌────────────────────────────────────────────────┐
   │ Seguridad Industrial  │ 25/10/2025 │ 25/10/2026│
   │ MANT. INDUSTRIAL      │            │           │
   │ Cada 12 meses         │            │[Próximo] │
   └────────────────────────────────────────────────┘
   ```
   
7. **Trainer schedules next training on 2026-10-20:**
   - Creates new form with Carlos
   - System recalculates: next = 2026-10-20 + 12 months = 2027-10-20
   - Status changes back to "Vigente"

---

## Key Features Summary

### For Administrators:
✅ Easier programming creation with Sub Área dropdown
✅ No manual data entry errors
✅ Automatic next date calculations
✅ Clear visibility of training schedules

### For Trainers:
✅ Automatic notification updates when forms are saved
✅ System tracks training frequencies
✅ Clear view of who needs training and when

### For Employees:
✅ See all scheduled trainings in "Programadas" tab
✅ Know when next training is due
✅ Track training history
✅ Color-coded status for easy understanding

### System Benefits:
✅ Reduced manual work
✅ Improved data quality
✅ Better compliance tracking
✅ Automated reminders via status badges
