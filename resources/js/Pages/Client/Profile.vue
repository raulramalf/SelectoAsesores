<script setup>
import ClientLayout from '@/Layouts/ClientLayout.vue'
import { useForm, usePage } from '@inertiajs/vue3'
import { computed, ref } from 'vue'

const page = usePage()
const user = computed(() => page.props.auth?.user)

const avatarPreview = ref(
    user.value?.avatar ? `/storage/${user.value.avatar}` : null
)

const formPerfil = useForm({
    name:  user.value?.name  || '',
    email: user.value?.email || '',
    phone: user.value?.phone || '',
})

const formAvatar = useForm({ avatar: null })

const formPassword = useForm({
    current_password:      '',
    password:              '',
    password_confirmation: '',
})

const notificaciones = ref([
    { id: 'citas',        label: 'Recordatorio de citas',  desc: '24h antes de cada cita',                activo: true  },
    { id: 'documentos',   label: 'Nuevos documentos',      desc: 'Cuando tu asesor suba archivos',        activo: true  },
    { id: 'novedades',    label: 'Novedades fiscales',      desc: 'Noticias relevantes para tu caso',      activo: false },
])

function toggleNotif(id) {
    const n = notificaciones.value.find(n => n.id === id)
    if (n) n.activo = !n.activo
}

function guardarPerfil() {
    formPerfil.patch(route('profile.update'))
}

function onAvatarChange(e) {
    const file = e.target.files[0]
    if (!file) return
    avatarPreview.value = URL.createObjectURL(file)
    formAvatar.avatar = file
    formAvatar.post(route('profile.avatar'), { forceFormData: true })
}

function cambiarPassword() {
    formPassword.put(route('password.update'), {
        onSuccess: () => formPassword.reset(),
    })
}

const perfilOk   = computed(() => page.props.flash?.status === 'profile-updated')
const passwordOk = computed(() => page.props.flash?.status === 'password-updated')
const avatarOk   = computed(() => page.props.flash?.status === 'avatar-updated')
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

                    <div style="display:flex;align-items:center;gap:20px;margin-bottom:28px;">
                        <label for="avatar-input-client" style="cursor:pointer;position:relative;flex-shrink:0;">
                            <div class="perfil-avatar" style="width:64px;height:64px;font-size:26px;overflow:hidden;">
                                <img v-if="avatarPreview" :src="avatarPreview"
                                    style="width:100%;height:100%;object-fit:cover;border-radius:50%;" />
                                <span v-else>{{ user?.name?.charAt(0) }}</span>
                            </div>
                            <div class="avatar-overlay">
                                <svg width="18" height="18" fill="none" stroke="#fff" stroke-width="1.5" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M6.827 6.175A2.31 2.31 0 015.186 7.23c-.38.054-.757.112-1.134.175C2.999 7.58 2.25 8.507 2.25 9.574V18a2.25 2.25 0 002.25 2.25h15A2.25 2.25 0 0021.75 18V9.574c0-1.067-.75-1.994-1.802-2.169a47.865 47.865 0 00-1.134-.175 2.31 2.31 0 01-1.64-1.055l-.822-1.316a2.192 2.192 0 00-1.736-1.039 48.774 48.774 0 00-5.232 0 2.192 2.192 0 00-1.736 1.039l-.821 1.316z"/>
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M16.5 12.75a4.5 4.5 0 11-9 0 4.5 4.5 0 019 0z"/>
                                </svg>
                            </div>
                            <input id="avatar-input-client" type="file" accept="image/*" style="display:none" @change="onAvatarChange" />
                        </label>
                        <div>
                            <p style="font-size:14px;color:#fff;font-weight:500;">{{ user?.name }}</p>
                            <p style="font-size:12px;color:var(--text-muted);">Cliente</p>
                            <p style="font-size:11px;color:var(--text-dim);margin-top:3px;">Haz click en la foto para cambiarla</p>
                        </div>
                    </div>

                    <div v-if="avatarOk" class="flash-ok">Foto actualizada correctamente</div>

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
                        <div v-if="perfilOk" class="flash-ok">Datos guardados correctamente</div>
                        <button type="submit" class="form-submit" :disabled="formPerfil.processing">
                            {{ formPerfil.processing ? 'Guardando...' : 'Guardar Cambios' }}
                        </button>
                    </form>
                </div>
            </div>

            <!-- DERECHA -->
            <div style="display:flex;flex-direction:column;gap:20px;">

                <!-- SEGURIDAD -->
                <div class="dash-panel">
                    <div class="dash-panel__header">
                        <h3 class="dash-panel__title">Seguridad</h3>
                    </div>
                    <div style="padding:28px 24px;">
                        <form @submit.prevent="cambiarPassword" class="appointment-form">
                            <div class="form-group">
                                <label class="form-label">Contraseña actual</label>
                                <input v-model="formPassword.current_password" type="password" class="form-input" placeholder="••••••••" autocomplete="current-password" />
                                <span v-if="formPassword.errors.current_password" class="form-error">{{ formPassword.errors.current_password }}</span>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Nueva contraseña</label>
                                <input v-model="formPassword.password" type="password" class="form-input" placeholder="••••••••" autocomplete="new-password" />
                                <span v-if="formPassword.errors.password" class="form-error">{{ formPassword.errors.password }}</span>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Confirmar contraseña</label>
                                <input v-model="formPassword.password_confirmation" type="password" class="form-input" placeholder="••••••••" autocomplete="new-password" />
                            </div>
                            <div v-if="passwordOk" class="flash-ok">Contraseña actualizada correctamente</div>
                            <button type="submit" class="form-submit" :disabled="formPassword.processing">
                                {{ formPassword.processing ? 'Guardando...' : 'Guardar Cambios' }}
                            </button>
                        </form>
                    </div>
                </div>

                <!-- NOTIFICACIONES -->
                <div class="dash-panel">
                    <div class="dash-panel__header">
                        <h3 class="dash-panel__title">Preferencias de Notificaciones</h3>
                    </div>
                    <div style="padding:20px 24px;display:flex;flex-direction:column;gap:16px;">
                        <div v-for="n in notificaciones" :key="n.id" class="notif-row">
                            <div>
                                <p style="font-size:13px;color:#fff;">{{ n.label }}</p>
                                <p style="font-size:11px;color:var(--text-muted);">{{ n.desc }}</p>
                            </div>
                            <div :class="['toggle', n.activo && 'toggle--on']" @click="toggleNotif(n.id)"></div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </ClientLayout>
</template>