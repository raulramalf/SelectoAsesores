<script setup>
import AdminLayout from '@/Layouts/AdminLayout.vue'
import { usePage } from '@inertiajs/vue3'
import { computed } from 'vue'

const page = usePage()
const user = computed(() => page.props.auth?.user)

const stats = [
    { label: 'Clientes activos', value: '0', sub: 'Total registrados' },
    { label: 'Citas este mes', value: '0', sub: 'Pendientes de confirmar' },
    { label: 'Documentos', value: '0', sub: 'Subidos esta semana' },
    { label: 'Mensajes', value: '0', sub: 'Sin responder', gold: true },
]

const solicitudes = [
    { texto: 'Miércoles 1 de enero - Asesoría General', estado: 'Cancelado', color: '#e57373' },
    { texto: 'Solicitud Declaración de la renta Raúl', estado: 'Pendiente', color: '#D4AF37' },
    { texto: 'Solicitud de Correo Complementario', estado: 'Aceptado', color: '#81c784' },
    { texto: 'Adjuntar documentos, 9th All.Su', estado: 'Pendiente', color: '#D4AF37' },
]
</script>

<template>
    <AdminLayout>
        <template #header>Dashboard</template>

        <!-- BIENVENIDA -->
        <div class="dash-welcome">
            <h1 class="dash-welcome__title">Panel Administrador</h1>
            <div class="dash-welcome__actions">
                <input type="text" placeholder="Buscar..." class="dash-search" />
            </div>
        </div>

        <!-- STATS -->
        <div class="dash-grid">
            <div
                v-for="stat in stats"
                :key="stat.label"
                :class="['dash-card', stat.gold && 'dash-card__gold']"
            >
                <p class="dash-card__label">{{ stat.label }}</p>
                <p class="dash-card__value">{{ stat.value }}</p>
                <p class="dash-card__sub">{{ stat.sub }}</p>
            </div>
        </div>

        <!-- DOS COLUMNAS -->
        <div class="dash-cols">

            <!-- Overview -->
            <div class="dash-panel">
                <div class="dash-panel__header">
                    <h3 class="dash-panel__title">Overview</h3>
                </div>
                <div class="dash-chart-placeholder">
                    <p class="dash-chart-placeholder__text">Gráfica de actividad próximamente</p>
                </div>
            </div>

            <!-- Rendimiento clientes -->
            <div class="dash-panel">
                <div class="dash-panel__header">
                    <h3 class="dash-panel__title">Rendimiento Clientes</h3>
                </div>
                <div class="dash-chart-placeholder">
                    <p class="dash-chart-placeholder__text">Gráfica de rendimiento próximamente</p>
                </div>
            </div>

        </div>

        <!-- DOS COLUMNAS INFERIORES -->
        <div class="dash-cols" style="margin-top:20px;">

            <!-- Solicitudes -->
            <div class="dash-panel">
                <div class="dash-panel__header">
                    <h3 class="dash-panel__title">Solicitudes Principales</h3>
                </div>
                <div class="dash-solicitudes">
                    <div v-for="s in solicitudes" :key="s.texto" class="dash-solicitud">
                        <div class="dash-solicitud__icon">
                            <svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M6.75 3v2.25M17.25 3v2.25M3 18.75V7.5a2.25 2.25 0 012.25-2.25h13.5A2.25 2.25 0 0121 7.5v11.25"/>
                            </svg>
                        </div>
                        <p class="dash-solicitud__texto">{{ s.texto }}</p>
                        <span class="dash-solicitud__estado" :style="`background:${s.color}22;color:${s.color};`">{{ s.estado }}</span>
                    </div>
                </div>
            </div>

            <!-- Estado actual -->
            <div class="dash-panel">
                <div class="dash-panel__header">
                    <h3 class="dash-panel__title">Estado Actual</h3>
                </div>
                <div class="dash-chart-placeholder">
                    <p class="dash-chart-placeholder__text">Gráfico circular próximamente</p>
                </div>
            </div>

        </div>

    </AdminLayout>
</template>