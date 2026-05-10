<script setup>
import PublicLayout from '@/Layouts/PublicLayout.vue'
import { Link } from '@inertiajs/vue3'
import '@/../../resources/css/legal.css'
const cookies = [
    { nombre: 'XSRF-TOKEN', funcion: 'Protección técnica ante ataques CSRF. Impide que terceros ejecuten acciones en tu nombre.', persistencia: '2 Horas' },
    { nombre: 'laravel_session', funcion: 'Identificador de sesión para el área privada. Mantiene tu inicio de sesión activo.', persistencia: 'Sesión' },
]
</script>

<template>
    <PublicLayout title="Política de Cookies">
        <div class="legal-page">

            <!-- HERO -->
            <header class="legal-hero">
                <div class="legal-hero__bg"></div>
                <div class="legal-hero__content">
                    <span class="legal-tag">Configuración de Seguridad</span>
                    <h1 class="legal-title">Política de <em>Cookies</em></h1>
                    <p class="legal-hero__desc">Solo usamos las cookies estrictamente necesarias para que el portal funcione de forma segura</p>
                </div>
            </header>

            <!-- CONTENIDO -->
            <div class="legal-wrapper">
                <div class="legal-card">

                    <article class="legal-article">
                        <h2 class="legal-article-title">
                            <span class="legal-article-num">01</span>
                            Uso de Tecnologías de Sesión
                        </h2>
                        <p>Esta plataforma utiliza cookies propias de carácter estrictamente técnico para permitir la navegación segura. Sin estas cookies, funciones críticas como el acceso al historial de facturas o la reserva de citas en tiempo real no podrían ejecutarse de forma segura.</p>
                    </article>

                    <!-- Tabla de cookies -->
                    <div class="cookies-table-wrap">
                        <div class="cookies-table-header">
                            <span>Cookies activas en esta plataforma</span>
                            <span class="cookies-badge">Solo técnicas</span>
                        </div>
                        <div class="cookies-list">
                            <div v-for="c in cookies" :key="c.nombre" class="cookie-row">
                                <div class="cookie-row__name">{{ c.nombre }}</div>
                                <div class="cookie-row__desc">{{ c.funcion }}</div>
                                <div class="cookie-row__time">
                                    <span class="cookie-row__time-label">Persistencia</span>
                                    {{ c.persistencia }}
                                </div>
                            </div>
                        </div>
                    </div>

                    <article class="legal-article">
                        <h2 class="legal-article-title">
                            <span class="legal-article-num">02</span>
                            Base Legal
                        </h2>
                        <p>De conformidad con la LSSI, al tratarse de cookies necesarias para la prestación de un servicio solicitado por el usuario, su uso no requiere consentimiento previo. No obstante, en Selecto Asesores preferimos informar detalladamente para tu tranquilidad.</p>

                        <div class="legal-highlight">
                            <span class="legal-highlight__icon">✓</span>
                            <p><strong>No utilizamos cookies de seguimiento, analíticas ni publicitarias.</strong> Tu actividad en el portal no es monitorizada por terceros bajo ningún concepto.</p>
                        </div>
                    </article>

                </div>

                <!-- CTA -->
                <div class="legal-cta">
                    <p class="legal-cta__text">¿Tienes dudas sobre el uso de tus datos?</p>
                    <Link :href="route('home')" class="legal-cta__btn">
                        Volver al portal principal
                    </Link>
                </div>
            </div>

        </div>
    </PublicLayout>
</template>