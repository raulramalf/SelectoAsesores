<script setup>
import AdminLayout from '@/Layouts/AdminLayout.vue'
import { ref } from 'vue'

defineProps({
    documentos: { type: Array, default: () => [] }
})

const filtro = ref('Todos')
const filtros = ['Todos', 'Contrato', 'Factura', 'Declaración']
</script>

<template>
    <AdminLayout>
        <template #header>Gestión Documental</template>

        <div class="dash-welcome">
            <h1 class="dash-welcome__title">Documentos Globales</h1>
            <button class="dash-btn-primary">+ Subir Documento</button>
        </div>

        <div class="dash-panel" style="margin-bottom:20px;">
            <div style="padding:14px 20px;display:flex;gap:6px;flex-wrap:wrap;">
                <button v-for="f in filtros" :key="f" @click="filtro = f" :class="['filtro-tab', filtro === f && 'filtro-tab--active']">
                    {{ f }}
                </button>
            </div>
        </div>

        <div class="dash-panel">
            <div class="dash-panel__header">
                <h3 class="dash-panel__title">Archivos de Clientes</h3>
            </div>
            <div style="padding:48px 20px;text-align:center;">
                <p style="font-size:13px;color:var(--text-muted);">No hay documentos subidos actualmente.</p>
            </div>
        </div>
    </AdminLayout>
</template>