// assets/js/user_trainings.js
// Handles training display and progress for user profile page

(function() {
    'use strict';

    document.addEventListener('DOMContentLoaded', async function() {
        try {
            await loadUserData();
            await loadTrainingProgress();
            await loadLastTrainings();
            await loadPendingTrainings();
            await loadScheduledTrainings();
            await loadCompletedTrainings();
            await loadSessionHistory();
        } catch (error) {
            console.error('Error loading training data:', error);
        }
    });

    async function loadUserData() {
        try {
            const res = await fetch('/php/verificar_sesion.php', { cache: 'no-store' });
            const data = await res.json();

            if (data.success) {
                // Populate common user fields
                if (document.getElementById('usuario_txt')) {
                    document.getElementById('usuario_txt').value = data.usuario || '';
                }
                if (document.getElementById('nombre_usr')) {
                    document.getElementById('nombre_usr').value = data.nombre || '';
                }
                if (document.getElementById('apellido_usr')) {
                    document.getElementById('apellido_usr').value = data.apellido || '';
                }
                if (document.getElementById('cedula_usr')) {
                    document.getElementById('cedula_usr').value = data.cedula || '';
                }
                if (document.getElementById('id_u')) {
                    document.getElementById('id_u').value = data.usuario_id || '';
                }
                if (document.getElementById('rol_txt')) {
                    document.getElementById('rol_txt').value = data.rol || '';
                }

                // Store cedula in session storage for later use
                if (data.cedula) {
                    sessionStorage.setItem('user_cedula', data.cedula);
                }

                // Show collaborator section if user is a collaborator
                if (data.tipo_usuario === 'colaborador' && data.colaborador_info) {
                    const colabSection = document.getElementById('colaborador-section');
                    if (colabSection) {
                        colabSection.style.display = 'block';
                        
                        // Populate collaborator-specific fields
                        if (document.getElementById('empresa_txt')) {
                            document.getElementById('empresa_txt').value = data.colaborador_info.empresa || '';
                        }
                        if (document.getElementById('cargo_txt')) {
                            document.getElementById('cargo_txt').value = data.colaborador_info.cargo || '';
                        }
                        if (document.getElementById('rango_txt')) {
                            document.getElementById('rango_txt').value = data.colaborador_info.rango_cargo || '';
                        }
                        if (document.getElementById('area_txt')) {
                            document.getElementById('area_txt').value = data.colaborador_info.area || '';
                        }
                        if (document.getElementById('sub_area_txt')) {
                            document.getElementById('sub_area_txt').value = data.colaborador_info.sub_area || '';
                        }
                        if (document.getElementById('situacion_txt')) {
                            document.getElementById('situacion_txt').value = data.colaborador_info.situacion || '';
                        }
                    }
                }
            }
        } catch (error) {
            console.error('Error loading user data:', error);
        }
    }

    async function loadTrainingProgress() {
        try {
            const res = await fetch('/m_capacitaciones/assets/php/progreso_api.php?action=get_my_progress', {
                cache: 'no-store'
            });
            const result = await res.json();

            if (result.success && result.data) {
                const progress = result.data;
                const percentage = Math.round(progress.porcentaje_completado || 0);
                
                // Update progress bar
                const progressBar = document.getElementById('progressBar');
                const progressPercentage = document.getElementById('progressPercentage');
                
                if (progressBar) {
                    progressBar.style.width = percentage + '%';
                    progressBar.setAttribute('aria-valuenow', percentage);
                    progressBar.querySelector('.visually-hidden').textContent = percentage + '%';
                }
                
                if (progressPercentage) {
                    progressPercentage.textContent = percentage + '%';
                }

                // Update counts
                const completedCount = document.getElementById('completedCount');
                const totalCount = document.getElementById('totalCount');
                
                if (completedCount) {
                    completedCount.textContent = progress.capacitaciones_realizadas || 0;
                }
                if (totalCount) {
                    totalCount.textContent = progress.capacitaciones_programadas || 0;
                }
            }
        } catch (error) {
            console.error('Error loading progress:', error);
        }
    }

    async function loadLastTrainings() {
        try {
            const res = await fetch('/m_capacitaciones/assets/php/progreso_api.php?action=get_last_trainings&limit=5', {
                cache: 'no-store'
            });
            const result = await res.json();

            const container = document.getElementById('lastTrainingsContainer');
            if (!container) return;

            if (result.success && result.data && result.data.length > 0) {
                container.innerHTML = result.data.map(training => `
                    <div class="mb-3 pb-2 border-bottom">
                        <div class="d-flex justify-content-between align-items-start">
                            <div>
                                <h6 class="mb-1">${training.tema}</h6>
                                <small class="text-muted">
                                    ${training.lugar ? training.lugar + ' - ' : ''}
                                    ${formatDate(training.fecha)}
                                </small>
                            </div>
                            <span class="badge bg-success">Completada</span>
                        </div>
                    </div>
                `).join('');
            } else {
                container.innerHTML = `
                    <div class="text-center text-muted">
                        <i class="fas fa-info-circle"></i>
                        <p class="mb-0">No hay capacitaciones registradas</p>
                    </div>
                `;
            }
        } catch (error) {
            console.error('Error loading last trainings:', error);
            const container = document.getElementById('lastTrainingsContainer');
            if (container) {
                container.innerHTML = '<div class="alert alert-danger">Error al cargar capacitaciones</div>';
            }
        }
    }

    async function loadPendingTrainings() {
        try {
            const res = await fetch('/m_capacitaciones/assets/php/progreso_api.php?action=get_pending_trainings', {
                cache: 'no-store'
            });
            const result = await res.json();

            const container = document.getElementById('pendingTrainingsContainer');
            if (!container) return;

            if (result.success && result.data && result.data.length > 0) {
                container.innerHTML = `
                    <div class="table-responsive">
                        <table class="table table-sm">
                            <thead>
                                <tr>
                                    <th>Tema</th>
                                    <th>Fecha Próxima</th>
                                    <th>Estado</th>
                                    <th>Responsable</th>
                                </tr>
                            </thead>
                            <tbody>
                                ${result.data.map(training => {
                                    const badgeClass = training.estado === 'vencida' ? 'bg-danger' : 
                                                      training.estado === 'proximo_vencer' ? 'bg-warning' : 'bg-info';
                                    const estadoText = training.estado === 'vencida' ? 'Vencida' : 
                                                      training.estado === 'proximo_vencer' ? 'Próxima a vencer' : 'Pendiente';
                                    
                                    return `
                                        <tr>
                                            <td>${training.tema}</td>
                                            <td>${formatDate(training.fecha_proxima)}</td>
                                            <td><span class="badge ${badgeClass}">${estadoText}</span></td>
                                            <td><small>${training.responsable}</small></td>
                                        </tr>
                                    `;
                                }).join('')}
                            </tbody>
                        </table>
                    </div>
                `;
            } else {
                container.innerHTML = `
                    <div class="text-center text-muted py-3">
                        <i class="fas fa-check-circle fa-2x mb-2"></i>
                        <p class="mb-0">No hay capacitaciones pendientes</p>
                    </div>
                `;
            }
        } catch (error) {
            console.error('Error loading pending trainings:', error);
            const container = document.getElementById('pendingTrainingsContainer');
            if (container) {
                container.innerHTML = '<div class="alert alert-danger">Error al cargar capacitaciones pendientes</div>';
            }
        }
    }

    async function loadScheduledTrainings() {
        try {
            const res = await fetch('/m_capacitaciones/assets/php/progreso_api.php?action=get_scheduled_trainings', {
                cache: 'no-store'
            });
            const result = await res.json();

            const container = document.getElementById('scheduledTrainingsContainer');
            if (!container) return;

            if (result.success && result.data && result.data.length > 0) {
                container.innerHTML = `
                    <div class="table-responsive">
                        <table class="table table-sm">
                            <thead>
                                <tr>
                                    <th>Tema</th>
                                    <th>Última Capacitación</th>
                                    <th>Próxima Fecha</th>
                                    <th>Frecuencia</th>
                                    <th>Estado</th>
                                    <th>Responsable</th>
                                </tr>
                            </thead>
                            <tbody>
                                ${result.data.map(training => {
                                    const estadoText = training.estado === 'vencida' ? 'Vencida' : 
                                                      training.estado === 'proximo_vencer' ? 'Próxima a vencer' : 
                                                      training.estado === 'vigente' ? 'Vigente' : 'Pendiente';
                                    
                                    return `
                                        <tr>
                                            <td>
                                                <strong>${training.tema}</strong>
                                                ${training.sub_area ? `<br><small class="text-muted">${training.sub_area}</small>` : ''}
                                            </td>
                                            <td>${training.fecha_ultima_capacitacion ? formatDate(training.fecha_ultima_capacitacion) : 'Sin registro'}</td>
                                            <td>${formatDate(training.fecha_proxima)}</td>
                                            <td>Cada ${training.frecuencia_meses} mes${training.frecuencia_meses > 1 ? 'es' : ''}</td>
                                            <td><span class="badge bg-${training.badge_class}">${estadoText}</span></td>
                                            <td><small>${training.responsable}</small></td>
                                        </tr>
                                    `;
                                }).join('')}
                            </tbody>
                        </table>
                    </div>
                `;
            } else {
                container.innerHTML = `
                    <div class="text-center text-muted py-3">
                        <i class="fas fa-calendar-alt fa-2x mb-2"></i>
                        <p class="mb-0">No hay capacitaciones programadas</p>
                    </div>
                `;
            }
        } catch (error) {
            console.error('Error loading scheduled trainings:', error);
            const container = document.getElementById('scheduledTrainingsContainer');
            if (container) {
                container.innerHTML = '<div class="alert alert-danger">Error al cargar capacitaciones programadas</div>';
            }
        }
    }

    async function loadCompletedTrainings() {
        try {
            const res = await fetch('/m_capacitaciones/assets/php/progreso_api.php?action=get_completed_trainings_details', {
                cache: 'no-store'
            });
            const result = await res.json();

            const container = document.getElementById('completedTrainingsContainer');
            if (!container) return;

            if (result.success && result.data && result.data.length > 0) {
                const trainings = result.data;
                container.innerHTML = `
                    <div class="mb-3 d-flex justify-content-end">
                        <button id="exportExcelBtn" class="btn btn-success btn-sm">
                            <i class="fas fa-file-excel"></i> Exportar a Excel
                        </button>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-sm table-hover" id="completedTrainingsTable">
                            <thead class="table-light">
                                <tr>
                                    <th>Tema</th>
                                    <th>Tipo de Actividad</th>
                                    <th>Lugar</th>
                                    <th>Fecha</th>
                                    <th>Responsable</th>
                                </tr>
                            </thead>
                            <tbody>
                                ${trainings.map(training => `
                                    <tr>
                                        <td><strong>${training.tema}</strong></td>
                                        <td>${training.tipo_actividad || '-'}</td>
                                        <td>${training.lugar || '-'}</td>
                                        <td>${formatDate(training.fecha)}</td>
                                        <td><small>${training.responsable || '-'}</small></td>
                                    </tr>
                                `).join('')}
                            </tbody>
                        </table>
                    </div>
                    ${trainings.length > 0 ? `<div class="text-center mt-2"><small class="text-muted">Total: ${trainings.length} capacitaciones realizadas</small></div>` : ''}
                `;

                // Add event listener for Excel export button
                const exportBtn = document.getElementById('exportExcelBtn');
                if (exportBtn) {
                    exportBtn.addEventListener('click', exportToExcel);
                }
            } else {
                container.innerHTML = `
                    <div class="text-center text-muted py-3">
                        <i class="fas fa-info-circle fa-2x mb-2"></i>
                        <p class="mb-0">No hay capacitaciones realizadas</p>
                    </div>
                `;
            }
        } catch (error) {
            console.error('Error loading completed trainings:', error);
            const container = document.getElementById('completedTrainingsContainer');
            if (container) {
                container.innerHTML = '<div class="alert alert-danger">Error al cargar capacitaciones realizadas</div>';
            }
        }
    }

    async function exportToExcel() {
        try {
            // Show loading state
            const btn = document.getElementById('exportExcelBtn');
            const originalHTML = btn.innerHTML;
            btn.innerHTML = '<span class="spinner-border spinner-border-sm"></span> Exportando...';
            btn.disabled = true;

            // Fetch full training history with all fields
            const res = await fetch('/m_capacitaciones/assets/php/progreso_api.php?action=get_full_training_history', {
                cache: 'no-store'
            });
            const result = await res.json();

            if (!result.success || !result.data || result.data.length === 0) {
                alert('No hay datos para exportar');
                btn.innerHTML = originalHTML;
                btn.disabled = false;
                return;
            }

            const trainings = result.data;

            // Prepare data for Excel
            const excelData = trainings.map(training => ({
                'Proceso': training.proceso || '',
                'Lugar': training.lugar || '',
                'Responsable Capacitación': training.responsable_capacitacion || '',
                'Tema': training.tema || '',
                'Tipo de Actividad': training.tipo_actividad || '',
                'Fecha': training.fecha || '',
                'Hora Inicio': training.hora_inicio || '',
                'Hora Fin': training.hora_fin || '',
                'Estado Aprobación': training.estado_aprovacion || '',
                'Empresa': training.empresa || '',
                'Cargo': training.cargo || '',
                'Área': training.area || '',
                'Sub Área': training.sub_area || '',
                'Rango': training.rango || '',
                'Situación': training.situacion || ''
            }));

            // Create workbook and worksheet
            const wb = XLSX.utils.book_new();
            const ws = XLSX.utils.json_to_sheet(excelData);

            // Set column widths
            const colWidths = [
                { wch: 20 }, // Proceso
                { wch: 20 }, // Lugar
                { wch: 25 }, // Responsable Capacitación
                { wch: 30 }, // Tema
                { wch: 20 }, // Tipo de Actividad
                { wch: 12 }, // Fecha
                { wch: 10 }, // Hora Inicio
                { wch: 10 }, // Hora Fin
                { wch: 15 }, // Estado Aprobación
                { wch: 25 }, // Empresa
                { wch: 25 }, // Cargo
                { wch: 20 }, // Área
                { wch: 20 }, // Sub Área
                { wch: 15 }, // Rango
                { wch: 15 }  // Situación
            ];
            ws['!cols'] = colWidths;

            // Add worksheet to workbook
            XLSX.utils.book_append_sheet(wb, ws, 'Capacitaciones');

            // Generate filename with current date and cedula
            const cedula = sessionStorage.getItem('user_cedula') || 'usuario';
            const today = new Date().toISOString().split('T')[0];
            const filename = `Historial_Capacitaciones_${cedula}_${today}.xlsx`;

            // Save file
            XLSX.writeFile(wb, filename);

            // Restore button state
            btn.innerHTML = originalHTML;
            btn.disabled = false;

        } catch (error) {
            console.error('Error exporting to Excel:', error);
            alert('Error al exportar a Excel. Por favor intente nuevamente.');
            
            const btn = document.getElementById('exportExcelBtn');
            if (btn) {
                btn.innerHTML = '<i class="fas fa-file-excel"></i> Exportar a Excel';
                btn.disabled = false;
            }
        }
    }

    function formatDate(dateString) {
        if (!dateString) return '-';
        const date = new Date(dateString);
        return date.toLocaleDateString('es-CO', { 
            year: 'numeric', 
            month: 'short', 
            day: 'numeric' 
        });
    }

    function formatDateTime(dateString) {
        if (!dateString) return '-';
        try {
            const date = new Date(dateString);
            return date.toLocaleString('es-CO', {
                year: 'numeric',
                month: '2-digit',
                day: '2-digit',
                hour: '2-digit',
                minute: '2-digit'
            });
        } catch (e) {
            return dateString;
        }
    }

    async function loadSessionHistory() {
        try {
            const res = await fetch('/php/session_management_api.php?action=get_my_sessions&limit=20', {
                cache: 'no-store'
            });
            const result = await res.json();

            const table = document.getElementById('sessionHistoryTable');
            if (!table) return;

            if (result.success && result.sessions && result.sessions.length > 0) {
                table.innerHTML = result.sessions.map(session => {
                    const isActive = session.activa;
                    const statusBadge = isActive ? 
                        '<span class="badge bg-success">Activa</span>' : 
                        '<span class="badge bg-secondary">Cerrada</span>';
                    
                    return `
                        <tr>
                            <td>${formatDateTime(session.fecha_inicio)}</td>
                            <td>${session.fecha_cierre ? formatDateTime(session.fecha_cierre) : '-'}</td>
                            <td><small>${session.ip_address || '-'}</small></td>
                            <td><small>${session.host_name || '-'}</small></td>
                            <td>${statusBadge}</td>
                        </tr>
                    `;
                }).join('');
            } else {
                table.innerHTML = `
                    <tr>
                        <td colspan="5" class="text-center text-muted py-3">
                            <i class="fas fa-info-circle"></i>
                            No hay historial de sesiones
                        </td>
                    </tr>
                `;
            }
        } catch (error) {
            console.error('Error loading session history:', error);
            const table = document.getElementById('sessionHistoryTable');
            if (table) {
                table.innerHTML = `
                    <tr>
                        <td colspan="5" class="text-center">
                            <div class="alert alert-danger mb-0">Error al cargar historial de sesiones</div>
                        </td>
                    </tr>
                `;
            }
        }
    }
})();
