<script setup>
import ClientLayout from '@/Layouts/ClientLayout.vue'
import { useForm } from '@inertiajs/vue3'
import { ref } from 'vue'

defineProps({
    documentos: { type: Array, default: () => [] }
})

const buscador = ref('')
const filtro = ref('Todos')
const filtros = ['Todos', 'Contrato', 'Factura', 'Declaración', 'Informe', 'Otro']

const tipoColor = {
    Contrato:    '#81c784',
    Factura:     '#64b5f6',
    Declaración: '#D4AF37',
    Informe:     '#ba68c8',
    Otro:        '#a0aabf',
}

function formatBytes(bytes) {
    if (!bytes) return '—'
    if (bytes < 1024) return bytes + ' B'
    if (bytes < 1048576) return (bytes / 1024).toFixed(1) + ' KB'
    return (bytes / 1048576).toFixed(1) + ' MB'
}
</script>

<template>
    <ClientLayout>
        <template #header>Documentos</template>

        <div class="dash-welcome">
            <h1 class="dash-welcome__title">Documentos</h1>
        </div>

        <!-- FILTROS Y BUSCADOR -->
        <div class="dash-panel" style="margin-bottom:20px;">
            <div style="padding:14px 20px;display:flex;align-items:center;justify-content:space-between;gap:16px;flex-wrap:wrap;">
                <div style="display:flex;gap:6px;flex-wrap:wrap;">
                    <button
                        v-for="f in filtros" :key="f"
                        @click="filtro = f"
                        :class="['filtro-tab', filtro === f && 'filtro-tab--active']">
                        {{ f }}
                    </button>
                </div>
                <div style="display:flex;gap:10px;align-items:center;">
                    <input v-model="buscador" type="text" placeholder="Buscar..." class="dash-search" style="width:180px;" />
                </div>
            </div>
        </div>

        <!-- DOCUMENTOS RECIENTES -->
        <div class="dash-panel" style="margin-bottom:20px;">
            <div class="dash-panel__header">
                <h3 class="dash-panel__title">Documentos Recientes</h3>
            </div>
            <div style="padding:16px 20px;display:flex;gap:12px;">
                <div v-if="documentos.length === 0" style="display:flex;gap:12px;">
                    <div v-for="n in 4" :key="n" class="doc-reciente-placeholder">
                        <p style="font-size:11px;color:var(--text-dim);">Doc{{ n }}</p>
                    </div>
                </div>
                <div v-else v-for="doc in documentos.slice(0,4)" :key="doc.id" class="doc-reciente">
                    <p style="font-size:11px;color:var(--text-light);text-align:center;">{{ doc.name }}</p>
                </div>
            </div>
        </div>

        <!-- TABLA -->
        <div class="dash-panel">
            <div class="dash-panel__header">
                <h3 class="dash-panel__title">Todos los documentos</h3>
            </div>

            <div v-if="documentos.length === 0" style="padding:48px 20px;text-align:center;">
                <p style="font-size:13px;color:var(--text-muted);">No hay documentos en tu expediente todavía</p>
                <p style="font-size:12px;color:var(--text-dim);margin-top:6px;">Tu asesor irá añadiendo los documentos de tu caso aquí</p>
            </div>

            <table v-else class="docs-table">
                <thead>
                    <tr>
                        <th>Tipo</th>
                        <th>Nombre</th>
                        <th>Fecha</th>
                        <th>Tamaño</th>
                        <th>Acción</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="doc in documentos" :key="doc.id">
                        <td>
                            <span class="doc-tipo" :style="`color:${tipoColor[doc.type] || '#a0aabf'}`">{{ doc.type }}</span>
                        </td>
                        <td style="color:#fff;font-size:13px;">{{ doc.name }}</td>
                        <td style="color:var(--text-muted);font-size:12px;">{{ doc.created_at }}</td>
                        <td style="color:var(--text-muted);font-size:12px;">{{ formatBytes(doc.size) }}</td>
                        <td>
                            <a :href="doc.url" target="_blank" class="doc-btn-download">Descargar</a>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

    </ClientLayout>
</template>