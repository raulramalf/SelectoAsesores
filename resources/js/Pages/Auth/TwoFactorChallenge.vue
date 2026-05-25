<script setup>
import GuestLayout from '@/Layouts/GuestLayout.vue';
import { useForm } from '@inertiajs/vue3';

const form = useForm({
    code: '',
});

const submit = () => {
    form.post(route('2fa.verify'));
};
</script>

<template>
    <GuestLayout>
        <div class="tfa-header">
            <div class="tfa-icon">
                <svg width="24" height="24" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M9 12.75L11.25 15 15 9.75m-3-7.036A11.959 11.959 0 013.598 6 11.99 11.99 0 003 9.749c0 5.592 3.824 10.29 9 11.623 5.176-1.332 9-6.03 9-11.622 0-1.31-.21-2.571-.598-3.751h-.152c-3.196 0-6.1-1.248-8.25-3.285z"/>
                </svg>
            </div>
            <h2 class="tfa-title">Doble Autenticación</h2>
            <p class="tfa-subtitle">
                Abre Google Authenticator o Microsoft Authenticator e introduce el código de 6 dígitos.
            </p>
        </div>

        <form @submit.prevent="submit" class="tfa-form">
            <div class="tfa-field">
                <label class="tfa-label">Código de Autenticación</label>
                <input
                    type="text"
                    v-model="form.code"
                    required
                    autofocus
                    autocomplete="one-time-code"
                    class="tfa-input"
                    :class="{ 'tfa-input--error': form.errors.code }"
                    placeholder="123456"
                    maxlength="6"
                    inputmode="numeric"
                    pattern="[0-9]*"
                />
                <span v-if="form.errors.code" class="tfa-error">
                    {{ form.errors.code }}
                </span>
            </div>

            <button
                type="submit"
                :disabled="form.processing"
                class="tfa-btn"
                :class="{ 'tfa-btn--loading': form.processing }"
            >
                <svg v-if="!form.processing" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M13.5 10.5V6.75a4.5 4.5 0 119 0v3.75M3.75 21.75h10.5a2.25 2.25 0 002.25-2.25v-6.75a2.25 2.25 0 00-2.25-2.25H3.75a2.25 2.25 0 00-2.25 2.25v6.75a2.25 2.25 0 002.25 2.25z"/>
                </svg>
                <span>{{ form.processing ? 'Verificando...' : 'Verificar y Acceder' }}</span>
            </button>
        </form>

        <div class="tfa-footer">
            <a href="/login" class="tfa-back">
                <svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M10.5 19.5L3 12m0 0l7.5-7.5M3 12h18"/>
                </svg>
                Volver al inicio de sesión
            </a>
        </div>
    </GuestLayout>
</template>

<style>
@import '../../../css/2fa.css';
</style>