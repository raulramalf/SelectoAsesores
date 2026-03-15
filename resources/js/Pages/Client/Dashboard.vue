<script setup>
import ClientLayout from '@/Layouts/ClientLayout.vue'
import { Link, usePage } from '@inertiajs/vue3'
import { computed } from 'vue'

const page = usePage()
const user = computed(() => page.props.auth?.user)

const props = defineProps({
    proxima_cita:         { type: Object, default: null },
    stats:                { type: Object, default: () => ({}) },
    documentos_recientes: { type: Array,  default: () => [] },
    actividad:            { type: Array,  default: () => [] },
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

const tipoColor = {
    declaracion: '#D4AF37',
    contrato:    '#81c784',
    factura:     '#64b5f6',
    informe:     '#ba68c8',
    otro:        '#a0aabf',
}
</script>

<template>
    <ClientLayout>
        <template #header>Dashboard</template>

        <!-- BIENVENIDA -->
        <div class="dash-welcome">
            <div>
                <h1 class="dash-welcome__title">Hola, {{ user?.name }} 👋</h1>
                <p style="font-size:13px;color:var(--text-muted);margin-top:4px;">Bienvenido a tu área privada de Selecto Asesores</p>
            </div>
            <Link href="/reserva" class="dash-btn-primary">+ Nueva cita</Link>
        </div>

        <!-- STATS -->
        <div class="dash-grid" style="margin-bottom:24px;">
            <div class="dash-card">
                <p class="dash-card__label">Próxima cita</p>
                <p class="dash-card__value" style="font-size:20px;margin-top:4px;">
                    {{ proxima_cita ? proxima_cita.fecha : '—' }}
                </p>
                <p class="dash-card__sub">{{ proxima_cita ? (razonesLabel[proxima_cita.razon] ?? proxima_cita.razon) : 'Sin citas programadas' }}</p>
            </div>
            <div class="dash-card">
                <p class="dash-card__label">Total citas</p>
                <p class="dash-card__value">{{ stats.total_citas ?? 0 }}</p>
                <p class="dash-card__sub">Historial completo</p>
            </div>
            <div class="dash-card dash-card__gold">
                <p class="dash-card__label">Documentos</p>
                <p class="dash-card__value">{{ stats.documentos ?? 0 }}</p>
                <p class="dash-card__sub">Archivos en tu expediente</p>
            </div>
        </div>

        <!-- DOS COLUMNAS -->
        <div class="dash-cols">

            <!-- PRÓXIMA CITA -->
            <div class="dash-panel">
                <div class="dash-panel__header" style="display:flex;justify-content:space-between;align-items:center;">
                    <h3 class="dash-panel__title">Próxima Cita</h3>
                    <Link href="/dashboard/citas" style="font-size:11px;color:var(--gold);text-decoration:none;letter-spacing:.08em;">Ver todas →</Link>
                </div>

                <div v-if="!proxima_cita" style="padding:28px 20px;text-align:center;">
                    <p style="font-size:13px;color:var(--text-muted);margin-bottom:16px;">No tienes citas programadas</p>
                    <Link href="/reserva" class="dash-btn-primary" style="font-size:11px;">Solicitar primera cita</Link>
                </div>

                <div v-else style="padding:20px;">
                    <div style="display:flex;align-items:center;gap:16px;padding:16px;background:rgba(212,175,55,.06);border:1px solid rgba(212,175,55,.15);border-radius:8px;">
                        <div class="cita-item__fecha">
                            <span class="cita-item__dia">{{ proxima_cita.fecha?.split('/')[0] }}</span>
                            <span class="cita-item__mes">{{ ['Ene','Feb','Mar','Abr','May','Jun','Jul','Ago','Sep','Oct','Nov','Dic'][parseInt(proxima_cita.fecha?.split('/')[1]) - 1] }}</span>
                        </div>
                        <div style="flex:1;">
                            <p style="font-size:14px;color:#fff;font-weight:500;margin-bottom:4px;">{{ razonesLabel[proxima_cita.razon] ?? proxima_cita.razon }}</p>
                            <p style="font-size:12px;color:var(--text-muted);">{{ proxima_cita.time }} · Selecto Asesores</p>
                        </div>
                        <span class="cita-item__estado"
                            :style="`background:${estadoColor[proxima_cita.estado]?.bg};color:${estadoColor[proxima_cita.estado]?.color}`">
                            {{ proxima_cita.estado }}
                        </span>
                    </div>
                    <Link href="/dashboard/citas" style="display:block;text-align:center;margin-top:14px;font-size:11px;color:var(--text-muted);text-decoration:none;letter-spacing:.08em;text-transform:uppercase;transition:color .2s;"
                        onmouseover="this.style.color='#fff'" onmouseout="this.style.color=''">
                        Ver todas mis citas →
                    </Link>
                </div>
            </div>

            <!-- ACTIVIDAD RECIENTE -->
            <div class="dash-panel">
                <div class="dash-panel__header">
                    <h3 class="dash-panel__title">Actividad Reciente</h3>
                </div>

                <div v-if="!actividad.length" style="padding:28px 20px;text-align:center;">
                    <p style="font-size:13px;color:var(--text-muted);">Sin actividad todavía</p>
                </div>

                <div v-else class="dash-actividades">
                    <div v-for="(a, i) in actividad" :key="i" class="dash-actividad">
                        <div class="dash-actividad__dot" :style="a.tipo === 'documento' ? 'background:#64b5f6' : ''"></div>
                        <div class="dash-actividad__body">
                            <p class="dash-actividad__texto">{{ a.texto }}</p>
                            <p class="dash-actividad__fecha">{{ a.fecha }}</p>
                        </div>
                    </div>
                </div>
            </div>

        </div>

        <!-- DOCUMENTOS RECIENTES -->
        <div class="dash-panel" style="margin-top:20px;">
            <div class="dash-panel__header" style="display:flex;justify-content:space-between;align-items:center;">
                <h3 class="dash-panel__title">Documentos Recientes</h3>
                <Link href="/dashboard/documentos" style="font-size:11px;color:var(--gold);text-decoration:none;letter-spacing:.08em;">Ver todos →</Link>
            </div>

            <div v-if="!documentos_recientes.length" style="padding:32px 20px;text-align:center;">
                <p style="font-size:13px;color:var(--text-muted);">No hay documentos en tu expediente todavía</p>
                <p style="font-size:12px;color:var(--text-dim);margin-top:4px;">Tu asesor irá añadiendo los documentos aquí</p>
            </div>

            <table v-else class="docs-table">
                <thead>
                    <tr>
                        <th>Tipo</th>
                        <th>Nombre</th>
                        <th>Fecha</th>
                        <th>Acción</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="doc in documentos_recientes" :key="doc.id">
                        <td>
                            <span class="doc-tipo" :style="`color:${tipoColor[doc.tipo] || '#a0aabf'}`">{{ doc.tipo }}</span>
                        </td>
                        <td style="color:#fff;font-size:13px;">{{ doc.nombre }}</td>
                        <td style="color:var(--text-muted);font-size:12px;">{{ doc.fecha }}</td>
                        <td>
                            <a :href="`/storage/${doc.url}`" target="_blank" class="doc-btn-download">Ver</a>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

    </ClientLayout>
</template>