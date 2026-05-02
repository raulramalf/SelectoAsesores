<script setup>
import AdminLayout from '@/Layouts/AdminLayout.vue'
import { useForm, router, usePage } from '@inertiajs/vue3'
import { ref, computed } from 'vue'

const props = defineProps({
    citas:    { type: Array, default: () => [] },
    clientes: { type: Array, default: () => [] },
})

const page = usePage()

// ─── CALENDARIO ──────────────────────────────────────
const meses      = ['Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre']
const mesesCortos= ['Ene','Feb','Mar','Abr','May','Jun','Jul','Ago','Sep','Oct','Nov','Dic']
const diasNombre = ['Lun','Mar','Mié','Jue','Vie','Sáb','Dom']
const hoy        = new Date()
const mesActual  = ref(hoy.getMonth())
const anioActual = ref(hoy.getFullYear())

function prevMes() {
    if (mesActual.value === 0) { mesActual.value = 11; anioActual.value-- }
    else mesActual.value--
}
function nextMes() {
    if (mesActual.value === 11) { mesActual.value = 0; anioActual.value++ }
    else mesActual.value++
}
function diasDelMes() {
    const primero = new Date(anioActual.value, mesActual.value, 1)
    const ultimo  = new Date(anioActual.value, mesActual.value + 1, 0)
    const offset  = (primero.getDay() + 6) % 7
    const dias = []
    for (let i = 0; i < offset; i++) dias.push(null)
    for (let i = 1; i <= ultimo.getDate(); i++) dias.push(i)
    return dias
}
function tieneCita(dia) {
    if (!dia) return false
    return props.citas.some(c => {
        const d = new Date(c.fecha)
        return d.getDate() === dia && d.getMonth() === mesActual.value && d.getFullYear() === anioActual.value
    })
}

// ─── FILTROS ─────────────────────────────────────────
const filtro   = ref('todas')
const buscador = ref('')

const citasFiltradas = computed(() =>
    props.citas.filter(c => {
        const matchFiltro = filtro.value === 'todas' || c.estado === filtro.value
        const matchBuscar = c.nombre?.toLowerCase().includes(buscador.value.toLowerCase()) ||
                            c.razon?.toLowerCase().includes(buscador.value.toLowerCase())
        return matchFiltro && matchBuscar
    })
)

// ─── ESTADO COLORES ───────────────────────────────────
const estadoColor = {
    pendiente:  { bg: 'rgba(212,175,55,.15)',  color: '#D4AF37' },
    confirmada: { bg: 'rgba(129,199,132,.15)', color: '#81c784' },
    cancelada:  { bg: 'rgba(229,115,115,.15)', color: '#e57373' },
    completada: { bg: 'rgba(100,181,246,.15)', color: '#64b5f6' },
}

// ─── MODAL NUEVA CITA ─────────────────────────────────
const modalOpen = ref(false)
const form = useForm({
    client_id:   '',
    reason:      'declaracion_renta',
    date:        '',
    time:        '10:00',
    description: '',
})

function abrirModal() { form.reset(); form.reason = 'declaracion_renta'; form.time = '10:00'; modalOpen.value = true }
function cerrarModal() { modalOpen.value = false; form.reset() }

function guardarCita() {
    form.post(route('admin.citas.store'), {
        onSuccess: () => cerrarModal(),
    })
}

// ─── CAMBIAR ESTADO ───────────────────────────────────
function cambiarEstado(cita, estado) {
    router.patch(`/admin/citas/${cita.id}/estado`, { estado }, { preserveScroll: true })
}

// ─── ELIMINAR ─────────────────────────────────────────
const citaAEliminar = ref(null)
function confirmarEliminar(cita) { citaAEliminar.value = cita }
function cancelarEliminar()      { citaAEliminar.value = null }
function eliminarCita() {
    router.delete(`/admin/citas/${citaAEliminar.value.id}`, {
        onSuccess: () => { citaAEliminar.value = null }
    })
}

const flashOk = computed(() => page.props.flash?.status === 'cita-creada')

const razonesLabel = {
    declaracion_renta: 'Declaración Renta',
    asesoria_fiscal:   'Asesoría Fiscal',
    contabilidad:      'Contabilidad',
    autonomos:         'Autónomos',
    sociedades:        'Sociedades',
    consultoria:       'Consultoría',
}
</script>

<template>
    <AdminLayout>
        <template #header>Agenda</template>

        <div class="dash-welcome">
            <h1 class="dash-welcome__title">Agenda Global</h1>
            <button @click="abrirModal" class="dash-btn-primary">+ Agendar cita</button>
        </div>

        <div v-if="flashOk" class="flash-ok" style="margin-bottom:16px;">Cita creada correctamente</div>

        <div class="dash-cols" style="margin-bottom:20px;">

            <!-- CALENDARIO -->
            <div class="dash-panel">
                <div class="dash-panel__header" style="display:flex;align-items:center;justify-content:space-between;">
                    <button @click="prevMes" class="cal-nav-btn">‹</button>
                    <h3 class="dash-panel__title">{{ meses[mesActual] }} {{ anioActual }}</h3>
                    <button @click="nextMes" class="cal-nav-btn">›</button>
                </div>
                <div style="padding:16px;">
                    <div class="cal-grid-header">
                        <span v-for="d in diasNombre" :key="d" class="cal-day-name">{{ d }}</span>
                    </div>
                    <div class="cal-grid">
                        <div v-for="(dia, i) in diasDelMes()" :key="i"
                            :class="['cal-day',
                                dia === hoy.getDate() && mesActual === hoy.getMonth() && 'cal-day--hoy',
                                !dia && 'cal-day--vacio',
                                tieneCita(dia) && 'cal-day--cita'
                            ]">
                            {{ dia }}
                            <span v-if="tieneCita(dia)" class="cal-dot"></span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- STATS -->
            <div style="display:flex;flex-direction:column;gap:14px;">
                <div class="dash-card">
                    <p class="dash-card__label">Total citas</p>
                    <p class="dash-card__value">{{ citas.length }}</p>
                    <p class="dash-card__sub">Registradas en el sistema</p>
                </div>
                <div class="dash-card">
                    <p class="dash-card__label">Pendientes</p>
                    <p class="dash-card__value" style="color:#D4AF37;">{{ citas.filter(c => c.estado === 'pendiente').length }}</p>
                    <p class="dash-card__sub">Por confirmar</p>
                </div>
                <div class="dash-card">
                    <p class="dash-card__label">Confirmadas</p>
                    <p class="dash-card__value" style="color:#81c784;">{{ citas.filter(c => c.estado === 'confirmada').length }}</p>
                    <p class="dash-card__sub">Este mes</p>
                </div>
            </div>

        </div>

        <!-- TABLA -->
        <div class="dash-panel">
            <div class="dash-panel__header" style="display:flex;align-items:center;justify-content:space-between;flex-wrap:wrap;gap:10px;">
                <div style="display:flex;gap:6px;flex-wrap:wrap;">
                    <button v-for="f in ['todas','pendiente','confirmada','cancelada','completada']" :key="f"
                        @click="filtro = f"
                        :class="['filtro-tab', filtro === f && 'filtro-tab--active']">
                        {{ f.charAt(0).toUpperCase() + f.slice(1) }}
                    </button>
                </div>
                <input v-model="buscador" type="text" placeholder="Buscar cliente o motivo..." class="dash-search" style="width:220px;" />
            </div>

            <div v-if="citasFiltradas.length === 0" style="padding:40px 20px;text-align:center;">
                <p style="font-size:13px;color:var(--text-muted);">No hay citas con estos filtros</p>
            </div>

            <table v-else class="docs-table">
                <thead>
                    <tr>
                        <th>Fecha</th>
                        <th>Hora</th>
                        <th>Cliente</th>
                        <th>Motivo</th>
                        <th>Estado</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="cita in citasFiltradas" :key="cita.id">
                        <td>
                            <div style="display:inline-flex;flex-direction:column;align-items:center;background:rgba(212,175,55,.1);border:1px solid rgba(212,175,55,.2);border-radius:6px;padding:4px 10px;min-width:40px;">
                                <span style="font-family:var(--font-serif);font-size:16px;color:var(--gold);line-height:1;">{{ new Date(cita.fecha).getDate() }}</span>
                                <span style="font-size:9px;color:var(--text-muted);text-transform:uppercase;letter-spacing:.1em;">{{ mesesCortos[new Date(cita.fecha).getMonth()] }}</span>
                            </div>
                        </td>
                        <td style="color:var(--text-muted);font-size:12px;">{{ cita.time || '—' }}</td>
                        <td>
                            <p style="font-size:13px;color:#fff;">{{ cita.nombre }}</p>
                            <p style="font-size:11px;color:var(--text-muted);">{{ cita.email }}</p>
                            <p v-if="cita.es_invitado && cita.phone" style="font-size:11px;color:var(--text-dim);">{{ cita.phone }}</p>
                            <p v-if="cita.es_invitado" style="font-size:10px;color:var(--gold);letter-spacing:.06em;text-transform:uppercase;margin-top:3px;">Cliente Externo</p>
                        </td>
                        <td style="font-size:13px;color:var(--text-light);">{{ razonesLabel[cita.razon] ?? cita.razon }}</td>
                        <td>
                            <select
                                :value="cita.estado"
                                @change="cambiarEstado(cita, $event.target.value)"
                                class="estado-select"
                                :style="`color:${estadoColor[cita.estado]?.color};border-color:${estadoColor[cita.estado]?.color}44`">
                                <option value="pendiente">Pendiente</option>
                                <option value="confirmada">Confirmada</option>
                                <option value="cancelada">Cancelada</option>
                                <option value="completada">Completada</option>
                            </select>
                        </td>
                        <td>
                            <button @click="confirmarEliminar(cita)" class="btn-eliminar">Eliminar</button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

        <!-- MODAL NUEVA CITA -->
        <Teleport to="body">
            <div v-if="modalOpen" class="modal-backdrop" @click.self="cerrarModal">
                <div class="modal">
                    <div class="modal__header">
                        <div>
                            <h2 class="modal__title">Nueva Cita</h2>
                            <p style="font-size:12px;color:var(--text-muted);margin-top:3px;">Agenda una cita para un cliente</p>
                        </div>
                        <button @click="cerrarModal" class="modal__close">
                            <svg width="18" height="18" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12"/>
                            </svg>
                        </button>
                    </div>

                    <div class="modal__body">
                        <div style="display:flex;flex-direction:column;gap:14px;">

                            <div class="form-group">
                                <label class="form-label">Cliente *</label>
                                <select v-model="form.client_id" class="form-input modal-input"
                                    :class="{ 'form-input--error': form.errors.client_id }">
                                    <option value="" disabled>Selecciona un cliente</option>
                                    <option v-for="c in clientes" :key="c.id" :value="c.id">{{ c.name }}</option>
                                </select>
                                <span v-if="form.errors.client_id" class="form-error">{{ form.errors.client_id }}</span>
                            </div>

                            <div class="modal-form-grid">
                                <div class="form-group">
                                    <label class="form-label">Motivo *</label>
                                    <select v-model="form.reason" class="form-input modal-input"
                                        :class="{ 'form-input--error': form.errors.reason }">
                                        <option value="declaracion_renta">Declaración Renta</option>
                                        <option value="asesoria_fiscal">Asesoría Fiscal</option>
                                        <option value="contabilidad">Contabilidad</option>
                                        <option value="autonomos">Autónomos</option>
                                        <option value="sociedades">Sociedades</option>
                                        <option value="consultoria">Consultoría</option>
                                    </select>
                                    <span v-if="form.errors.reason" class="form-error">{{ form.errors.reason }}</span>
                                </div>
                                <div class="form-group">
                                    <label class="form-label">Fecha *</label>
                                    <input v-model="form.date" type="date" class="form-input modal-input"
                                        :class="{ 'form-input--error': form.errors.date }" />
                                    <span v-if="form.errors.date" class="form-error">{{ form.errors.date }}</span>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Hora *</label>
                                <input v-model="form.time" type="time" class="form-input modal-input"
                                    :class="{ 'form-input--error': form.errors.time }" />
                                <span v-if="form.errors.time" class="form-error">{{ form.errors.time }}</span>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Descripción</label>
                                <input v-model="form.description" type="text" class="form-input modal-input"
                                    placeholder="Notas adicionales (opcional)" />
                            </div>

                        </div>

                        <div class="modal__footer">
                            <button type="button" @click="cerrarModal" class="modal__btn-cancel">Cancelar</button>
                            <button @click="guardarCita" class="dash-btn-primary" :disabled="form.processing">
                                {{ form.processing ? 'Guardando...' : 'Crear cita' }}
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </Teleport>

        <!-- MODAL ELIMINAR -->
        <Teleport to="body">
            <div v-if="citaAEliminar" class="modal-backdrop" @click.self="cancelarEliminar">
                <div class="modal modal--confirm">
                    <div class="modal__icon">
                        <svg width="26" height="26" fill="none" stroke="#e57373" stroke-width="1.5" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v3.75m-9.303 3.376c-.866 1.5.217 3.374 1.948 3.374h14.71c1.73 0 2.813-1.874 1.948-3.374L13.949 3.378c-.866-1.5-3.032-1.5-3.898 0L2.697 16.126zM12 15.75h.007v.008H12v-.008z"/>
                        </svg>
                    </div>
                    <h3 class="modal__title">¿Eliminar cita?</h3>
                    <p class="modal__text">
                        Cita de <strong style="color:#fff;">{{ citaAEliminar.nombre }}</strong> —
                        {{ razonesLabel[citaAEliminar.razon] ?? citaAEliminar.razon }}.
                        Esta acción no se puede deshacer.
                    </p>
                    <div class="modal__actions">
                        <button @click="cancelarEliminar" class="modal__btn-cancel">Cancelar</button>
                        <button @click="eliminarCita" class="modal__btn-confirm">Sí, eliminar</button>
                    </div>
                </div>
            </div>
        </Teleport>

    </AdminLayout>
</template>