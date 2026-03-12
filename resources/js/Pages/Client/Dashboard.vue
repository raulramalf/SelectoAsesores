<script setup>
import ClientLayout from '@/Layouts/ClientLayout.vue'
import { Link, usePage } from '@inertiajs/vue3'
import { computed } from 'vue'

const page = usePage()
const user = computed(() => page.props.auth?.user)

const stats = [
    { label: 'Próxima cita', value: 'Sin citas', sub: 'No tienes citas programadas' },
    { label: 'Documentos', value: '0', sub: 'Archivos en tu expediente' },
    { label: 'Mensajes', value: '0', sub: 'Notificaciones sin leer', gold: true },
]

const actividades = [
    { texto: 'Bienvenido a tu área de cliente', fecha: 'Hoy', tipo: 'bienvenida' },
]
</script>

<template>
    <ClientLayout>
        <template #header>Dashboard</template>

        <!-- BIENVENIDA -->
        <div class="dash-welcome">
            <div>
                <h1 class="dash-welcome__title">Bienvenid@, {{ user?.name }} </h1>
                <p style="font-size:13px;color:var(--text-muted);margin-top:4px;">Bienvenido a tu área privada de Selecto Asesores</p>
            </div>
            <Link href="/reserva" class="dash-btn-primary">+ Nueva cita</Link>
        </div>

        <!-- STATS -->
        <div class="dash-grid" style="margin-bottom:24px;">
            <div v-for="stat in stats" :key="stat.label" :class="['dash-card', stat.gold && 'dash-card__gold']">
                <p class="dash-card__label">{{ stat.label }}</p>
                <p class="dash-card__value">{{ stat.value }}</p>
                <p class="dash-card__sub">{{ stat.sub }}</p>
            </div>
        </div>

        <!-- DOS COLUMNAS -->
        <div class="dash-cols">

            <!-- Próxima cita -->
            <div class="dash-panel">
                <div class="dash-panel__header" style="display:flex;justify-content:space-between;align-items:center;">
                    <h3 class="dash-panel__title">Próxima Cita</h3>
                    <Link href="/dashboard/citas" style="font-size:11px;color:var(--gold);text-decoration:none;letter-spacing:.08em;">Ver todas →</Link>
                </div>
                <div style="padding:24px 20px;text-align:center;">
                    <p style="font-size:13px;color:var(--text-muted);margin-bottom:16px;">No tienes citas programadas</p>
                    <Link href="/reserva" class="dash-btn-primary" style="font-size:11px;">Solicitar cita</Link>
                </div>
            </div>

            <!-- Actividad reciente -->
            <div class="dash-panel">
                <div class="dash-panel__header">
                    <h3 class="dash-panel__title">Actividades Recientes</h3>
                </div>
                <div class="dash-actividades">
                    <div v-for="a in actividades" :key="a.texto" class="dash-actividad">
                        <div class="dash-actividad__dot"></div>
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
            <div style="padding:32px 20px;text-align:center;">
                <p style="font-size:13px;color:var(--text-muted);">No hay documentos todavía</p>
            </div>
        </div>

    </ClientLayout>
</template>