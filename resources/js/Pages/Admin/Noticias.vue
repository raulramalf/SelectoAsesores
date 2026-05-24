<script setup>
import AdminLayout from '@/Layouts/AdminLayout.vue'
import { router } from '@inertiajs/vue3'
import { ref, computed } from 'vue'

const props = defineProps({ noticias: Array })
const filtro = ref('todos')

const noticiasFiltradas = computed(() => {
    if (filtro.value === 'pendientes') return props.noticias.filter(n => n.status === 'pending')
    if (filtro.value === 'aprobados') return props.noticias.filter(n => n.status === 'published')
    return props.noticias
})

const aprobar = (id) => router.patch(route('admin.noticias.aprobar', id))
const eliminar = (id) => { if(confirm('¿Eliminar noticia?')) router.delete(route('admin.noticias.destroy', id)) }
const vaciarTodo = () => { if(confirm('¿VACIAR TODO EL HISTORIAL?')) router.delete(route('admin.noticias.destroyAll')) }
</script>

<template>
    <AdminLayout>
        <template #header>Validación de Prensa Diaria</template>

        <div class="news-admin-header">
            <div class="header-content">
                <h1 class="page-title">Actualidad Fiscal</h1>
                <div class="custom-filter-bar">
                    <button @click="filtro = 'todos'" :class="{ active: filtro === 'todos' }">Todas</button>
                    <button @click="filtro = 'pendientes'" :class="{ active: filtro === 'pendientes' }">Pendientes</button>
                    <button @click="filtro = 'aprobados'" :class="{ active: filtro === 'aprobados' }">Aprobadas</button>
                </div>
            </div>
            <button @click="vaciarTodo" class="btn-clean-all">Vaciar Historial</button>
        </div>

        <div class="dash-panel">
            <table class="docs-table">
                <thead>
                    <tr>
                        <th>Noticia de Hoy</th>
                        <th>Fuente</th>
                        <th>Estado</th>
                        <th class="text-right">Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="n in noticiasFiltradas" :key="n.id">
                        <td>
                            <div class="title-stack">
                                <span class="main-title">{{ n.title }}</span>
                            </div>
                        </td>
                        <td>
                            <a :href="n.source_url" target="_blank" class="source-link">
                                {{ n.source }} ↗
                            </a>
                        </td>
                        <td>
                            <span :class="['status-tag', n.status]">
                                {{ n.status === 'published' ? 'PÚBLICO' : 'EN COLA' }}
                            </span>
                        </td>
                        <td class="text-right">
                            <div class="actions-group">
                                <button v-if="n.status === 'pending'" @click="aprobar(n.id)" class="dash-btn-primary btn-small">Aprobar</button>
                                <button @click="eliminar(n.id)" class="link-delete">Eliminar</button>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </AdminLayout>
</template>

<style scoped>
@import "../../../css/admin-news.css";
</style>