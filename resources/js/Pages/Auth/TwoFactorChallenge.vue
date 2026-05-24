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
        <div style="text-align: center; margin-bottom: 24px;">
            <h2 style="color: #fff; font-family: 'Instrument Serif', serif; font-size: 32px; margin-bottom: 8px;">
                Doble Autenticación
            </h2>
            <p style="color: #a0aabf; font-size: 14px;">
                Abre Google Authenticator o Microsoft Authenticator e introduce el código de 6 dígitos.
            </p>
        </div>

        <form @submit.prevent="submit" style="display: flex; flex-direction: column; gap: 20px;">
            <div>
                <label style="display: block; color: #fff; font-size: 13px; font-weight: 500; margin-bottom: 8px;">Código de Autenticación</label>
                <input
                    type="text"
                    v-model="form.code"
                    required
                    autofocus
                    autocomplete="one-time-code"
                    style="width: 100%; background: #151F2B; border: 1px solid rgba(226,203,174,0.2); border-radius: 8px; padding: 12px; color: #fff;"
                    placeholder="123456"
                />
                <span v-if="form.errors.code" style="color: #ff4d4d; font-size: 12px; margin-top: 4px; display: block;">
                    {{ form.errors.code }}
                </span>
            </div>

            <button type="submit" :disabled="form.processing" style="background: #E2CBAE; color: #151F2B; width: 100%; padding: 14px; border-radius: 8px; font-weight: 600; cursor: pointer; text-transform: uppercase; font-size: 13px; border: none;">
                {{ form.processing ? 'Verificando...' : 'Verificar y Acceder' }}
            </button>
        </form>
    </GuestLayout>
</template>