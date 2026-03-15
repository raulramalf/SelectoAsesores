<script setup>
import ClientLayout from '@/Layouts/ClientLayout.vue'
import { Link } from '@inertiajs/vue3'
import { ref, computed } from 'vue'

const props = defineProps({
    citas: { type: Array, default: () => [] }
})

const meses    = ['Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre']
const diasNomb = ['Lun','Mar','Mié','Jue','Vie','Sáb','Dom']
const hoy      = new Date()
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
    const d = []
    for (let i = 0; i < offset; i++) d.push(null)
    for (let i = 1; i <= ultimo.getDate(); i++) d.push(i)
    return d
}

function tieneCita(dia) {
    if (!dia) return false
    return props.citas.some(c => {
        if (!c.date) return false
        const d = new Date(c.date + 'T00:00:00')
        return d.getDate() === dia && d.getMonth() === mesActual.value && d.getFullYear() === anioActual.value
    })
}

function getDia(date) {
    if (!date) return '—'
    return new Date(date + 'T00:00:00').getDate()
}

function getMes(date) {
    if (!date) return '—'
    return meses[new Date(date + 'T00:00:00').getMonth()]?.slice(0, 3) ?? '—'
}

const filtro = ref('todas')
const citasFiltradas = computed(() =>
    props.citas.filter(c => filtro.value === 'todas' || c.status === filtro.value)
)

const estadoColor = {
    pendiente:  { bg: 'rgba(212,175,55,.15)',  color: '#D4AF37' },
    confirmada: { bg: 'rgba(129,199,132,.15)', color: '#81c784' },
    cancelada:  { bg: 'rgba(229,115,115,.15)', color: '#e57373' },
    completada: { bg: 'rgba(100,181,246,.15)', color: '#64b5f6' },
}

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
    <ClientLayout>
        <template #header>Mis Citas</template>

        <div class="dash-welcome">
            <h1 class="dash-welcome__title">Mis Citas</h1>
            <Link href="/dashboard/reserva" class="dash-btn-primary">+ Nueva cita</Link>
        </div>

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
                        <span v-for="d in diasNomb" :key="d" class="cal-day-name">{{ d }}</span>
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
                    <p class="dash-card__sub">En tu historial</p>
                </div>
                <div class="dash-card">
                    <p class="dash-card__label">Pendientes</p>
                    <p class="dash-card__value" style="color:#D4AF37;">{{ citas.filter(c => c.status === 'pendiente').length }}</p>
                    <p class="dash-card__sub">Por confirmar</p>
                </div>
                <div class="dash-card">
                    <p class="dash-card__label">Completadas</p>
                    <p class="dash-card__value" style="color:#81c784;">{{ citas.filter(c => c.status === 'completada').length }}</p>
                    <p class="dash-card__sub">Finalizadas</p>
                </div>
            </div>

        </div>

        <!-- LISTA -->
        <div class="dash-panel">
            <div class="dash-panel__header" style="display:flex;align-items:center;justify-content:space-between;flex-wrap:wrap;gap:10px;">
                <h3 class="dash-panel__title">Historial de citas</h3>
                <div style="display:flex;gap:6px;flex-wrap:wrap;">
                    <button v-for="f in ['todas','pendiente','confirmada','completada','cancelada']" :key="f"
                        @click="filtro = f"
                        :class="['filtro-tab', filtro === f && 'filtro-tab--active']">
                        {{ f.charAt(0).toUpperCase() + f.slice(1) }}
                    </button>
                </div>
            </div>

            <div v-if="citasFiltradas.length === 0" style="padding:36px 20px;text-align:center;">
                <p style="font-size:13px;color:var(--text-muted);margin-bottom:14px;">
                    {{ citas.length === 0 ? 'No tienes citas todavía' : 'No hay citas con este filtro' }}
                </p>
                <Link v-if="citas.length === 0" href="/dashboard/reserva" class="dash-btn-primary" style="font-size:11px;">
                    Solicitar primera cita
                </Link>
            </div>

            <div v-else class="citas-lista">
                <div v-for="cita in citasFiltradas" :key="cita.id" class="cita-item">
                    <div class="cita-item__fecha">
                        <span class="cita-item__dia">{{ getDia(cita.date) }}</span>
                        <span class="cita-item__mes">{{ getMes(cita.date) }}</span>
                    </div>
                    <div class="cita-item__info">
                        <p class="cita-item__razon">{{ razonesLabel[cita.reason] ?? cita.reason }}</p>
                        <p class="cita-item__hora">
                            {{ cita.time || '—' }}
                            <span v-if="cita.description" style="color:var(--text-dim);"> · {{ cita.description }}</span>
                        </p>
                    </div>
                    <span class="cita-item__estado"
                        :style="`background:${estadoColor[cita.status]?.bg};color:${estadoColor[cita.status]?.color}`">
                        {{ cita.status }}
                    </span>
                </div>
            </div>
        </div>

    </ClientLayout>
</template>