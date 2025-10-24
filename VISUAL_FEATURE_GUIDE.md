# Visual Feature Guide - Trainer Notification System

## What You'll See

This document describes the visual changes users will experience with the new trainer notification system.

---

## For Trainers (e.g., Alba with role "Capacitador_MT")

### 1. Alert Banner (programacion.html)

When trainings are expiring within 7 days, trainers see a prominent alert banner at the top of the page:

```
╔══════════════════════════════════════════════════════════════════════╗
║ ⚠️  Capacitaciones que Vencen Pronto                              [×]║
║                                                                       ║
║  • Seguridad Industrial - Polinizador (Producción Agrícola)         ║
║    Vence en 5 días - 3 colaborador(es) pendiente(s)                 ║
║    Rol: Capacitador_MT                                               ║
║                                                                       ║
║  • Manejo de Químicos - Operador (Mantenimiento Industrial)         ║
║    Vencida hace 2 días - 5 colaborador(es) pendiente(s)             ║
║    Rol: Capacitador_MT                                               ║
╚══════════════════════════════════════════════════════════════════════╝
```

**Color Coding:**
- 🔴 **Red Banner**: At least one training is expired (negative days)
- 🟡 **Yellow Banner**: Most urgent training expires in 3 days or less
- 🔵 **Blue Banner**: Trainings expire within 7 days

### 2. Enhanced Programming Table

The programming table now includes two new columns:

```
┌────┬───────────┬──────────────┬──────────────┬────────┬──────────┬───────────────────┬───────────┬─────────┐
│ ID │ Cargo     │ Sub Área     │ Tema         │ Frec.  │ Rol      │ Próxima Cap.      │ Pendientes│ Acciones│
├────┼───────────┼──────────────┼──────────────┼────────┼──────────┼───────────────────┼───────────┼─────────┤
│ 1  │ Poliniza..│ Prod. Agrí...│ Seguridad I..│   12   │ [Cap.MT] │ ╔══════════════╗ │  ┌───┐    │  ✏️ 🗑️  │
│    │           │              │              │ meses  │          │ ║ 🟡 28/10/24  ║ │  │ 3 │    │         │
│    │           │              │              │        │          │ ║ En 5 días    ║ │  └───┘    │         │
│    │           │              │              │        │          │ ╚══════════════╝ │           │         │
├────┼───────────┼──────────────┼──────────────┼────────┼──────────┼───────────────────┼───────────┼─────────┤
│ 2  │ Operador  │ Mantenimien..│ Manejo Quí...│   12   │ [Cap.MT] │ ╔══════════════╗ │  ┌───┐    │  ✏️ 🗑️  │
│    │           │              │              │ meses  │          │ ║ 🔴 21/10/24  ║ │  │ 5 │    │         │
│    │           │              │              │        │          │ ║ Vencida      ║ │  └───┘    │         │
│    │           │              │              │        │          │ ╚══════════════╝ │           │         │
├────┼───────────┼──────────────┼──────────────┼────────┼──────────┼───────────────────┼───────────┼─────────┤
│ 3  │ Supervis..│ Prod. Agrí...│ Liderazgo    │   12   │ [Cap.GH] │ ╔══════════════╗ │  ┌───┐    │  ✏️ 🗑️  │
│    │           │              │              │ meses  │          │ ║ 🔵 30/10/24  ║ │  │ 2 │    │         │
│    │           │              │              │        │          │ ║ En 7 días    ║ │  └───┘    │         │
│    │           │              │              │        │          │ ╚══════════════╝ │           │         │
├────┼───────────┼──────────────┼──────────────┼────────┼──────────┼───────────────────┼───────────┼─────────┤
│ 4  │ Analista  │ Laboratorio  │ Análisis     │   12   │ [Cap.TI] │        -          │     -     │  ✏️ 🗑️  │
│    │           │              │              │ meses  │          │   (Sin programar) │           │         │
└────┴───────────┴──────────────┴──────────────┴────────┴──────────┴───────────────────┴───────────┴─────────┘
```

**New Columns Explained:**

**"Próxima Capacitación" (Next Training):**
- Shows the date when the next training is scheduled
- Color-coded badge indicates urgency:
  - 🔴 Red: Expired (past due date)
  - 🟡 Yellow: Expiring in 3 days or less
  - 🔵 Blue: Expiring within 7 days
  - ⚫ Gray: More than 7 days away
- Shows text like "En X días" or "Vencida"
- Shows "-" if no trainings are scheduled yet

**"Pendientes" (Pending Collaborators):**
- Shows count of collaborators who need this training
- Blue badge with number
- Helps trainer prioritize which trainings to schedule first
- Gray "0" badge if all collaborators are up to date

---

## For Collaborators (e.g., Lina)

### User Panel - Programadas Tab

When collaborators log in, they see their scheduled trainings:

```
╔════════════════════════════════════════════════════════════════════╗
║  Mis Capacitaciones Programadas                                    ║
╠════════════════════════════════════════════════════════════════════╣
║                                                                    ║
║  📚 Seguridad Industrial                                           ║
║  ├─ Última capacitación: 23/10/2024                               ║
║  ├─ Próxima capacitación: 23/10/2025                              ║
║  ├─ Estado: ✅ Vigente (340 días restantes)                        ║
║  └─ Responsable: Alba Martínez (Capacitador_MT)                   ║
║                                                                    ║
╠════════════════════════════════════════════════════════════════════╣
║                                                                    ║
║  📚 Manejo de Herramientas                                         ║
║  ├─ Última capacitación: 15/09/2024                               ║
║  ├─ Próxima capacitación: 15/09/2025                              ║
║  ├─ Estado: ⚠️ Próximo a vencer (25 días restantes)               ║
║  └─ Responsable: Carlos López (Capacitador_MT)                    ║
║                                                                    ║
╠════════════════════════════════════════════════════════════════════╣
║                                                                    ║
║  📚 Primeros Auxilios                                              ║
║  ├─ Última capacitación: 10/08/2023                               ║
║  ├─ Próxima capacitación: 10/08/2024                              ║
║  ├─ Estado: 🔴 Vencida (hace 74 días)                             ║
║  └─ Responsable: María González (Capacitador_GH)                  ║
║                                                                    ║
╚════════════════════════════════════════════════════════════════════╝
```

**Status Indicators:**
- ✅ **Vigente** (Green): Training is current, more than 30 days until expiration
- ⚠️ **Próximo a vencer** (Yellow): Training expires within 30 days
- 🔴 **Vencida** (Red): Training has expired

---

## Notification Bell (Navbar)

Both trainers and collaborators see notifications in the navbar:

```
╔═══════════════════════════════════════════╗
║  🔔 Capacitaciones Pendientes       [3]  ║
╠═══════════════════════════════════════════╣
║                                           ║
║  ⚠️  Seguridad Industrial                 ║
║      Faltan 5 días                        ║
║                                           ║
║  ⚠️  Manejo de Químicos                   ║
║      Vencida hace 2 días                  ║
║                                           ║
║  📅  Primeros Auxilios                    ║
║      Faltan 25 días                       ║
║                                           ║
╠═══════════════════════════════════════════╣
║  Ver todas las capacitaciones →          ║
╚═══════════════════════════════════════════╝
```

**Badge Number:** Shows count of unread notifications

---

## Workflow Visualization

### Complete Training Cycle

```
     Day 0: Programming Created
     ┌─────────────────────┐
     │ Alba creates:       │
     │ - Seguridad Ind.    │
     │ - Polinizador       │
     │ - Freq: 12 months   │
     └──────────┬──────────┘
                │
                ▼
     Day 0: First Training
     ┌─────────────────────┐
     │ Alba conducts       │
     │ Lina attends        │
     │ System records:     │
     │ Next = Oct 23, 2025 │
     └──────────┬──────────┘
                │
                │ Time passes...
                │
                ▼
   Day 358: 7 Days Before
   ┌──────────────────────────────┐
   │ Alba sees BLUE alert:        │
   │ "Vence en 7 días"            │
   │ "1 colaborador pendiente"    │
   │                              │
   │ Alba plans to call Lina      │
   └──────────┬───────────────────┘
              │
              ▼
   Day 362: 3 Days Before
   ┌──────────────────────────────┐
   │ Alert turns YELLOW:          │
   │ "Vence en 3 días"            │
   │ More urgent!                 │
   └──────────┬───────────────────┘
              │
              ▼
   Day 365: Training Day
   ┌──────────────────────────────┐
   │ Alba conducts training       │
   │ Lina attends                 │
   │ System auto-updates:         │
   │ Next = Oct 23, 2026          │
   │ Alert disappears ✓           │
   └──────────────────────────────┘
              │
              │ Cycle repeats...
              │
              ▼
        Next Year...
```

---

## Color Reference Guide

### Alert Banner Colors

| Days Until Expiration | Color  | CSS Class       | Urgency Level |
|-----------------------|--------|-----------------|---------------|
| Expired (negative)    | 🔴 Red | alert-danger    | Critical      |
| 1-3 days              | 🟡 Yellow | alert-warning | High         |
| 4-7 days              | 🔵 Blue | alert-info      | Medium        |
| > 7 days              | No alert shown | -            | Low           |

### Date Badge Colors

| Days Until Expiration | Color  | CSS Class    | Badge Text         |
|-----------------------|--------|--------------|--------------------|
| Expired (negative)    | 🔴 Red | badge bg-danger | "Vencida"       |
| 1-3 days              | 🟡 Yellow | badge bg-warning | "En X días"  |
| 4-7 days              | 🔵 Blue | badge bg-info | "En X días"      |
| 8-30 days             | 🔵 Blue | badge bg-info | "En X días"      |
| > 30 days             | ⚫ Gray | badge bg-secondary | "En X días" |
| Not scheduled         | -      | -            | "-"                |

### Pending Count Badge

| Count | Color  | CSS Class       |
|-------|--------|-----------------|
| > 0   | 🔵 Blue | badge bg-primary |
| 0     | ⚫ Gray | badge bg-secondary |

---

## User Interface States

### State 1: No Alerts (Healthy State)

```
╔═══════════════════════════════════════════════════════════════╗
║ Programación de Capacitaciones                       [+ Nueva]║
╠═══════════════════════════════════════════════════════════════╣
║                                                               ║
║ [No hay capacitaciones próximas a vencer]                    ║
║                                                               ║
║ ┌─────────────────────────────────────────────────────────┐ ║
║ │ ID │ Cargo │ Tema │ ... │ Próxima │ Pendientes │ ...   │ ║
║ ├─────────────────────────────────────────────────────────┤ ║
║ │ 1  │ ...   │ ...  │ ... │ ⚫ 45 días│     2      │ ...   │ ║
║ │ 2  │ ...   │ ...  │ ... │ ⚫ 120 días│    5      │ ...   │ ║
║ └─────────────────────────────────────────────────────────┘ ║
╚═══════════════════════════════════════════════════════════════╝
```

### State 2: Blue Alerts (7 Days)

```
╔═══════════════════════════════════════════════════════════════╗
║ Programación de Capacitaciones                       [+ Nueva]║
╠═══════════════════════════════════════════════════════════════╣
║ ╔═══════════════════════════════════════════════════════════╗║
║ ║ 🔵 Capacitaciones que Vencen Pronto                 [×]  ║║
║ ║                                                           ║║
║ ║ • Seguridad Industrial - Polinizador                     ║║
║ ║   Vence en 7 días - 3 colaborador(es) pendiente(s)      ║║
║ ╚═══════════════════════════════════════════════════════════╝║
║                                                               ║
║ ┌─────────────────────────────────────────────────────────┐ ║
║ │ ID │ Cargo │ Tema │ ... │ Próxima │ Pendientes │ ...   │ ║
║ ├─────────────────────────────────────────────────────────┤ ║
║ │ 1  │ ...   │ Seg..│ ... │ 🔵 7 días│     3      │ ...   │ ║
║ │ 2  │ ...   │ ...  │ ... │ ⚫ 45 días│     2      │ ...   │ ║
║ └─────────────────────────────────────────────────────────┘ ║
╚═══════════════════════════════════════════════════════════════╝
```

### State 3: Yellow Alerts (3 Days)

```
╔═══════════════════════════════════════════════════════════════╗
║ Programación de Capacitaciones                       [+ Nueva]║
╠═══════════════════════════════════════════════════════════════╣
║ ╔═══════════════════════════════════════════════════════════╗║
║ ║ 🟡 Capacitaciones que Vencen Pronto                 [×]  ║║
║ ║                                                           ║║
║ ║ • Seguridad Industrial - Polinizador                     ║║
║ ║   Vence en 3 días - 3 colaborador(es) pendiente(s)      ║║
║ ╚═══════════════════════════════════════════════════════════╝║
║                                                               ║
║ ┌─────────────────────────────────────────────────────────┐ ║
║ │ ID │ Cargo │ Tema │ ... │ Próxima │ Pendientes │ ...   │ ║
║ ├─────────────────────────────────────────────────────────┤ ║
║ │ 1  │ ...   │ Seg..│ ... │ 🟡 3 días│     3      │ ...   │ ║
║ │ 2  │ ...   │ ...  │ ... │ ⚫ 45 días│     2      │ ...   │ ║
║ └─────────────────────────────────────────────────────────┘ ║
╚═══════════════════════════════════════════════════════════════╝
```

### State 4: Red Alerts (Expired)

```
╔═══════════════════════════════════════════════════════════════╗
║ Programación de Capacitaciones                       [+ Nueva]║
╠═══════════════════════════════════════════════════════════════╣
║ ╔═══════════════════════════════════════════════════════════╗║
║ ║ 🔴 Capacitaciones que Vencen Pronto                 [×]  ║║
║ ║                                                           ║║
║ ║ • Manejo de Químicos - Operador                          ║║
║ ║   Vencida hace 2 días - 5 colaborador(es) pendiente(s)  ║║
║ ║                                                           ║║
║ ║ • Seguridad Industrial - Polinizador                     ║║
║ ║   Vence en 3 días - 3 colaborador(es) pendiente(s)      ║║
║ ╚═══════════════════════════════════════════════════════════╝║
║                                                               ║
║ ┌─────────────────────────────────────────────────────────┐ ║
║ │ ID │ Cargo │ Tema │ ... │ Próxima │ Pendientes │ ...   │ ║
║ ├─────────────────────────────────────────────────────────┤ ║
║ │ 1  │ ...   │ Man..│ ... │ 🔴 Vencida│    5      │ ...   │ ║
║ │ 2  │ ...   │ Seg..│ ... │ 🟡 3 días│     3      │ ...   │ ║
║ └─────────────────────────────────────────────────────────┘ ║
╚═══════════════════════════════════════════════════════════════╝
```

---

## Mobile Responsive Design

On mobile devices (screen width < 768px):

### Alert Banner
- Stacks vertically
- Font size adjusts
- Close button remains visible
- Trainings listed one per line

### Programming Table
- Horizontal scroll enabled
- Essential columns prioritized
- Badges stack if needed
- Touch-friendly buttons

---

## Accessibility Features

✅ **Color + Text**: Colors accompanied by text ("Vencida", "En X días")
✅ **Screen Reader Support**: ARIA labels on badges and alerts
✅ **Keyboard Navigation**: All interactive elements keyboard-accessible
✅ **Contrast Ratios**: Meet WCAG AA standards
✅ **Focus Indicators**: Clear visual focus for keyboard users

---

## Tips for Best User Experience

### For Trainers

1. **Check Daily**: Log in to programacion.html at start of workday
2. **Prioritize Red**: Address expired trainings first
3. **Plan Yellow**: Schedule trainings showing yellow alerts (3 days)
4. **Monitor Blue**: Begin planning for blue alerts (7 days)
5. **Use Pending Count**: Focus on trainings with high pending counts

### For Collaborators

1. **Check Panel**: Review "Programadas" tab monthly
2. **Note Dates**: Add next training dates to personal calendar
3. **Respond Promptly**: When trainer contacts about upcoming training
4. **Update Manager**: If unable to attend scheduled training

---

## Comparison: Before vs After

### Before This Update

```
┌────────────────────────────────────────────────────┐
│ Programación de Capacitaciones          [+ Nueva] │
├────────────────────────────────────────────────────┤
│                                                    │
│ ┌────┬─────────┬──────────┬───────┬──────────┐   │
│ │ ID │ Cargo   │ Tema     │ Freq. │ Acciones │   │
│ ├────┼─────────┼──────────┼───────┼──────────┤   │
│ │ 1  │ Polin...│ Seg. I...│  12   │  ✏️ 🗑️   │   │
│ │ 2  │ Opera...│ Manejo...│  12   │  ✏️ 🗑️   │   │
│ └────┴─────────┴──────────┴───────┴──────────┘   │
│                                                    │
│ ❌ No alerts                                       │
│ ❌ No next training dates                          │
│ ❌ No pending counts                               │
│ ❌ Manual tracking required                        │
└────────────────────────────────────────────────────┘
```

### After This Update

```
┌────────────────────────────────────────────────────┐
│ Programación de Capacitaciones          [+ Nueva] │
├────────────────────────────────────────────────────┤
│ ╔════════════════════════════════════════════════╗│
│ ║ 🟡 Capacitaciones que Vencen Pronto      [×] ║│
│ ║ • Seguridad Industrial - Vence en 3 días     ║│
│ ║   3 colaborador(es) pendiente(s)             ║│
│ ╚════════════════════════════════════════════════╝│
│                                                    │
│ ┌────┬─────┬──────┬────┬───────────┬──────┬────┐│
│ │ ID │Cargo│ Tema │Frec│ Próxima   │Pend. │... ││
│ ├────┼─────┼──────┼────┼───────────┼──────┼────┤│
│ │ 1  │Pol..│Seg I.│ 12 │🟡 3 días  │  3   │... ││
│ │ 2  │Oper.│Manej.│ 12 │⚫ 45 días │  5   │... ││
│ └────┴─────┴──────┴────┴───────────┴──────┴────┘│
│                                                    │
│ ✅ Proactive alerts                                │
│ ✅ Next training dates visible                     │
│ ✅ Pending counts shown                            │
│ ✅ Automatic tracking                              │
└────────────────────────────────────────────────────┘
```

---

## Summary

This visual guide demonstrates how the new trainer notification system enhances the user experience by:

1. **Providing Clear Alerts**: Color-coded warnings appear 7 days before trainings expire
2. **Showing Next Dates**: Trainers can see when each training is scheduled
3. **Displaying Pending Counts**: Quick overview of workload per training
4. **Using Visual Hierarchy**: Most urgent items stand out with red/yellow colors
5. **Maintaining Context**: All information accessible without leaving the page

The system transforms passive training management into proactive planning, helping trainers stay ahead of deadlines and ensuring compliance.
