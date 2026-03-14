<script setup>
import AdminLayout from '@/Layouts/AdminLayout.vue'
import { Link } from '@inertiajs/vue3'

const props = defineProps({
    cliente: { type: Object, required: true }
})

const estadoColor = {
    pendiente:  { bg: 'rgba(212,175,55,.15)',  color: '#D4AF37' },
    confirmada: { bg: 'rgba(129,199,132,.15)', color: '#81c784' },
    cancelada:  { bg: 'rgba(229,115,115,.15)', color: '#e57373' },
}

const meses = ['Ene','Feb','Mar','Abr','May','Jun','Jul','Ago','Sep','Oct','Nov','Dic']
</script>

<template>
    <AdminLayout>
        <template #header>Detalle de cliente</template>

        <!-- VOLVER -->
        <div style="margin-bottom:24px;">
            <Link href="/admin/clientes"
                style="display:inline-flex;align-items:center;gap:6px;font-size:11px;color:var(--text-muted);text-decoration:none;letter-spacing:.1em;text-transform:uppercase;transition:color .2s;"
                onmouseover="this.style.color='#fff'" onmouseout="this.style.color=''">
                <svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M10.5 19.5L3 12m0 0l7.5-7.5M3 12h18"/>
                </svg>
                Volver a clientes
            </Link>
        </div>

        <!-- TARJETA PRINCIPAL -->
        <div class="cliente-hero">

            <!-- IZQUIERDA: avatar + nombre -->
            <div class="cliente-hero__identity">
                <div class="cliente-hero__avatar">
                    <img v-if="cliente.avatar" :src="`/storage/${cliente.avatar}`" :alt="cliente.name" />
                    <span v-else>{{ cliente.name?.charAt(0) }}</span>
                </div>
                <div class="cliente-hero__info">
                    <span class="cliente-hero__badge">Cliente</span>
                    <h2 class="cliente-hero__name">{{ cliente.name }}</h2>
                    <p class="cliente-hero__since">Registrado el {{ cliente.created_at }}</p>
                </div>
            </div>

            <!-- DERECHA: datos de contacto -->
            <div class="cliente-hero__contact">
                <div class="cliente-hero__contact-item">
                    <div class="cliente-hero__contact-icon">
                        <svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M21.75 6.75v10.5a2.25 2.25 0 01-2.25 2.25h-15a2.25 2.25 0 01-2.25-2.25V6.75m19.5 0A2.25 2.25 0 0019.5 4.5h-15a2.25 2.25 0 00-2.25 2.25m19.5 0v.243a2.25 2.25 0 01-1.07 1.916l-7.5 4.615a2.25 2.25 0 01-2.36 0L3.32 8.91a2.25 2.25 0 01-1.07-1.916V6.75"/>
                        </svg>
                    </div>
                    <div>
                        <p class="cliente-hero__contact-label">Email</p>
                        <p class="cliente-hero__contact-value">{{ cliente.email }}</p>
                    </div>
                </div>

                <div class="cliente-hero__contact-item">
                    <div class="cliente-hero__contact-icon">
                        <svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M2.25 6.75c0 8.284 6.716 15 15 15h2.25a2.25 2.25 0 002.25-2.25v-1.372c0-.516-.351-.966-.852-1.091l-4.423-1.106c-.44-.11-.902.055-1.173.417l-.97 1.293c-.282.376-.769.542-1.21.38a12.035 12.035 0 01-7.143-7.143c-.162-.441.004-.928.38-1.21l1.293-.97c.363-.271.527-.734.417-1.173L6.963 3.102a1.125 1.125 0 00-1.091-.852H4.5A2.25 2.25 0 002.25 4.5v2.25z"/>
                        </svg>
                    </div>
                    <div>
                        <p class="cliente-hero__contact-label">Teléfono</p>
                        <p class="cliente-hero__contact-value">{{ cliente.phone || 'Sin teléfono' }}</p>
                    </div>
                </div>

                <div class="cliente-hero__contact-item">
                    <div class="cliente-hero__contact-icon">
                        <svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M3 13.125C3 12.504 3.504 12 4.125 12h2.25c.621 0 1.125.504 1.125 1.125v6.75C7.5 20.496 6.996 21 6.375 21h-2.25A1.125 1.125 0 013 19.875v-6.75zM9.75 8.625c0-.621.504-1.125 1.125-1.125h2.25c.621 0 1.125.504 1.125 1.125v11.25c0 .621-.504 1.125-1.125 1.125h-2.25a1.125 1.125 0 01-1.125-1.125V8.625zM16.5 4.125c0-.621.504-1.125 1.125-1.125h2.25C20.496 3 21 3.504 21 4.125v15.75c0 .621-.504 1.125-1.125 1.125h-2.25a1.125 1.125 0 01-1.125-1.125V4.125z"/>
                        </svg>
                    </div>
                    <div>
                        <p class="cliente-hero__contact-label">Citas totales</p>
                        <p class="cliente-hero__contact-value">{{ cliente.citas?.length ?? 0 }}</p>
                    </div>
                </div>

                <div class="cliente-hero__contact-item">
                    <div class="cliente-hero__contact-icon">
                        <svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 14.25v-2.625a3.375 3.375 0 00-3.375-3.375h-1.5A1.125 1.125 0 0113.5 7.125v-1.5a3.375 3.375 0 00-3.375-3.375H8.25m0 12.75h7.5m-7.5 3H12M10.5 2.25H5.625c-.621 0-1.125.504-1.125 1.125v17.25c0 .621.504 1.125 1.125 1.125h12.75c.621 0 1.125-.504 1.125-1.125V11.25a9 9 0 00-9-9z"/>
                        </svg>
                    </div>
                    <div>
                        <p class="cliente-hero__contact-label">Documentos</p>
                        <p class="cliente-hero__contact-value">{{ cliente.documentos?.length ?? 0 }}</p>
                    </div>
                </div>
            </div>

        </div>

        <!-- DOS COLUMNAS -->
        <div class="dash-cols" style="margin-top:20px;">

            <!-- CITAS -->
            <div class="dash-panel">
                <div class="dash-panel__header" style="display:flex;justify-content:space-between;align-items:center;">
                    <h3 class="dash-panel__title">Historial de citas</h3>
                    <span style="font-size:11px;color:var(--text-dim);">{{ cliente.citas?.length ?? 0 }} total</span>
                </div>

                <div v-if="!cliente.citas?.length" style="padding:32px 20px;text-align:center;">
                    <p style="font-size:13px;color:var(--text-muted);">Sin citas registradas</p>
                </div>

                <div v-else class="citas-lista">
                    <div v-for="cita in cliente.citas" :key="cita.id" class="cita-item">
                        <div class="cita-item__fecha">
                            <span class="cita-item__dia">{{ new Date(cita.date).getDate() }}</span>
                            <span class="cita-item__mes">{{ meses[new Date(cita.date).getMonth()] }}</span>
                        </div>
                        <div class="cita-item__info">
                            <p class="cita-item__razon">{{ cita.reason }}</p>
                            <p class="cita-item__hora">{{ cita.description || '—' }}</p>
                        </div>
                        <span class="cita-item__estado"
                            :style="`background:${estadoColor[cita.status]?.bg};color:${estadoColor[cita.status]?.color}`">
                            {{ cita.status ?? 'pendiente' }}
                        </span>
                    </div>
                </div>
            </div>

            <!-- DOCUMENTOS -->
            <div class="dash-panel">
                <div class="dash-panel__header" style="display:flex;justify-content:space-between;align-items:center;">
                    <h3 class="dash-panel__title">Documentos</h3>
                    <span style="font-size:11px;color:var(--text-dim);">{{ cliente.documentos?.length ?? 0 }} total</span>
                </div>

                <div v-if="!cliente.documentos?.length" style="padding:32px 20px;text-align:center;">
                    <p style="font-size:13px;color:var(--text-muted);">Sin documentos</p>
                </div>

                <table v-else class="docs-table">
                    <thead>
                        <tr>
                            <th>Nombre</th>
                            <th>Tipo</th>
                            <th>Fecha</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="doc in cliente.documentos" :key="doc.id">
                            <td style="font-size:13px;color:#fff;">{{ doc.name }}</td>
                            <td style="font-size:11px;color:var(--text-muted);">{{ doc.type }}</td>
                            <td style="font-size:12px;color:var(--text-muted);">{{ doc.created_at }}</td>
                        </tr>
                    </tbody>
                </table>
            </div>

        </div>

    </AdminLayout>
</template>