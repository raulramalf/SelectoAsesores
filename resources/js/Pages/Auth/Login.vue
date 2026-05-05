<script setup>
import { Head, Link, useForm } from '@inertiajs/vue3'

defineProps({
    canResetPassword: Boolean,
    status: String,
})

const form = useForm({
    email: '',
    password: '',
    remember: false,
})

function submit() {
    form.post(route('login'), {
        onFinish: () => form.reset('password'),
    })
}
</script>

<template>
    <Head title="Acceder" />

    <div class="login-page">

        <!-- LADO IZQUIERDO -->
        <div class="login-left">
            <div class="login-left__overlay"></div>
            <div class="login-left__content">
                <Link href="/">
                    <img src="/favicon.ico" class="absolute -bottom-20 -left-20 w-[600px] opacity-[0.03] pointer-events-none" />
                </Link>
                <h2 class="login-left__title">
                    Tu asesoría fiscal<br>
                    <em>siempre disponible</em>
                </h2>
                <p class="login-left__text">Accede a tu área privada para gestionar tus citas, documentos y consultas con tu asesor.</p>
            </div>
        </div>

        <!-- LADO DERECHO -->
        <div class="login-right">
            <div class="login-box">
                <div class="login-box__header">
                    <h1 class="login-box__title">Bienvenido</h1>
                    <p class="login-box__sub">Introduce tus credenciales para acceder</p>
                </div>

                <div v-if="status" class="login-status">{{ status }}</div>

                <form @submit.prevent="submit" class="login-form">
                    <div class="form-group">
                        <label class="form-label">Email</label>
                        <input
                            v-model="form.email"
                            type="email"
                            class="form-input"
                            :class="{ 'form-input--error': form.errors.email }"
                            placeholder="tu@email.com"
                            autofocus
                            autocomplete="username"
                        />
                        <span v-if="form.errors.email" class="form-error">{{ form.errors.email }}</span>
                    </div>

                    <div class="form-group">
                        <div class="login-label-row">
                            <label class="form-label">Contraseña</label>
                            <Link v-if="canResetPassword" href="/forgot-password" class="login-forgot">¿Olvidaste tu contraseña?</Link>
                        </div>
                        <input
                            v-model="form.password"
                            type="password"
                            class="form-input"
                            :class="{ 'form-input--error': form.errors.password }"
                            placeholder="••••••••"
                            autocomplete="current-password"
                        />
                        <span v-if="form.errors.password" class="form-error">{{ form.errors.password }}</span>
                    </div>

                    <div class="login-remember">
                        <input type="checkbox" v-model="form.remember" id="remember" class="login-checkbox" />
                        <label for="remember" class="login-remember-label">Recordarme</label>
                    </div>

                    <button type="submit" class="form-submit" :disabled="form.processing">
                        {{ form.processing ? 'Accediendo...' : 'Acceder' }}
                    </button>
                </form>

                <div class="login-box__footer">
                    <p>¿No tienes cuenta? <Link href="/reserva" class="login-link">Solicita una cita</Link></p>
                    <Link href="/" class="login-back">← Volver a la web</Link>
                </div>
            </div>
        </div>

    </div>
</template>