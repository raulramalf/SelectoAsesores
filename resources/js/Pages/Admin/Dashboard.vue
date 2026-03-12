<script setup>
import AdminLayout from '@/Layouts/AdminLayout.vue'
import { Link, usePage } from '@inertiajs/vue3'
import { computed } from 'vue'

const page = usePage()
const user = computed(() => page.props.auth?.user)

const stats = [
    { label: 'Clientes Activos', value: '0', sub: 'En cartera' },
    { label: 'Citas Pendientes', value: '0', sub: 'Para esta semana', gold: true },
    { label: 'Documentos', value: '0', sub: 'Pendientes de revisión' },
]

const actividades = [
    { texto: 'Sesión iniciada correctamente', fecha: 'Hoy', tipo: 'info' },
]
</script>

<template>
    <AdminLayout>
        <template #header>Vista General</template>

        <div class="dash-welcome">
            <div>
                <h1 class="dash-welcome__title">Panel de Control, {{ user?.name }}</h1>
                <p style="font-size:13px;color:var(--text-muted);margin-top:4px;">Resumen de la actividad de tu despacho</p>
            </div>
            <Link href="/admin/clientes" class="dash-btn-primary">Ver Clientes</Link>
        </div>

        <div class="dash-grid" style="margin-bottom:24px;">
            <div v-for="stat in stats" :key="stat.label" :class="['dash-card', stat.gold && 'dash-card__gold']">
                <p class="dash-card__label">{{ stat.label }}</p>
                <p class="dash-card__value">{{ stat.value }}</p>
                <p class="dash-card__sub">{{ stat.sub }}</p>
            </div>
        </div>

        <div class="dash-cols">
            <div class="dash-panel">
                <div class="dash-panel__header" style="display:flex;justify-content:space-between;align-items:center;">
                    <h3 class="dash-panel__title">Próximas Citas (Global)</h3>
                    <Link href="/admin/citas" style="font-size:11px;color:var(--gold);text-decoration:none;letter-spacing:.08em;">Ver todas →</Link>
                </div>
                <div style="padding:24px 20px;text-align:center;">
                    <p style="font-size:13px;color:var(--text-muted);">No hay citas programadas por los clientes.</p>
                </div>
            </div>

            <div class="dash-panel">
                <div class="dash-panel__header">
                    <h3 class="dash-panel__title">Actividad Reciente</h3>
                </div>
                <div class="dash-actividades">
                    <div v-for="a in actividades" :key="a.texto" class="dash-actividad">
                        <div class="dash-actividad__dot" style="background:var(--gold);"></div>
                        <div class="dash-actividad__body">
                            <p class="dash-actividad__texto">{{ a.texto }}</p>
                            <p class="dash-actividad__fecha">{{ a.fecha }}</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </AdminLayout>
</template>