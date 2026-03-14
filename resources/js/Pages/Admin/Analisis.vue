<script setup>
import AdminLayout from '@/Layouts/AdminLayout.vue'
import { router } from '@inertiajs/vue3'
import { ref, onMounted, watch } from 'vue'
import { Chart, registerables } from 'chart.js'
Chart.register(...registerables)

const props = defineProps({
    anio:             { type: Number, default: new Date().getFullYear() },
    anios:            { type: Array,  default: () => [] },
    meses:            { type: Array,  default: () => [] },
    kpis:             { type: Object, default: () => ({}) },
    clientes_data:    { type: Array,  default: () => [] },
    completadas_data: { type: Array,  default: () => [] },
    canceladas_data:  { type: Array,  default: () => [] },
    servicios:        { type: Array,  default: () => [] },
})

const anioSeleccionado = ref(props.anio)

function cambiarAnio(anio) {
    anioSeleccionado.value = anio
    router.get('/admin/analisis', { anio }, { preserveState: false })
}

const razonesLabel = {
    declaracion_renta: 'Declaración Renta',
    asesoria_fiscal:   'Asesoría Fiscal',
    contabilidad:      'Contabilidad',
    autonomos:         'Autónomos',
    sociedades:        'Sociedades',
    consultoria:       'Consultoría',
}

// ─── CHART REFS ───────────────────────────────────────
const chartClientesRef   = ref(null)
const chartCitasRef      = ref(null)
const chartServiciosRef  = ref(null)

let chartClientes   = null
let chartCitas      = null
let chartServicios  = null

const GOLD       = '#D4AF37'
const GOLD_LIGHT = 'rgba(212,175,55,.15)'
const GREEN      = '#81c784'
const GREEN_BG   = 'rgba(129,199,132,.15)'
const RED        = '#e57373'
const RED_BG     = 'rgba(229,115,115,.15)'

function initCharts() {
    // Destruir anteriores
    chartClientes?.destroy()
    chartCitas?.destroy()
    chartServicios?.destroy()

    // 1. Clientes ganados por mes
    if (chartClientesRef.value) {
        chartClientes = new Chart(chartClientesRef.value, {
            type: 'bar',
            data: {
                labels: props.meses,
                datasets: [{
                    label: 'Clientes nuevos',
                    data: props.clientes_data,
                    backgroundColor: GOLD_LIGHT,
                    borderColor: GOLD,
                    borderWidth: 1.5,
                    borderRadius: 4,
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false },
                    tooltip: {
                        backgroundColor: '#0d1520',
                        borderColor: 'rgba(255,255,255,.08)',
                        borderWidth: 1,
                        titleColor: '#fff',
                        bodyColor: '#6a7a9a',
                        padding: 12,
                    }
                },
                scales: {
                    x: {
                        grid: { color: 'rgba(255,255,255,.04)' },
                        ticks: { color: '#6a7a9a', font: { size: 11 } },
                    },
                    y: {
                        grid: { color: 'rgba(255,255,255,.04)' },
                        ticks: { color: '#6a7a9a', font: { size: 11 }, stepSize: 1 },
                        beginAtZero: true,
                    }
                }
            }
        })
    }

    // 2. Citas completadas vs canceladas
    if (chartCitasRef.value) {
        chartCitas = new Chart(chartCitasRef.value, {
            type: 'line',
            data: {
                labels: props.meses,
                datasets: [
                    {
                        label: 'Completadas',
                        data: props.completadas_data,
                        borderColor: GREEN,
                        backgroundColor: GREEN_BG,
                        borderWidth: 2,
                        pointBackgroundColor: GREEN,
                        pointRadius: 4,
                        tension: 0.3,
                        fill: true,
                    },
                    {
                        label: 'Canceladas',
                        data: props.canceladas_data,
                        borderColor: RED,
                        backgroundColor: RED_BG,
                        borderWidth: 2,
                        pointBackgroundColor: RED,
                        pointRadius: 4,
                        tension: 0.3,
                        fill: true,
                    }
                ]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: true,
                        labels: { color: '#6a7a9a', font: { size: 11 }, boxWidth: 12 }
                    },
                    tooltip: {
                        backgroundColor: '#0d1520',
                        borderColor: 'rgba(255,255,255,.08)',
                        borderWidth: 1,
                        titleColor: '#fff',
                        bodyColor: '#6a7a9a',
                        padding: 12,
                    }
                },
                scales: {
                    x: {
                        grid: { color: 'rgba(255,255,255,.04)' },
                        ticks: { color: '#6a7a9a', font: { size: 11 } },
                    },
                    y: {
                        grid: { color: 'rgba(255,255,255,.04)' },
                        ticks: { color: '#6a7a9a', font: { size: 11 }, stepSize: 1 },
                        beginAtZero: true,
                    }
                }
            }
        })
    }

    // 3. Servicios más demandados (barras horizontales)
    if (chartServiciosRef.value && props.servicios.length) {
        chartServicios = new Chart(chartServiciosRef.value, {
            type: 'bar',
            data: {
                labels: props.servicios.map(s => razonesLabel[s.label] ?? s.label),
                datasets: [{
                    label: 'Solicitudes',
                    data: props.servicios.map(s => s.total),
                    backgroundColor: [
                        GOLD_LIGHT,
                        'rgba(129,199,132,.15)',
                        'rgba(100,181,246,.15)',
                        'rgba(186,104,200,.15)',
                        'rgba(255,183,77,.15)',
                        'rgba(229,115,115,.15)',
                    ],
                    borderColor: [
                        GOLD, GREEN, '#64b5f6', '#ba68c8', '#ffb74d', RED,
                    ],
                    borderWidth: 1.5,
                    borderRadius: 4,
                }]
            },
            options: {
                indexAxis: 'y',
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false },
                    tooltip: {
                        backgroundColor: '#0d1520',
                        borderColor: 'rgba(255,255,255,.08)',
                        borderWidth: 1,
                        titleColor: '#fff',
                        bodyColor: '#6a7a9a',
                        padding: 12,
                    }
                },
                scales: {
                    x: {
                        grid: { color: 'rgba(255,255,255,.04)' },
                        ticks: { color: '#6a7a9a', font: { size: 11 }, stepSize: 1 },
                        beginAtZero: true,
                    },
                    y: {
                        grid: { color: 'rgba(255,255,255,.04)' },
                        ticks: { color: '#6a7a9a', font: { size: 11 } },
                    }
                }
            }
        })
    }
}

onMounted(() => initCharts())
</script>

<template>
    <AdminLayout>
        <template #header>Análisis</template>

        <!-- CABECERA + FILTRO AÑO -->
        <div class="dash-welcome">
            <h1 class="dash-welcome__title">Análisis y Estadísticas</h1>
            <div style="display:flex;gap:6px;">
                <button v-for="a in anios" :key="a"
                    @click="cambiarAnio(a)"
                    :class="['filtro-tab', anioSeleccionado === a && 'filtro-tab--active']">
                    {{ a }}
                </button>
            </div>
        </div>

        <!-- KPI CARDS -->
        <div class="dash-grid" style="margin-bottom:24px;">
            <div class="dash-card dash-card__gold">
                <p class="dash-card__label">Clientes nuevos</p>
                <p class="dash-card__value">{{ kpis.clientes_anio ?? 0 }}</p>
                <p class="dash-card__sub">En {{ anioSeleccionado }}</p>
            </div>
            <div class="dash-card">
                <p class="dash-card__label">Citas totales</p>
                <p class="dash-card__value">{{ kpis.citas_anio ?? 0 }}</p>
                <p class="dash-card__sub">En {{ anioSeleccionado }}</p>
            </div>
            <div class="dash-card">
                <p class="dash-card__label">Citas completadas</p>
                <p class="dash-card__value" style="color:#81c784;">{{ kpis.completadas ?? 0 }}</p>
                <p class="dash-card__sub">Finalizadas con éxito</p>
            </div>
            <div class="dash-card">
                <p class="dash-card__label">Tasa de retención</p>
                <p class="dash-card__value" style="color:#D4AF37;">{{ kpis.tasa_retencion ?? 0 }}%</p>
                <p class="dash-card__sub">Clientes recurrentes</p>
            </div>
        </div>

        <!-- GRÁFICA 1 + GRÁFICA 2 -->
        <div class="dash-cols" style="margin-bottom:20px;">

            <div class="dash-panel">
                <div class="dash-panel__header" style="display:flex;justify-content:space-between;align-items:center;">
                    <h3 class="dash-panel__title">Clientes ganados por mes</h3>
                    <span style="font-size:11px;color:var(--text-dim);">{{ anioSeleccionado }}</span>
                </div>
                <div style="padding:20px;height:240px;">
                    <canvas ref="chartClientesRef"></canvas>
                </div>
            </div>

            <div class="dash-panel">
                <div class="dash-panel__header" style="display:flex;justify-content:space-between;align-items:center;">
                    <h3 class="dash-panel__title">Citas completadas vs canceladas</h3>
                    <span style="font-size:11px;color:var(--text-dim);">{{ anioSeleccionado }}</span>
                </div>
                <div style="padding:20px;height:240px;">
                    <canvas ref="chartCitasRef"></canvas>
                </div>
            </div>

        </div>

        <!-- GRÁFICA 3 + TASA RETENCIÓN -->
        <div class="dash-cols">

            <div class="dash-panel">
                <div class="dash-panel__header">
                    <h3 class="dash-panel__title">Servicios más demandados</h3>
                </div>
                <div style="padding:20px;height:240px;">
                    <canvas v-if="servicios.length" ref="chartServiciosRef"></canvas>
                    <div v-else style="height:100%;display:flex;align-items:center;justify-content:center;">
                        <p style="font-size:13px;color:var(--text-muted);">Sin datos todavía</p>
                    </div>
                </div>
            </div>

            <div class="dash-panel">
                <div class="dash-panel__header">
                    <h3 class="dash-panel__title">Resumen de retención</h3>
                </div>
                <div style="padding:28px 24px;display:flex;flex-direction:column;gap:20px;">

                    <div>
                        <div style="display:flex;justify-content:space-between;margin-bottom:8px;">
                            <span style="font-size:12px;color:var(--text-muted);">Clientes recurrentes</span>
                            <span style="font-size:12px;color:var(--gold);">{{ kpis.tasa_retencion }}%</span>
                        </div>
                        <div style="height:6px;background:rgba(255,255,255,.05);border-radius:100px;overflow:hidden;">
                            <div :style="`width:${kpis.tasa_retencion}%;height:100%;background:var(--gold);border-radius:100px;transition:width .6s;`"></div>
                        </div>
                    </div>

                    <div>
                        <div style="display:flex;justify-content:space-between;margin-bottom:8px;">
                            <span style="font-size:12px;color:var(--text-muted);">Citas completadas</span>
                            <span style="font-size:12px;color:#81c784;">
                                {{ kpis.citas_anio > 0 ? Math.round((kpis.completadas / kpis.citas_anio) * 100) : 0 }}%
                            </span>
                        </div>
                        <div style="height:6px;background:rgba(255,255,255,.05);border-radius:100px;overflow:hidden;">
                            <div :style="`width:${kpis.citas_anio > 0 ? Math.round((kpis.completadas / kpis.citas_anio) * 100) : 0}%;height:100%;background:#81c784;border-radius:100px;transition:width .6s;`"></div>
                        </div>
                    </div>

                    <div style="margin-top:8px;padding-top:20px;border-top:1px solid var(--border);">
                        <div class="dash-card__label" style="margin-bottom:12px;">Distribución de citas {{ anioSeleccionado }}</div>
                        <div v-for="s in servicios.slice(0,4)" :key="s.label" style="display:flex;align-items:center;justify-content:space-between;margin-bottom:8px;">
                            <span style="font-size:12px;color:var(--text-light);">{{ razonesLabel[s.label] ?? s.label }}</span>
                            <span style="font-size:12px;color:var(--text-muted);font-weight:500;">{{ s.total }}</span>
                        </div>
                        <div v-if="!servicios.length" style="text-align:center;padding:16px 0;">
                            <p style="font-size:12px;color:var(--text-dim);">Sin datos todavía</p>
                        </div>
                    </div>

                </div>
            </div>

        </div>

    </AdminLayout>
</template>