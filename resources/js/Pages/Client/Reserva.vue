<script setup>
import ClientLayout from '@/Layouts/ClientLayout.vue'
import { useForm, usePage, Link } from '@inertiajs/vue3'
import { computed } from 'vue'

const page = usePage()
const flashOk = computed(() => page.props.flash?.status === 'cita-solicitada')

const form = useForm({
    reason:      'declaracion_renta',
    date:        '',
    time:        '10:00',
    description: '',
})

function submit() {
    form.post(route('client.reserva.store'))
}

const razones = [
    { value: 'declaracion_renta', label: 'Declaración de la Renta' },
    { value: 'asesoria_fiscal',   label: 'Asesoría Fiscal' },
    { value: 'contabilidad',      label: 'Contabilidad' },
    { value: 'autonomos',         label: 'Autónomos' },
    { value: 'sociedades',        label: 'Sociedades' },
    { value: 'consultoria',       label: 'Consultoría General' },
]

const horarios = [
    '09:00','09:30','10:00','10:30','11:00','11:30',
    '12:00','12:30','13:00','16:00','16:30','17:00','17:30','18:00'
]

const hoy = new Date().toISOString().split('T')[0]
</script>

<template>
    <ClientLayout>
        <template #header>Solicitar Cita</template>

        <div class="dash-welcome">
            <div>
                <h1 class="dash-welcome__title">Solicitar Cita</h1>
                <p style="font-size:13px;color:var(--text-muted);margin-top:4px;">Selecciona el servicio, fecha y hora que prefieras</p>
            </div>
            <Link href="/dashboard/citas" style="font-size:11px;color:var(--text-muted);text-decoration:none;letter-spacing:.08em;text-transform:uppercase;transition:color .2s;"
                onmouseover="this.style.color='#fff'" onmouseout="this.style.color=''">
                ← Volver a mis citas
            </Link>
        </div>

        <div v-if="flashOk" class="flash-ok" style="margin-bottom:20px;">
            ¡Cita solicitada correctamente! Nos pondremos en contacto contigo para confirmarla.
        </div>

        <div class="dash-cols">

            <!-- FORMULARIO -->
            <div class="dash-panel" style="grid-column: span 1;">
                <div class="dash-panel__header">
                    <h3 class="dash-panel__title">Datos de la cita</h3>
                </div>
                <div style="padding:28px 24px;">
                    <form @submit.prevent="submit" class="appointment-form">

                        <div class="form-group">
                            <label class="form-label">Servicio *</label>
                            <select v-model="form.reason" class="form-input"
                                :class="{ 'form-input--error': form.errors.reason }">
                                <option v-for="r in razones" :key="r.value" :value="r.value">{{ r.label }}</option>
                            </select>
                            <span v-if="form.errors.reason" class="form-error">{{ form.errors.reason }}</span>
                        </div>

                        <div class="form-group">
                            <label class="form-label">Fecha *</label>
                            <input v-model="form.date" type="date" class="form-input"
                                :min="hoy"
                                :class="{ 'form-input--error': form.errors.date }" />
                            <span v-if="form.errors.date" class="form-error">{{ form.errors.date }}</span>
                        </div>

                        <div class="form-group">
                            <label class="form-label">Hora preferida *</label>
                            <select v-model="form.time" class="form-input"
                                :class="{ 'form-input--error': form.errors.time }">
                                <option v-for="h in horarios" :key="h" :value="h">{{ h }}</option>
                            </select>
                            <span v-if="form.errors.time" class="form-error">{{ form.errors.time }}</span>
                        </div>

                        <div class="form-group">
                            <label class="form-label">Descripción adicional</label>
                            <textarea v-model="form.description"
                                class="form-input"
                                style="resize:vertical;min-height:100px;"
                                placeholder="Describe brevemente tu consulta o lo que necesitas..."></textarea>
                        </div>

                        <button type="submit" class="form-submit" :disabled="form.processing">
                            {{ form.processing ? 'Enviando...' : 'Solicitar cita' }}
                        </button>

                    </form>
                </div>
            </div>

            <!-- INFO -->
            <div style="display:flex;flex-direction:column;gap:16px;">

                <div class="dash-panel">
                    <div class="dash-panel__header">
                        <h3 class="dash-panel__title">¿Cómo funciona?</h3>
                    </div>
                    <div style="padding:20px 24px;display:flex;flex-direction:column;gap:16px;">
                        <div style="display:flex;gap:14px;align-items:flex-start;">
                            <div style="width:28px;height:28px;border-radius:50%;background:rgba(212,175,55,.1);border:1px solid rgba(212,175,55,.2);display:flex;align-items:center;justify-content:center;flex-shrink:0;font-family:var(--font-serif);font-size:13px;color:var(--gold);">1</div>
                            <div>
                                <p style="font-size:13px;color:#fff;margin-bottom:2px;">Solicita tu cita</p>
                                <p style="font-size:11px;color:var(--text-muted);">Selecciona el servicio, fecha y hora</p>
                            </div>
                        </div>
                        <div style="display:flex;gap:14px;align-items:flex-start;">
                            <div style="width:28px;height:28px;border-radius:50%;background:rgba(212,175,55,.1);border:1px solid rgba(212,175,55,.2);display:flex;align-items:center;justify-content:center;flex-shrink:0;font-family:var(--font-serif);font-size:13px;color:var(--gold);">2</div>
                            <div>
                                <p style="font-size:13px;color:#fff;margin-bottom:2px;">Confirmación</p>
                                <p style="font-size:11px;color:var(--text-muted);">Tu asesor confirmará la cita en menos de 24h</p>
                            </div>
                        </div>
                        <div style="display:flex;gap:14px;align-items:flex-start;">
                            <div style="width:28px;height:28px;border-radius:50%;background:rgba(212,175,55,.1);border:1px solid rgba(212,175,55,.2);display:flex;align-items:center;justify-content:center;flex-shrink:0;font-family:var(--font-serif);font-size:13px;color:var(--gold);">3</div>
                            <div>
                                <p style="font-size:13px;color:#fff;margin-bottom:2px;">Reunión</p>
                                <p style="font-size:11px;color:var(--text-muted);">Presencial en nuestra oficina o videollamada</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="dash-panel">
                    <div class="dash-panel__header">
                        <h3 class="dash-panel__title">Horario de atención</h3>
                    </div>
                    <div style="padding:16px 24px;display:flex;flex-direction:column;gap:10px;">
                        <div style="display:flex;justify-content:space-between;">
                            <span style="font-size:12px;color:var(--text-muted);">Lunes — Viernes</span>
                            <span style="font-size:12px;color:#fff;">9:00 — 14:00 / 16:00 — 18:00</span>
                        </div>
                        <div style="display:flex;justify-content:space-between;">
                            <span style="font-size:12px;color:var(--text-muted);">Sábado</span>
                            <span style="font-size:12px;color:var(--text-dim);">Cerrado</span>
                        </div>
                        <div style="display:flex;justify-content:space-between;">
                            <span style="font-size:12px;color:var(--text-muted);">Domingo</span>
                            <span style="font-size:12px;color:var(--text-dim);">Cerrado</span>
                        </div>
                    </div>
                </div>

            </div>

        </div>

    </ClientLayout>
</template>