<script setup>
import PublicLayout from '@/Layouts/PublicLayout.vue'
import { Link } from '@inertiajs/vue3'
import '@/../../resources/css/legal.css'
</script>

<template>
    <PublicLayout title="Aviso Legal">
        <div class="legal-page">

            <!-- HERO -->
            <header class="legal-hero">
                <div class="legal-hero__bg"></div>
                <div class="legal-hero__content">
                    <span class="legal-tag">Marco Institucional</span>
                    <h1 class="legal-title">Aviso <em>Legal</em></h1>
                    <p class="legal-hero__desc">Información legal y condiciones de uso de la plataforma Selecto Asesores</p>
                </div>
            </header>

            <!-- CONTENIDO -->
            <div class="legal-wrapper">
                <div class="legal-card">

                    <article class="legal-article">
                        <h2 class="legal-article-title">
                            <span class="legal-article-num">01</span>
                            Disposiciones Generales
                        </h2>
                        <p>El presente documento regula el uso de la plataforma digital propiedad de Selecto Asesores. El acceso, navegación y uso del sitio web conlleva la aceptación expresa de todas las cláusulas aquí detalladas. Como firma especializada en consultoría fiscal y estratégica, entendemos la transparencia como la base de nuestra relación profesional.</p>
                        <p>De acuerdo con la normativa vigente en el territorio español (LSSI-CE), Selecto Asesores pone a disposición pública sus canales de contacto oficiales: <strong>info@selectoasesores.com</strong> y el teléfono de atención preferente <strong>684 743 250</strong>. Cualquier interacción a través de estos medios implica la comprensión de que la información aquí contenida tiene carácter exclusivamente informativo y no constituye una opinión profesional vinculante hasta que se formalice un encargo de servicios.</p>
                    </article>

                    <article class="legal-article">
                        <h2 class="legal-article-title">
                            <span class="legal-article-num">02</span>
                            Propiedad Intelectual
                        </h2>
                        <p>Selecto Asesores es titular de todos los derechos de propiedad intelectual e industrial del portal. Esto incluye, pero no se limita a: la arquitectura del software, algoritmos internos de gestión de nóminas y fiscalidad, diseños de interfaces de usuario, logotipos y toda la producción editorial de noticias y análisis técnico.</p>
                        <p>Queda estrictamente prohibida la extracción de datos o la reproducción de cualquier elemento visual para fines que no sean el uso legítimo del cliente asignado.</p>
                    </article>

                    <article class="legal-article">
                        <h2 class="legal-article-title">
                            <span class="legal-article-num">03</span>
                            Limitación de Responsabilidad
                        </h2>
                        <p>Nuestra firma emplea los sistemas tecnológicos más avanzados para garantizar la disponibilidad permanente de la web. No obstante, Selecto Asesores no se responsabiliza de interrupciones técnicas ajenas a su control, ni de posibles perjuicios derivados de ataques informáticos que superen los protocolos de seguridad estándar del sector.</p>
                        <p>La información sobre impuestos y legislación se actualiza periódicamente, pero dada la volatilidad del sistema tributario, siempre se recomienda validar cualquier acción con su asesor personal a través de una cita previa.</p>
                    </article>

                </div>

                <!-- CTA -->
                <div class="legal-cta">
                    <p class="legal-cta__text">¿Tienes dudas sobre nuestras condiciones?</p>
                    <Link :href="route('reserva')" class="legal-cta__btn">
                        Solicitar plaza de asesoramiento
                    </Link>
                </div>
            </div>

        </div>
    </PublicLayout>
</template>