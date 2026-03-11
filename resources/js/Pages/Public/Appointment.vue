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
    reason: '',
    date: '',
    description: '',
})

const razones = [
    'Declaración de la Renta (IRPF)',
    'Asesoría Fiscal Integral',
    'Contabilidad de Empresa',
    'Gestión de Autónomos',
    'Constitución de Sociedades',
    'Consultoría Tributaria',
    'Otra consulta',
]

function submit() {
    form.post(route('reserva.store'))
}
</script>

<template>
    <PublicLayout>

        <!-- HERO -->
        <section class="appointment-hero">
            <div class="appointment-hero__overlay"></div>
            <div class="appointment-hero__content">
                <span class="section-tag">Reserva de cita</span>
                <h1 class="appointment-hero__title">
                    Primera consulta<br>
                    <em>completamente gratuita</em>
                </h1>
                <p class="appointment-hero__desc">
                    Cuéntanos tu situación y un asesor se pondrá en contacto contigo en menos de 24 horas para confirmar la cita.
                </p>
            </div>
        </section>

        <!-- FORMULARIO -->
        <section class="appointment-section">
            <div class="appointment-wrapper">

                <!-- Columna info -->
                <div class="appointment-info">
                    <h2 class="appointment-info__title">¿Qué puedes esperar?</h2>

                    <div class="appointment-info__item" v-for="item in infoItems" :key="item.titulo">
                        <div class="appointment-info__icon">{{ item.icono }}</div>
                        <div>
                            <p class="appointment-info__item-title">{{ item.titulo }}</p>
                            <p class="appointment-info__item-desc">{{ item.desc }}</p>
                        </div>
                    </div>

                    <div class="appointment-info__contacto">
                        <p class="appointment-info__contacto-label">¿Prefieres llamarnos?</p>
                        <a href="tel:555555555" class="appointment-info__contacto-tel">555 555 555</a>
                        <p class="appointment-info__contacto-label" style="margin-top:8px;">O escríbenos a</p>
                        <a href="mailto:selectoasesores@contacto.com" class="appointment-info__contacto-mail">selectoasesores@contacto.com</a>
                    </div>
                </div>

                <!-- Columna formulario -->
                <div class="appointment-form-wrapper">

                    <!-- Mensaje éxito -->
                    <div v-if="success" class="appointment-success">
                        <span class="appointment-success__icon">✓</span>
                        <div>
                            <p class="appointment-success__title">¡Solicitud enviada!</p>
                            <p class="appointment-success__desc">{{ success }}</p>
                        </div>
                    </div>

                    <form @submit.prevent="submit" class="appointment-form">
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">Nombre completo *</label>
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
                                <label class="form-label">Teléfono *</label>
                                <input
                                    v-model="form.phone"
                                    type="tel"
                                    class="form-input"
                                    :class="{ 'form-input--error': form.errors.phone }"
                                    placeholder="600 000 000"
                                />
                                <span v-if="form.errors.phone" class="form-error">{{ form.errors.phone }}</span>
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

                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">Motivo de la consulta *</label>
                                <select
                                    v-model="form.reason"
                                    class="form-input"
                                    :class="{ 'form-input--error': form.errors.reason }"
                                >
                                    <option value="" disabled>Selecciona un servicio</option>
                                    <option v-for="r in razones" :key="r" :value="r">{{ r }}</option>
                                </select>
                                <span v-if="form.errors.reason" class="form-error">{{ form.errors.reason }}</span>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Fecha preferida *</label>
                                <input
                                    v-model="form.date"
                                    type="date"
                                    class="form-input"
                                    :class="{ 'form-input--error': form.errors.date }"
                                />
                                <span v-if="form.errors.date" class="form-error">{{ form.errors.date }}</span>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label">Cuéntanos más sobre tu situación</label>
                            <textarea
                                v-model="form.description"
                                class="form-input form-textarea"
                                placeholder="Describe brevemente tu situación fiscal o las dudas que tienes..."
                                rows="4"
                            ></textarea>
                        </div>

                        <button
                            type="submit"
                            class="form-submit"
                            :disabled="form.processing"
                        >
                            {{ form.processing ? 'Enviando...' : 'Solicitar cita gratuita' }}
                        </button>

                        <p class="form-disclaimer">
                            Al enviar este formulario aceptas nuestra
                            <a href="#">política de privacidad</a>.
                            Tus datos no serán cedidos a terceros.
                        </p>
                    </form>
                </div>

            </div>
        </section>

    </PublicLayout>
</template>

<script>
export default {
    data() {
        return {
            infoItems: [
                {
                    icono: '—',
                    titulo: 'Sin compromiso',
                    desc: 'La primera consulta es completamente gratuita y sin ningún tipo de compromiso.',
                },
                {
                    icono: '—',
                    titulo: 'Respuesta en 24h',
                    desc: 'Un asesor revisará tu solicitud y te contactará para confirmar día y hora.',
                },
                {
                    icono: '—',
                    titulo: 'Asesor especializado',
                    desc: 'Te asignamos el profesional más adecuado según tu situación fiscal.',
                },
                {
                    icono: '—',
                    titulo: 'Presencial o videollamada',
                    desc: 'Elige el formato que más te convenga para la reunión.',
                },
            ],
        }
    },
}
</script>