<script setup>
import AdminLayout from '@/Layouts/AdminLayout.vue'
import { ref } from 'vue'

defineProps({
    users: { type: Array, default: () => [] }
})

const buscador = ref('')
</script>

<template>
    <AdminLayout>
        <template #header>Directorio de Clientes</template>

        <div class="dash-welcome">
            <h1 class="dash-welcome__title">Cartera de Clientes</h1>
            <button class="dash-btn-primary">+ Nuevo Cliente</button>
        </div>

        <div class="dash-panel" style="margin-bottom:20px;">
            <div style="padding:14px 20px;display:flex;justify-content:flex-end;">
                <input v-model="buscador" type="text" placeholder="Buscar cliente..." class="dash-search" style="width:300px;" />
            </div>
        </div>

        <div class="dash-panel">
            <div class="dash-panel__header">
                <h3 class="dash-panel__title">Listado de Clientes</h3>
            </div>
            <div v-if="users.length === 0" style="padding:48px 20px;text-align:center;">
                <p style="font-size:13px;color:var(--text-muted);">Aún no hay clientes registrados.</p>
            </div>
            <table v-else class="docs-table">
                <thead>
                    <tr>
                        <th>Nombre</th>
                        <th>Email</th>
                        <th>Teléfono</th>
                        <th>Acción</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="user in users" :key="user.id">
                        <td style="color:#fff;font-size:13px;">{{ user.name }}</td>
                        <td style="color:var(--text-muted);font-size:13px;">{{ user.email }}</td>
                        <td style="color:var(--text-muted);font-size:13px;">{{ user.phone || 'N/A' }}</td>
                        <td>
                            <button class="doc-btn-download" style="background:transparent;border:1px solid var(--gold);color:var(--gold);">Ver Perfil</button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </AdminLayout>
</template>