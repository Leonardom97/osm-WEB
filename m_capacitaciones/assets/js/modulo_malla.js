// assets/js/modulo_malla.js
// Manages training matrix (malla) interface

(function() {
    'use strict';

    let mallaData = [];
    let filters = {
        cargos: [],
        sub_areas: [],
        temas: [],
        roles: []
    };

    // Helper function to format dates without timezone offset issues
    // Parses date string in local timezone to avoid UTC conversion issues
    function formatDateLocal(dateString) {
        if (!dateString) return null;
        
        // Parse date components to avoid timezone issues
        // Date from DB is in format YYYY-MM-DD
        const parts = dateString.split('T')[0].split('-');
        const year = parseInt(parts[0], 10);
        const month = parseInt(parts[1], 10) - 1; // months are 0-indexed
        const day = parseInt(parts[2], 10);
        
        // Create date in local timezone
        const date = new Date(year, month, day);
        
        // Format as local date string
        return date.toLocaleDateString('es-CO');
    }

    // Load HTML components
    async function includeComponent(file, selector) {
        try {
            const res = await fetch(file, { cache: 'no-store' });
            if (!res.ok) throw new Error('HTTP ' + res.status);
            const html = await res.text();
            const el = document.querySelector(selector);
            if (el) el.innerHTML = html;
        } catch (err) {
            console.error(`Error loading ${file}:`, err);
        }
    }

    document.addEventListener('DOMContentLoaded', async function() {
        try {
            await includeComponent('../includes/navbar.html', '#navbar');
            await includeComponent('../includes/sidebar.html', '#sidebar');
            
            document.body.style.visibility = 'visible';
            
            await loadData();
            setupEventListeners();
        } catch (error) {
            console.error('Error initializing page:', error);
            showAlert('Error al cargar la página', 'danger');
        }
    });

    async function loadData() {
        try {
            const [mallaRes, summaryRes, filtersRes] = await Promise.all([
                fetch('assets/php/malla_api.php?action=get_malla'),
                fetch('assets/php/malla_api.php?action=get_summary'),
                fetch('assets/php/malla_api.php?action=get_filters')
            ]);

            const mallaResult = await mallaRes.json();
            const summaryResult = await summaryRes.json();
            const filtersResult = await filtersRes.json();

            if (mallaResult.success) {
                mallaData = mallaResult.data;
                renderTable();
            }

            if (summaryResult.success) {
                updateSummaryCards(summaryResult.data);
            }

            if (filtersResult.success) {
                filters = filtersResult.data;
                populateFilters();
            }
        } catch (error) {
            console.error('Error loading data:', error);
            showAlert('Error al cargar datos', 'danger');
        }
    }

    function updateSummaryCards(summary) {
        document.getElementById('totalActivos').textContent = summary.total_colaboradores_activos || 0;
        document.getElementById('totalPendientes').textContent = summary.total_pendientes || 0;
        document.getElementById('totalVencidas').textContent = summary.total_vencidas || 0;
        document.getElementById('totalAlDia').textContent = summary.total_al_dia || 0;
    }

    function populateFilters() {
        const cargoSelect = document.getElementById('filterCargo');
        const subAreaSelect = document.getElementById('filterSubArea');
        const temaSelect = document.getElementById('filterTema');
        const rolSelect = document.getElementById('filterRol');

        filters.cargos.forEach(cargo => {
            const option = document.createElement('option');
            option.value = cargo.id;
            option.textContent = cargo.cargo;
            cargoSelect.appendChild(option);
        });

        filters.sub_areas.forEach(sa => {
            const option = document.createElement('option');
            option.value = sa.id_area;
            option.textContent = sa.sub_area;
            subAreaSelect.appendChild(option);
        });

        filters.temas.forEach(tema => {
            const option = document.createElement('option');
            option.value = tema.id;
            option.textContent = tema.nombre;
            temaSelect.appendChild(option);
        });

        filters.roles.forEach(rol => {
            const option = document.createElement('option');
            option.value = rol.id;
            option.textContent = rol.nombre;
            rolSelect.appendChild(option);
        });
    }

    function renderTable(data = null) {
        const tbody = document.querySelector('#tableMalla tbody');
        const records = data || mallaData;

        if (records.length === 0) {
            tbody.innerHTML = '<tr><td colspan="11" class="text-center">No hay registros</td></tr>';
            return;
        }

        tbody.innerHTML = records.map(record => {
            const estado = record.estado || 'pendiente';
            let estadoBadge = '';
            
            switch(estado) {
                case 'al_dia':
                    estadoBadge = '<span class="badge bg-success">Al Día</span>';
                    break;
                case 'proximo_vencer':
                    estadoBadge = '<span class="badge bg-warning text-dark">Próximo a Vencer</span>';
                    break;
                case 'vencida':
                    estadoBadge = '<span class="badge bg-danger">Vencida</span>';
                    break;
                default:
                    estadoBadge = '<span class="badge bg-secondary">Pendiente</span>';
            }

            const ultimaCapacitacion = record.ultima_capacitacion 
                ? formatDateLocal(record.ultima_capacitacion) 
                : '-';
            
            const proximaCapacitacion = record.proxima_capacitacion 
                ? formatDateLocal(record.proxima_capacitacion) 
                : '-';

            const diasRestantes = record.dias_restantes !== null ? record.dias_restantes : '-';
            let diasBadge = '-';
            
            if (diasRestantes !== '-') {
                const dias = parseInt(diasRestantes);
                if (dias < 0) {
                    diasBadge = `<span class="badge bg-danger">${Math.abs(dias)} días vencidos</span>`;
                } else if (dias <= 30) {
                    diasBadge = `<span class="badge bg-warning text-dark">${dias} días</span>`;
                } else {
                    diasBadge = `<span class="badge bg-info">${dias} días</span>`;
                }
            }

            return `
                <tr>
                    <td>${estadoBadge}</td>
                    <td>${record.nombre_completo}</td>
                    <td>${record.ac_cedula}</td>
                    <td>${record.cargo_nombre}</td>
                    <td>${record.sub_area_nombre || '-'}</td>
                    <td>${record.tema_nombre}</td>
                    <td>${record.frecuencia_meses} meses</td>
                    <td class="text-center">${ultimaCapacitacion}</td>
                    <td class="text-center">${proximaCapacitacion}</td>
                    <td class="text-center">${diasBadge}</td>
                    <td><span class="badge bg-info">${record.rol_capacitador_nombre}</span></td>
                </tr>
            `;
        }).join('');
    }

    function applyFilters() {
        const estadoFilter = document.getElementById('filterEstado').value;
        const cargoFilter = document.getElementById('filterCargo').value;
        const subAreaFilter = document.getElementById('filterSubArea').value;
        const temaFilter = document.getElementById('filterTema').value;
        const rolFilter = document.getElementById('filterRol').value;

        let filtered = mallaData;

        if (estadoFilter) {
            filtered = filtered.filter(r => r.estado === estadoFilter);
        }

        if (cargoFilter) {
            filtered = filtered.filter(r => r.ac_id_cargo === cargoFilter);
        }

        if (subAreaFilter) {
            filtered = filtered.filter(r => r.ac_sub_area === subAreaFilter);
        }

        if (temaFilter) {
            filtered = filtered.filter(r => r.id_tema == temaFilter);
        }

        if (rolFilter) {
            filtered = filtered.filter(r => r.id_rol_capacitador == rolFilter);
        }

        renderTable(filtered);
    }

    function exportToExcel() {
        if (mallaData.length === 0) {
            alert('No hay datos para exportar');
            return;
        }

        // Prepare data for export
        const exportData = mallaData.map(record => ({
            'Estado': getEstadoText(record.estado),
            'Colaborador': record.nombre_completo,
            'Cédula': record.ac_cedula,
            'Cargo': record.cargo_nombre,
            'Sub Área': record.sub_area_nombre || '-',
            'Tema': record.tema_nombre,
            'Frecuencia (meses)': record.frecuencia_meses,
            'Última Capacitación': record.ultima_capacitacion 
                ? formatDateLocal(record.ultima_capacitacion) 
                : '-',
            'Próxima Capacitación': record.proxima_capacitacion 
                ? formatDateLocal(record.proxima_capacitacion) 
                : '-',
            'Días Restantes': record.dias_restantes !== null ? record.dias_restantes : '-',
            'Rol Capacitador': record.rol_capacitador_nombre
        }));

        const ws = XLSX.utils.json_to_sheet(exportData);
        const wb = XLSX.utils.book_new();
        XLSX.utils.book_append_sheet(wb, ws, 'Malla Capacitaciones');

        // Generate filename with date
        const filename = `Malla_Capacitaciones_${new Date().toISOString().split('T')[0]}.xlsx`;
        XLSX.writeFile(wb, filename);
    }

    function getEstadoText(estado) {
        switch(estado) {
            case 'al_dia': return 'Al Día';
            case 'proximo_vencer': return 'Próximo a Vencer';
            case 'vencida': return 'Vencida';
            default: return 'Pendiente';
        }
    }

    function setupEventListeners() {
        document.getElementById('btnExportExcel').addEventListener('click', exportToExcel);
        document.getElementById('filterEstado').addEventListener('change', applyFilters);
        document.getElementById('filterCargo').addEventListener('change', applyFilters);
        document.getElementById('filterSubArea').addEventListener('change', applyFilters);
        document.getElementById('filterTema').addEventListener('change', applyFilters);
        document.getElementById('filterRol').addEventListener('change', applyFilters);
        
        document.getElementById('btnClearFilters').addEventListener('click', function() {
            document.getElementById('filterEstado').value = '';
            document.getElementById('filterCargo').value = '';
            document.getElementById('filterSubArea').value = '';
            document.getElementById('filterTema').value = '';
            document.getElementById('filterRol').value = '';
            renderTable();
        });
    }

    function showAlert(message, type) {
        const alert = document.createElement('div');
        alert.className = `alert alert-${type} alert-dismissible fade show position-fixed top-0 end-0 m-3`;
        alert.style.zIndex = '9999';
        alert.innerHTML = `
            ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        `;
        document.body.appendChild(alert);
        
        setTimeout(() => alert.remove(), 5000);
    }
})();
