<script setup>
import ClientLayout from '@/Layouts/ClientLayout.vue'
import { useForm, usePage } from '@inertiajs/vue3'
import { computed } from 'vue'

const page = usePage()
const user = computed(() => page.props.auth?.user)

const formPerfil = useForm({
    name:  user.value?.name  || '',
    email: user.value?.email || '',
    phone: user.value?.phone || '',
})

const formPassword = useForm({
    current_password:      '',
    password:              '',
    password_confirmation: '',
})

function guardarPerfil() {
    formPerfil.patch(route('profile.update'))
}

function cambiarPassword() {
    formPassword.put(route('password.update'), {
        onSuccess: () => formPassword.reset(),
    })
}
</script>

<template>
    <ClientLayout>
        <template #header>Mi Perfil</template>

        <div class="dash-welcome">
            <h1 class="dash-welcome__title">Mi Perfil</h1>
        </div>

        <div class="dash-cols">

            <!-- DATOS PERSONALES -->
            <div class="dash-panel">
                <div class="dash-panel__header">
                    <h3 class="dash-panel__title">Datos Personales</h3>
                </div>
                <div style="padding:28px 24px;">

                    <!-- Avatar -->
                    <div style="display:flex;align-items:center;gap:16px;margin-bottom:28px;">
                        <div class="perfil-avatar">{{ user?.name?.charAt(0) }}</div>
                        <div>
                            <p style="font-size:14px;color:#fff;font-weight:500;">{{ user?.name }}</p>
                            <p style="font-size:12px;color:var(--text-muted);">Cliente</p>
                        </div>
                    </div>

                    <form @submit.prevent="guardarPerfil" class="appointment-form">
                        <div class="form-group">
                            <label class="form-label">Nombre</label>
                            <input v-model="formPerfil.name" type="text" class="form-input" />
                            <span v-if="formPerfil.errors.name" class="form-error">{{ formPerfil.errors.name }}</span>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Email</label>
                            <input v-model="formPerfil.email" type="email" class="form-input" />
                            <span v-if="formPerfil.errors.email" class="form-error">{{ formPerfil.errors.email }}</span>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Teléfono</label>
                            <input v-model="formPerfil.phone" type="tel" class="form-input" placeholder="600 000 000" />
                        </div>
                        <button type="submit" class="form-submit" :disabled="formPerfil.processing">
                            Guardar Cambios
                        </button>
                    </form>
                </div>
            </div>

            <!-- SEGURIDAD -->
            <div style="display:flex;flex-direction:column;gap:20px;">
                <div class="dash-panel">
                    <div class="dash-panel__header">
                        <h3 class="dash-panel__title">Seguridad</h3>
                    </div>
                    <div style="padding:28px 24px;">
                        <form @submit.prevent="cambiarPassword" class="appointment-form">
                            <div class="form-group">
                                <label class="form-label">Contraseña actual</label>
                                <input v-model="formPassword.current_password" type="password" class="form-input" placeholder="••••••••" />
                                <span v-if="formPassword.errors.current_password" class="form-error">{{ formPassword.errors.current_password }}</span>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Nueva contraseña</label>
                                <input v-model="formPassword.password" type="password" class="form-input" placeholder="••••••••" />
                                <span v-if="formPassword.errors.password" class="form-error">{{ formPassword.errors.password }}</span>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Confirmar contraseña</label>
                                <input v-model="formPassword.password_confirmation" type="password" class="form-input" placeholder="••••••••" />
                            </div>
                            <button type="submit" class="form-submit" :disabled="formPassword.processing">
                                Guardar Cambios
                            </button>
                        </form>
                    </div>
                </div>

                <div class="dash-panel">
                    <div class="dash-panel__header">
                        <h3 class="dash-panel__title">Preferencias de Notificaciones</h3>
                    </div>
                    <div style="padding:20px 24px;display:flex;flex-direction:column;gap:14px;">
                        <div class="notif-row">
                            <div>
                                <p style="font-size:13px;color:#fff;">Recordatorio de citas</p>
                                <p style="font-size:11px;color:var(--text-muted);">24h antes de cada cita</p>
                            </div>
                            <div class="toggle toggle--on"></div>
                        </div>
                        <div class="notif-row">
                            <div>
                                <p style="font-size:13px;color:#fff;">Nuevos documentos</p>
                                <p style="font-size:11px;color:var(--text-muted);">Cuando tu asesor suba archivos</p>
                            </div>
                            <div class="toggle toggle--on"></div>
                        </div>
                        <div class="notif-row">
                            <div>
                                <p style="font-size:13px;color:#fff;">Novedades fiscales</p>
                                <p style="font-size:11px;color:var(--text-muted);">Noticias relevantes para tu caso</p>
                            </div>
                            <div class="toggle"></div>
                        </div>
                    </div>
                </div>
            </div>

        </div>

    </ClientLayout>
</template>