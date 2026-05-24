<script setup>
import AdminLayout from '@/Layouts/AdminLayout.vue'
import { Link, usePage, router } from '@inertiajs/vue3'
import { computed } from 'vue'
import axios from 'axios'

const page = usePage()
const user = computed(() => page.props.auth?.user)

const props = defineProps({
    stats:           { type: Object, default: () => ({}) },
    solicitudes:     { type: Array,  default: () => [] },
    proximas_citas:  { type: Array,  default: () => [] },
    recent_messages: { type: Array,  default: () => [] },
    actividad:       { type: Array,  default: () => [] },
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

const enviarPropuesta = async (mensaje) => {
    const fecha = prompt("Introduce la fecha de la cita (AAAA-MM-DD):", new Date().toLocaleDateString('sv-SE'));
    const hora = prompt("Introduce la hora (HH:MM):", "10:00");

    if (fecha && hora) {
        try {
            await axios.post('/admin/citas', {
                guest_name: mensaje.name,
                guest_email: mensaje.email,
                guest_phone: mensaje.phone,
                date: fecha,
                time: hora,
                reason: mensaje.subject,
                description: mensaje.message
            });
            alert("Cita guardada y agendada con éxito.");
            router.reload({ preserveScroll: true });
        } catch (error) {
            console.error(error);
            alert("Error al almacenar la cita.");
        }
    }
};

const eliminarMensaje = (id) => {
    if (confirm('¿Estás seguro de que deseas eliminar este mensaje de contacto definitivamente de Supabase?')) {
        router.delete(route('admin.contacto.destroy', id), {
            preserveScroll: true
        });
    }
};

const tipoIcon = {
    cita:      'M6.75 3v2.25M17.25 3v2.25M3 18.75V7.5a2.25 2.25 0 012.25-2.25h13.5A2.25 2.25 0 0121 7.5v11.25',
    documento: 'M19.5 14.25v-2.625a3.375 3.375 0 00-3.375-3.375h-1.5A1.125 1.125 0 0113.5 7.125v-1.5a3.375 3.375 0 00-3.375-3.375H8.25m0 12.75h7.5m-7.5 3H12',
    cliente:   'M15.75 6a3.75 3.75 0 11-7.5 0 3.75 3.75 0 017.5 0zM4.501 20.118a7.5 7.5 0 0114.998 0',
}
</script>

<template>
    <AdminLayout>
        <template #header>Dashboard</template>

        <div class="dash-welcome">
            <div>
                <h1 class="dash-welcome__title">Panel Administrador</h1>
                <p style="font-size:13px;color:var(--text-muted);margin-top:4px;">Bienvenido, {{ user?.name }}</p>
            </div>
        </div>

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

        <div class="dash-cols" style="margin-bottom:20px;">
            <div class="dash-panel">
                <div class="dash-panel__header" style="display:flex;justify-content:space-between;align-items:center;">
                    <h3 class="dash-panel__title">Solicitudes recientes</h3>
                    <Link href="/admin/citas" style="font-size:11px;color:var(--gold);text-decoration:none;letter-spacing:.08em;">Ver todas →</Link>
                </div>

                <div v-if="!solicitudes.length" style="padding:28px 20px;text-align:center;">
                    <p style="font-size:13px;color:var(--text-muted);">No hay solicitudes</p>
                </div>

                <div v-else class="dash-solicitudes">
                    <div v-for="s in solicitudes" :key="s.id" class="dash-solicitud" style="display: flex; align-items: center; justify-content: space-between; padding: 12px 16px; border-bottom: 1px solid rgba(255,255,255,0.02); gap: 12px;">
                        <div style="display: flex; align-items: center; gap: 12px; flex: 1; min-width: 0;">
                            <div class="dash-solicitud__icon" style="flex-shrink: 0; display: flex; align-items: center; justify-content: center; width: 28px; height: 28px; border-radius: 6px; background: rgba(212,175,55,0.08); border: 1px solid var(--border);">
                                <svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M6.75 3v2.25M17.25 3v2.25M3 18.75V7.5a2.25 2.25 0 012.25-2.25h13.5A2.25 2.25 0 0121 7.5v11.25"/>
                                </svg>
                            </div>
                            <div style="flex: 1; min-width: 0;">
                                <p class="dash-solicitud__texto" style="font-weight: 500; color: var(--text-main); margin: 0; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">{{ s.nombre }}</p>
                                <p style="font-size:11px;color:var(--text-dim); margin: 2px 0 0 0; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">{{ razonesLabel[s.texto] ?? s.texto ?? 'Consulta' }} · {{ s.fecha }}</p>
                            </div>
                        </div>
                        <span class="dash-solicitud__estado"
                            :style="`background:${estadoColor[s.estado]?.bg};color:${estadoColor[s.estado]?.color}; padding: 4px 8px; border-radius: 4px; font-size: 11px; text-transform: capitalize; font-weight: 500; flex-shrink: 0;`">
                            {{ s.estado }}
                        </span>
                    </div>
                </div>
            </div>

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
                            <p class="cita-item__hora">{{ razonesLabel[cita.razon] ?? cita.razon ?? 'Asesoría' }} · {{ cita.time }}</p>
                        </div>
                        <span class="cita-item__estado"
                            :style="`background:${estadoColor[cita.estado]?.bg};color:${estadoColor[cita.estado]?.color}`">
                            {{ cita.estado }}
                        </span>
                    </div>
                </div>
            </div>
        </div>

        <div class="dash-panel" style="margin-bottom:24px;">
            <div class="dash-panel__header">
                <h3 class="dash-panel__title">Mensajes de Contacto Recientes</h3>
            </div>
            <div v-if="!recent_messages.length" style="padding:24px; text-align:center; color:var(--text-muted);">
                No hay mensajes de contacto en el sistema.
            </div>
            <div v-else style="overflow-x:auto; padding:0 20px 20px;">
                <table style="width:100%; text-align:left; border-collapse:collapse; font-size:13px;">
                    <thead>
                        <tr style="border-bottom:1px solid var(--border); color:var(--text-muted);">
                            <th style="padding:12px 8px;">Nombre</th>
                            <th style="padding:12px 8px;">Contacto</th>
                            <th style="padding:12px 8px;">Asunto</th>
                            <th style="padding:12px 8px;">Mensaje</th>
                            <th style="padding:12px 8px; text-align:center;">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="msg in recent_messages" :key="msg.id" style="border-bottom:1px solid rgba(255,255,255,0.03);">
                            <td style="padding:12px 8px; color:var(--text-main); font-weight:500;">{{ msg.name }}</td>
                            <td style="padding:12px 8px;">
                                <div style="color:var(--text-main);">{{ msg.email }}</div>
                                <div style="font-size:11px; color:var(--text-dim);">{{ msg.phone || '—' }}</div>
                            </td>
                            <td style="padding:12px 8px;">{{ msg.subject }}</td>
                            <td style="padding:12px 8px; color:var(--text-muted); max-width:250px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap;">{{ msg.message }}</td>
                            <td style="padding:12px 8px; text-align:center;">
                                <div style="display:flex; gap:6px; justify-content:center;">
                                    <button @click="enviarPropuesta(msg)" style="background:transparent; border:1px solid var(--gold); color:var(--gold); padding:4px 10px; border-radius:4px; cursor:pointer; font-size:11px;">CITAR</button>
                                    <button @click="eliminarMensaje(msg.id)" style="background:transparent; border:1px solid #e57373; color:#e57373; padding:4px 10px; border-radius:4px; cursor:pointer; font-size:11px;">ELIMINAR</button>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="dash-panel">
            <div class="dash-panel__header">
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