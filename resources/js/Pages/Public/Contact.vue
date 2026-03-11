<script setup>
import PublicLayout from '@/Layouts/PublicLayout.vue'
import { useForm, usePage } from '@inertiajs/vue3'
import { computed } from 'vue'

const page = usePage()
const success = computed(() => page.props.flash?.success)

const form = useForm({
    name: '',
    email: '',
    phone: '',
    subject: '',
    message: '',
})

function submit() {
    form.post(route('contacto.store'))
}

const contactItems = [
    { label: 'Teléfono', value: '555 555 555', href: 'tel:555555555' },
    { label: 'Email', value: 'selectoasesores@contacto.com', href: 'mailto:selectoasesores@contacto.com' },
    { label: 'Instagram', value: '@selectoasesores', href: '#' },
    { label: 'LinkedIn', value: 'linkedin/selectoasesores', href: '#' },
]
</script>

<template>
    <PublicLayout>

        <!-- HERO -->
        <section class="appointment-hero">
            <div class="appointment-hero__overlay"></div>
            <div class="appointment-hero__content">
                <span class="section-tag">Contacto</span>
                <h1 class="appointment-hero__title">
                    Estamos aquí<br>
                    <em>para ayudarte</em>
                </h1>
                <p class="appointment-hero__desc">
                    Escríbenos o llámanos. Respondemos todas las consultas en menos de 24 horas.
                </p>
            </div>
        </section>

        <!-- FORMULARIO -->
        <section class="contact-section">
            <div class="contact-wrapper">

                <!-- Info -->
                <div class="contact-info">
                    <h2 class="contact-info__title">Datos de contacto</h2>

                    <div v-for="item in contactItems" :key="item.label" class="contact-info__item">
                        <span class="contact-info__label">{{ item.label }}</span>
                        <a :href="item.href" class="contact-info__value">{{ item.value }}</a>
                    </div>

                    <div style="margin-top: 32px; padding-top: 24px; border-top: 1px solid var(--border);">
                        <p class="contact-info__label" style="margin-bottom: 12px;">Horario de atención</p>
                        <p style="font-size: 13px; color: var(--text-muted); line-height: 1.8;">
                            Lunes a viernes<br>
                            9:00 — 14:00 / 16:00 — 19:00
                        </p>
                    </div>
                </div>

                <!-- Formulario -->
                <div class="contact-form-wrapper">

                    <div v-if="success" class="appointment-success">
                        <span class="appointment-success__icon">✓</span>
                        <div>
                            <p class="appointment-success__title">Mensaje enviado</p>
                            <p class="appointment-success__desc">{{ success }}</p>
                        </div>
                    </div>

                    <form @submit.prevent="submit" class="appointment-form">
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">Nombre *</label>
                                <input
                                    v-model="form.name"
                                    type="text"
                                    class="form-input"
                                    :class="{ 'form-input--error': form.errors.name }"
                                    placeholder="Tu nombre"
                                />
                                <span v-if="form.errors.name" class="form-error">{{ form.errors.name }}</span>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Teléfono</label>
                                <input
                                    v-model="form.phone"
                                    type="tel"
                                    class="form-input"
                                    placeholder="600 000 000"
                                />
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label">Email *</label>
                            <input
                                v-model="form.email"
                                type="email"
                                class="form-input"
                                :class="{ 'form-input--error': form.errors.email }"
                                placeholder="tu@email.com"
                            />
                            <span v-if="form.errors.email" class="form-error">{{ form.errors.email }}</span>
                        </div>

                        <div class="form-group">
                            <label class="form-label">Asunto *</label>
                            <input
                                v-model="form.subject"
                                type="text"
                                class="form-input"
                                :class="{ 'form-input--error': form.errors.subject }"
                                placeholder="¿En qué podemos ayudarte?"
                            />
                            <span v-if="form.errors.subject" class="form-error">{{ form.errors.subject }}</span>
                        </div>

                        <div class="form-group">
                            <label class="form-label">Mensaje *</label>
                            <textarea
                                v-model="form.message"
                                class="form-input form-textarea"
                                :class="{ 'form-input--error': form.errors.message }"
                                placeholder="Escribe tu consulta aquí..."
                                rows="5"
                            ></textarea>
                            <span v-if="form.errors.message" class="form-error">{{ form.errors.message }}</span>
                        </div>

                        <button
                            type="submit"
                            class="form-submit"
                            :disabled="form.processing"
                        >
                            {{ form.processing ? 'Enviando...' : 'Enviar mensaje' }}
                        </button>

                        <p class="form-disclaimer">
                            Al enviar aceptas nuestra <a href="#">política de privacidad</a>.
                            Tus datos no serán cedidos a terceros.
                        </p>
                    </form>
                </div>

            </div>
        </section>

    </PublicLayout>
</template>