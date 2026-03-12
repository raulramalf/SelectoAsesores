<script setup>
import AdminLayout from '@/Layouts/AdminLayout.vue'
</script>

<template>
    <AdminLayout>
        <template #header>Análisis y Estadísticas</template>

        <div class="dash-welcome">
            <h1 class="dash-welcome__title">Rendimiento del Despacho</h1>
        </div>

        <div class="dash-panel">
            <div class="dash-panel__header">
                <h3 class="dash-panel__title">Métricas Generales</h3>
            </div>
            <div style="padding:48px 20px;text-align:center;">
                <p style="font-size:13px;color:var(--text-muted);">Los gráficos estarán disponibles pronto.</p>
            </div>
        </div>
    </AdminLayout>
</template>