<script setup>
import ClientLayout from '@/Layouts/ClientLayout.vue'
import { ref, computed } from 'vue'

const props = defineProps({
    documentos: { type: Array, default: () => [] }
})

const buscador = ref('')
const filtro   = ref('todos')
const filtros  = [
    { key: 'todos',       label: 'Todos' },
    { key: 'declaracion', label: 'Declaración' },
    { key: 'contrato',    label: 'Contrato' },
    { key: 'factura',     label: 'Factura' },
    { key: 'informe',     label: 'Informe' },
    { key: 'otro',        label: 'Otro' },
]

const tipoColor = {
    declaracion: '#D4AF37',
    contrato:    '#81c784',
    factura:     '#64b5f6',
    informe:     '#ba68c8',
    otro:        '#a0aabf',
}

function formatBytes(bytes) {
    if (!bytes) return '—'
    if (bytes < 1024) return bytes + ' B'
    if (bytes < 1048576) return (bytes / 1024).toFixed(1) + ' KB'
    return (bytes / 1048576).toFixed(1) + ' MB'
}

const documentosFiltrados = computed(() =>
    props.documentos.filter(d =>
        (filtro.value === 'todos' || d.tipo === filtro.value) &&
        (d.nombre?.toLowerCase().includes(buscador.value.toLowerCase()))
    )
)
</script>

<template>
    <ClientLayout>
        <template #header>Documentos</template>

        <div class="dash-welcome">
            <h1 class="dash-welcome__title">Mis Documentos</h1>
        </div>

        <!-- STATS -->
        <div class="dash-grid" style="margin-bottom:20px;">
            <div class="dash-card">
                <p class="dash-card__label">Total documentos</p>
                <p class="dash-card__value">{{ documentos.length }}</p>
                <p class="dash-card__sub">En tu expediente</p>
            </div>
            <div v-for="f in filtros.slice(1,4)" :key="f.key" class="dash-card">
                <p class="dash-card__label">{{ f.label }}</p>
                <p class="dash-card__value" :style="`color:${tipoColor[f.key]}`">
                    {{ documentos.filter(d => d.tipo === f.key).length }}
                </p>
                <p class="dash-card__sub">Archivos</p>
            </div>
        </div>

        <!-- FILTROS -->
        <div class="dash-panel" style="margin-bottom:16px;">
            <div style="padding:12px 18px;display:flex;align-items:center;justify-content:space-between;gap:12px;flex-wrap:wrap;">
                <div style="display:flex;gap:6px;flex-wrap:wrap;">
                    <button v-for="f in filtros" :key="f.key"
                        @click="filtro = f.key"
                        :class="['filtro-tab', filtro === f.key && 'filtro-tab--active']">
                        {{ f.label }}
                    </button>
                </div>
                <input v-model="buscador" type="text" placeholder="Buscar documento..." class="dash-search" style="width:200px;" />
            </div>
        </div>

        <!-- TABLA -->
        <div class="dash-panel">
            <div class="dash-panel__header">
                <h3 class="dash-panel__title">{{ documentosFiltrados.length }} documento{{ documentosFiltrados.length !== 1 ? 's' : '' }}</h3>
            </div>

            <div v-if="documentos.length === 0" style="padding:56px 20px;text-align:center;">
                <svg width="40" height="40" fill="none" stroke="var(--text-dim)" stroke-width="1" viewBox="0 0 24 24" style="margin:0 auto 16px;">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 14.25v-2.625a3.375 3.375 0 00-3.375-3.375h-1.5A1.125 1.125 0 0113.5 7.125v-1.5a3.375 3.375 0 00-3.375-3.375H8.25m0 12.75h7.5m-7.5 3H12M10.5 2.25H5.625c-.621 0-1.125.504-1.125 1.125v17.25c0 .621.504 1.125 1.125 1.125h12.75c.621 0 1.125-.504 1.125-1.125V11.25a9 9 0 00-9-9z"/>
                </svg>
                <p style="font-size:13px;color:var(--text-muted);margin-bottom:6px;">No hay documentos en tu expediente</p>
                <p style="font-size:12px;color:var(--text-dim);">Tu asesor irá añadiendo los archivos de tu caso aquí</p>
            </div>

            <div v-else-if="documentosFiltrados.length === 0" style="padding:32px 20px;text-align:center;">
                <p style="font-size:13px;color:var(--text-muted);">No hay documentos con este filtro</p>
            </div>

            <table v-else class="docs-table">
                <thead>
                    <tr>
                        <th>Tipo</th>
                        <th>Nombre</th>
                        <th>Descripción</th>
                        <th>Fecha</th>
                        <th>Tamaño</th>
                        <th>Acción</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="doc in documentosFiltrados" :key="doc.id">
                        <td>
                            <span class="doc-tipo" :style="`color:${tipoColor[doc.tipo] || '#a0aabf'}`">{{ doc.tipo }}</span>
                        </td>
                        <td style="color:#fff;font-size:13px;max-width:180px;">
                            <p style="white-space:nowrap;overflow:hidden;text-overflow:ellipsis;">{{ doc.nombre }}</p>
                        </td>
                        <td style="color:var(--text-muted);font-size:12px;max-width:160px;">
                            <p style="white-space:nowrap;overflow:hidden;text-overflow:ellipsis;">{{ doc.descripcion || '—' }}</p>
                        </td>
                        <td style="color:var(--text-muted);font-size:12px;">{{ doc.fecha }}</td>
                        <td style="color:var(--text-muted);font-size:12px;">{{ formatBytes(doc.size) }}</td>
                        <td>
                            <a :href="`/storage/${doc.url}`" target="_blank" class="doc-btn-download">Descargar</a>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

    </ClientLayout>
</template>