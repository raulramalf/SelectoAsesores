<script setup>
import ClientLayout from '@/Layouts/ClientLayout.vue'
import { Link } from '@inertiajs/vue3'
import { ref } from 'vue'

defineProps({
    citas: { type: Array, default: () => [] }
})

const meses = ['Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre']
const dias = ['Lun','Mar','Mié','Jue','Vie','Sáb','Dom']

const hoy = new Date()
const mesActual = ref(hoy.getMonth())
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
    const ultimo = new Date(anioActual.value, mesActual.value + 1, 0)
    const offset = (primero.getDay() + 6) % 7
    const dias = []
    for (let i = 0; i < offset; i++) dias.push(null)
    for (let i = 1; i <= ultimo.getDate(); i++) dias.push(i)
    return dias
}

const estadoColor = {
    pendiente: { bg: 'rgba(212,175,55,.15)', color: '#D4AF37' },
    confirmada: { bg: 'rgba(129,199,132,.15)', color: '#81c784' },
    cancelada:  { bg: 'rgba(229,115,115,.15)', color: '#e57373' },
}
</script>

<template>
    <ClientLayout>
        <template #header>Mis Citas</template>

        <div class="dash-welcome">
            <h1 class="dash-welcome__title">Mis Citas</h1>
            <Link href="/reserva" class="dash-btn-primary">+ Nueva cita</Link>
        </div>

        <div class="dash-cols">

            <!-- CALENDARIO -->
            <div class="dash-panel">
                <div class="dash-panel__header" style="display:flex;align-items:center;justify-content:space-between;">
                    <button @click="prevMes" class="cal-nav-btn">‹</button>
                    <h3 class="dash-panel__title">{{ meses[mesActual] }} {{ anioActual }}</h3>
                    <button @click="nextMes" class="cal-nav-btn">›</button>
                </div>
                <div style="padding:16px;">
                    <div class="cal-grid-header">
                        <span v-for="d in dias" :key="d" class="cal-day-name">{{ d }}</span>
                    </div>
                    <div class="cal-grid">
                        <div v-for="(dia, i) in diasDelMes()" :key="i"
                            :class="['cal-day', dia === hoy.getDate() && mesActual === hoy.getMonth() && 'cal-day--hoy', !dia && 'cal-day--vacio']">
                            {{ dia }}
                        </div>
                    </div>
                </div>
            </div>

            <!-- PRÓXIMAS CITAS -->
            <div class="dash-panel">
                <div class="dash-panel__header">
                    <h3 class="dash-panel__title">Próximas Citas</h3>
                </div>

                <div v-if="citas.length === 0" style="padding:32px 20px;text-align:center;">
                    <p style="font-size:13px;color:var(--text-muted);margin-bottom:16px;">No tienes citas programadas</p>
                    <Link href="/reserva" class="dash-btn-primary" style="font-size:11px;">Solicitar primera cita</Link>
                </div>

                <div v-else class="citas-lista">
                    <div v-for="cita in citas" :key="cita.id" class="cita-item">
                        <div class="cita-item__fecha">
                            <span class="cita-item__dia">{{ new Date(cita.date).getDate() }}</span>
                            <span class="cita-item__mes">{{ meses[new Date(cita.date).getMonth()].slice(0,3) }}</span>
                        </div>
                        <div class="cita-item__info">
                            <p class="cita-item__razon">{{ cita.reason }}</p>
                            <p class="cita-item__hora">{{ cita.time }}</p>
                        </div>
                        <span class="cita-item__estado"
                            :style="`background:${estadoColor[cita.status]?.bg};color:${estadoColor[cita.status]?.color}`">
                            {{ cita.status }}
                        </span>
                    </div>
                </div>
            </div>

        </div>

    </ClientLayout>
</template>