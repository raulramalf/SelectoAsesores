<script setup>
import AdminLayout from '@/Layouts/AdminLayout.vue'
import { Link, usePage } from '@inertiajs/vue3'
import { computed } from 'vue'

const page = usePage()
const user = computed(() => page.props.auth?.user)

const props = defineProps({
    stats:          { type: Object, default: () => ({}) },
    solicitudes:    { type: Array,  default: () => [] },
    proximas_citas: { type: Array,  default: () => [] },
    actividad:      { type: Array,  default: () => [] },
})

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

const tipoIcon = {
    cita:      'M6.75 3v2.25M17.25 3v2.25M3 18.75V7.5a2.25 2.25 0 012.25-2.25h13.5A2.25 2.25 0 0121 7.5v11.25',
    documento: 'M19.5 14.25v-2.625a3.375 3.375 0 00-3.375-3.375h-1.5A1.125 1.125 0 0113.5 7.125v-1.5a3.375 3.375 0 00-3.375-3.375H8.25m0 12.75h7.5m-7.5 3H12',
    cliente:   'M15.75 6a3.75 3.75 0 11-7.5 0 3.75 3.75 0 017.5 0zM4.501 20.118a7.5 7.5 0 0114.998 0',
}
</script>

<template>
    <AdminLayout>
        <template #header>Dashboard</template>

        <!-- BIENVENIDA -->
        <div class="dash-welcome">
            <div>
                <h1 class="dash-welcome__title">Panel Administrador</h1>
                <p style="font-size:13px;color:var(--text-muted);margin-top:4px;">Bienvenido, {{ user?.name }}</p>
            </div>
        </div>

        <!-- STATS -->
        <div class="dash-grid" style="margin-bottom:24px;">
            <div class="dash-card">
                <p class="dash-card__label">Clientes activos</p>
                <p class="dash-card__value">{{ stats.clientes ?? 0 }}</p>
                <p class="dash-card__sub">Total registrados</p>
            </div>
            <div class="dash-card">
                <p class="dash-card__label">Citas este mes</p>
                <p class="dash-card__value">{{ stats.citas ?? 0 }}</p>
                <p class="dash-card__sub">Programadas</p>
            </div>
            <div class="dash-card">
                <p class="dash-card__label">Documentos</p>
                <p class="dash-card__value">{{ stats.documentos ?? 0 }}</p>
                <p class="dash-card__sub">Subidos esta semana</p>
            </div>
            <div class="dash-card dash-card__gold">
                <p class="dash-card__label">Mensajes</p>
                <p class="dash-card__value">{{ stats.mensajes ?? 0 }}</p>
                <p class="dash-card__sub">Sin responder</p>
            </div>
        </div>

        <!-- DOS COLUMNAS -->
        <div class="dash-cols" style="margin-bottom:20px;">

            <!-- SOLICITUDES RECIENTES -->
            <div class="dash-panel">
                <div class="dash-panel__header" style="display:flex;justify-content:space-between;align-items:center;">
                    <h3 class="dash-panel__title">Solicitudes recientes</h3>
                    <Link href="/admin/citas" style="font-size:11px;color:var(--gold);text-decoration:none;letter-spacing:.08em;">Ver todas →</Link>
                </div>

                <div v-if="!solicitudes.length" style="padding:28px 20px;text-align:center;">
                    <p style="font-size:13px;color:var(--text-muted);">No hay solicitudes</p>
                </div>

                <div v-else class="dash-solicitudes">
                    <div v-for="s in solicitudes" :key="s.id" class="dash-solicitud">
                        <div class="dash-solicitud__icon">
                            <svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M6.75 3v2.25M17.25 3v2.25M3 18.75V7.5a2.25 2.25 0 012.25-2.25h13.5A2.25 2.25 0 0121 7.5v11.25"/>
                            </svg>
                        </div>
                        <div style="flex:1;min-width:0;">
                            <p class="dash-solicitud__texto">{{ s.nombre }}</p>
                            <p style="font-size:11px;color:var(--text-dim);">{{ razonesLabel[s.texto] ?? s.texto }} · {{ s.fecha }}</p>
                        </div>
                        <span class="dash-solicitud__estado"
                            :style="`background:${estadoColor[s.estado]?.bg};color:${estadoColor[s.estado]?.color}`">
                            {{ s.estado }}
                        </span>
                    </div>
                </div>
            </div>

            <!-- PRÓXIMAS CITAS -->
            <div class="dash-panel">
                <div class="dash-panel__header" style="display:flex;justify-content:space-between;align-items:center;">
                    <h3 class="dash-panel__title">Próximas citas</h3>
                    <Link href="/admin/citas" style="font-size:11px;color:var(--gold);text-decoration:none;letter-spacing:.08em;">Ver agenda →</Link>
                </div>

                <div v-if="!proximas_citas.length" style="padding:28px 20px;text-align:center;">
                    <p style="font-size:13px;color:var(--text-muted);">No hay citas próximas</p>
                </div>

                <div v-else class="citas-lista">
                    <div v-for="cita in proximas_citas" :key="cita.id" class="cita-item">
                        <div class="cita-item__fecha">
                            <span class="cita-item__dia">{{ cita.fecha?.split('/')[0] }}</span>
                            <span class="cita-item__mes">{{ ['Ene','Feb','Mar','Abr','May','Jun','Jul','Ago','Sep','Oct','Nov','Dic'][parseInt(cita.fecha?.split('/')[1]) - 1] }}</span>
                        </div>
                        <div class="cita-item__info">
                            <p class="cita-item__razon">{{ cita.nombre }}</p>
                            <p class="cita-item__hora">{{ razonesLabel[cita.razon] ?? cita.razon }} · {{ cita.time }}</p>
                        </div>
                        <span class="cita-item__estado"
                            :style="`background:${estadoColor[cita.estado]?.bg};color:${estadoColor[cita.estado]?.color}`">
                            {{ cita.estado }}
                        </span>
                    </div>
                </div>
            </div>

        </div>

        <!-- ACTIVIDAD RECIENTE -->
        <div class="dash-panel">
            <div class="dash-panel__header" style="display:flex;justify-content:space-between;align-items:center;">
                <h3 class="dash-panel__title">Actividad reciente</h3>
            </div>

            <div v-if="!actividad.length" style="padding:28px 20px;text-align:center;">
                <p style="font-size:13px;color:var(--text-muted);">Sin actividad reciente</p>
            </div>

            <div v-else class="dash-actividades">
                <div v-for="(a, i) in actividad" :key="i" class="dash-actividad">
                    <div style="width:28px;height:28px;border-radius:6px;background:rgba(212,175,55,.08);border:1px solid var(--border);display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                        <svg width="13" height="13" fill="none" stroke="var(--gold)" stroke-width="1.5" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" :d="tipoIcon[a.tipo]"/>
                        </svg>
                    </div>
                    <div class="dash-actividad__body">
                        <p class="dash-actividad__texto">{{ a.texto }}</p>
                        <p class="dash-actividad__fecha">{{ a.fecha }}</p>
                    </div>
                </div>
            </div>
        </div>

    </AdminLayout>
</template>