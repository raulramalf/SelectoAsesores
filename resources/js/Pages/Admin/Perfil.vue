<script setup>
import AdminLayout from '@/Layouts/AdminLayout.vue'
import { useForm, usePage } from '@inertiajs/vue3'
import { computed, ref } from 'vue'
import axios from 'axios';

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
const errorAvatarLocal = ref('') 

const formPassword = useForm({
    current_password:      '',
    password:              '',
    password_confirmation: '',
})

const qrData = ref(null);
const form2FA = useForm({ code: '' });

async function enable2FA() {
    try {
        const response = await axios.post(route('2fa.enable'));
        qrData.value = response.data; // Recibimos el código QR SVG
    } catch (error) {
        console.error("Error al generar QR", error);
    }
}

function confirm2FA() {
    form2FA.post(route('2fa.confirm'), {
        onSuccess: () => {
            qrData.value = null;
            form2FA.reset();
            if (user.value) {
                user.value.two_factor_confirmed_at = new Date().toISOString();
            }
        }
    });
}

function disable2FA() {
    if(confirm('¿Seguro que deseas deshabilitar la autenticación en dos pasos? Tu cuenta será menos segura.')) {
        useForm().delete(route('2fa.disable'), {
            onSuccess: () => {
                if (user.value) {
                    user.value.two_factor_confirmed_at = null;
                }
            }
        });
    }
}

const notificaciones = ref([
    { id: 'citas',        label: 'Nuevas citas',          desc: 'Cuando un cliente solicite cita',   activo: true  },
    { id: 'mensajes',     label: 'Nuevos mensajes',       desc: 'Formulario de contacto',            activo: true  },
    { id: 'recordatorio', label: 'Recordatorios del día', desc: 'Citas programadas para mañana',     activo: false },
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

    // 1. Limpiamos errores previos
    errorAvatarLocal.value = ''
    formAvatar.clearErrors()

    if (file.size > 2 * 1024 * 1024) {
        errorAvatarLocal.value = 'La imagen es demasiado pesada. El tamaño máximo es 2MB.'
        e.target.value = '' // Limpiamos el input
        return 
    }

    avatarPreview.value = URL.createObjectURL(file)
    formAvatar.avatar = file
    formAvatar.post(route('profile.avatar'), { 
        forceFormData: true,
        onError: () => {
            // Si el servidor diera error, revertimos la imagen a la original
            avatarPreview.value = user.value?.avatar ? `/storage/${user.value.avatar}` : null;
        }
    })
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
    <AdminLayout>
        <template #header>Mi Perfil</template>

        <div class="dash-welcome">
            <h1 class="dash-welcome__title">Mi Perfil</h1>
        </div>

        <div class="dash-cols">

            <div class="dash-panel">
                <div class="dash-panel__header">
                    <h3 class="dash-panel__title">Datos Personales</h3>
                </div>
                <div style="padding:28px 24px;">

                    <div style="display:flex;align-items:center;gap:20px;margin-bottom:12px;">
                        <label for="avatar-input" style="cursor:pointer;position:relative;flex-shrink:0;">
                            <div class="perfil-avatar" style="width:64px;height:64px;font-size:26px;overflow:hidden;background:#1c2d3f;display:flex;align-items:center;justify-content:center;border-radius:50%;color:#fff;">
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
                            <input id="avatar-input" type="file" accept="image/jpeg, image/png, image/webp" style="display:none" @change="onAvatarChange" />
                        </label>
                        <div>
                            <p style="font-size:14px;color:#fff;font-weight:500;">{{ user?.name }}</p>
                            <p style="font-size:12px;color:var(--text-muted);text-transform:capitalize;">{{ user?.role }}</p>
                            <p style="font-size:11px;color:var(--text-dim);margin-top:3px;">Haz click en la foto para cambiarla</p>
                        </div>
                    </div>

                    <p v-if="errorAvatarLocal" style="color:#ff4d4d; font-size:12px; margin-bottom:16px; margin-left:84px;">
                        {{ errorAvatarLocal }}
                    </p>
                    <p v-if="formAvatar.errors.avatar" style="color:#ff4d4d; font-size:12px; margin-bottom:16px; margin-left:84px;">
                        {{ formAvatar.errors.avatar }}
                    </p>

                    <div v-if="avatarOk" class="flash-ok" style="margin-bottom:16px;">Foto actualizada correctamente</div>

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

            <div style="display:flex;flex-direction:column;gap:20px;">

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

                <div class="dash-panel">
                    <div class="dash-panel__header">
                        <h3 class="dash-panel__title">Autenticación en Dos Pasos (2FA)</h3>
                    </div>
                    <div style="padding:28px 24px;">
                        <p style="font-size:13px;color:var(--text-muted);margin-bottom:20px;">
                            Añade una capa extra de seguridad a tu cuenta usando Google Authenticator o Microsoft Authenticator.
                        </p>

                        <div v-if="user?.two_factor_confirmed_at">
                            <div class="flash-ok" style="margin-bottom:16px;">2FA está activado y protegiendo tu cuenta.</div>
                            <button @click="disable2FA" class="form-submit" style="background:transparent; border:1px solid #ff4d4d; color:#ff4d4d;">
                                Deshabilitar 2FA
                            </button>
                        </div>
                        
                        <div v-else>
                            <button v-if="!qrData" @click="enable2FA" class="form-submit" style="background:#fff; color:#151F2B;">
                                Configurar 2FA
                            </button>
                            
                            <div v-if="qrData" style="background:rgba(255,255,255,0.05); padding:20px; border-radius:8px;">
                                <p style="font-size:13px; color:#fff; margin-bottom:12px;">1. Escanea este código con tu aplicación autenticadora:</p>
                                
                                <div v-html="qrData.qrCode" style="background:white; padding:16px; border-radius:8px; display:inline-block; margin-bottom:16px;"></div>
                                
                                <p style="font-size:13px; color:#fff; margin-bottom:12px;">2. Introduce el código de 6 dígitos que genera tu app:</p>
                                <form @submit.prevent="confirm2FA" style="display:flex; gap:12px; align-items:center;">
                                    <input v-model="form2FA.code" type="text" class="form-input" placeholder="Ej: 123456" style="max-width:150px;" required />
                                    <button type="submit" class="form-submit" :disabled="form2FA.processing" style="width:auto; padding:0 24px;">
                                        Verificar
                                    </button>
                                </form>
                                <span v-if="form2FA.errors.code" class="form-error" style="display:block; margin-top:8px;">{{ form2FA.errors.code }}</span>
                            </div>
                        </div>
                    </div>
                </div>

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

    </AdminLayout>
</template>