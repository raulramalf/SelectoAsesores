<script setup>
import GuestLayout from '@/Layouts/GuestLayout.vue';
import InputError from '@/Components/InputError.vue';
import { Head, useForm } from '@inertiajs/vue3';

defineProps({
    status: {
        type: String,
    },
});

const form = useForm({
    email: '',
});

const submit = () => {
    form.post(route('password.email'));
};
</script>

<template>
    <GuestLayout>
        <Head title="Restablecer Contraseña" />

        <div class="fp-header">
            <h2 class="fp-title">Restablecer contraseña</h2>
            <p class="fp-subtitle">
                ¿Has olvidado tu contraseña? No te preocupes, déjanos tu correo
                y te enviaremos un enlace para restablecerla.
            </p>
        </div>

        <div v-if="status" class="fp-status">
            {{ status }}
        </div>

        <form @submit.prevent="submit" class="fp-form">
            <div class="fp-field">
                <label for="email" class="fp-label">Correo electrónico</label>
                <input
                    id="email"
                    type="email"
                    class="fp-input"
                    :class="{ 'fp-input--error': form.errors.email }"
                    v-model="form.email"
                    required
                    autofocus
                    autocomplete="username"
                    placeholder="tu@email.com"
                />
                <InputError class="fp-error" :message="form.errors.email" />
            </div>

            <button
                type="submit"
                class="fp-btn"
                :class="{ 'fp-btn--loading': form.processing }"
                :disabled="form.processing"
            >
                <span v-if="form.processing">Enviando...</span>
                <span v-else>Enviar enlace de recuperación</span>
            </button>
        </form>

        <div class="fp-footer">
            <a href="/login" class="fp-back">
                <svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M10.5 19.5L3 12m0 0l7.5-7.5M3 12h18"/>
                </svg>
                Volver al inicio de sesión
            </a>
        </div>
    </GuestLayout>
</template>

<style>
@import '../../../css/forgotpassword.css';
</style>