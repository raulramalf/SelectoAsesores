<script setup>
import AdminLayout from '@/Layouts/AdminLayout.vue'
</script>

<template>
    <AdminLayout>
        <template #header>Gestión de Citas</template>

        <div class="dash-welcome">
            <h1 class="dash-welcome__title">Agenda Global</h1>
            <button class="dash-btn-primary">+ Agendar Cita</button>
        </div>

        <div class="dash-panel">
            <div class="dash-panel__header">
                <h3 class="dash-panel__title">Citas Programadas</h3>
            </div>
            <div style="padding:48px 20px;text-align:center;">
                <p style="font-size:13px;color:var(--text-muted);">No hay citas para mostrar en este momento.</p>
            </div>
        </div>
    </AdminLayout>
</template>