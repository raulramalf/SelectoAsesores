<script setup>
import PublicLayout from '@/Layouts/PublicLayout.vue'
import { Link } from '@inertiajs/vue3'
import '@/../../resources/css/legal.css'

const derechos = [
    { icono: '◎', titulo: 'Acceso', desc: 'Consulta en cualquier momento qué datos tuyos conservamos en nuestros sistemas.' },
    { icono: '◈', titulo: 'Rectificación', desc: 'Corrige datos inexactos o incompletos de forma inmediata.' },
    { icono: '◉', titulo: 'Supresión', desc: 'Solicita la eliminación de tus datos cuando ya no sean necesarios.' },
    { icono: '◑', titulo: 'Limitación', desc: 'Restringe el tratamiento de tus datos en determinadas circunstancias.' },
    { icono: '◐', titulo: 'Portabilidad', desc: 'Recibe tus datos en formato estructurado para trasladarlos a otro proveedor.' },
    { icono: '◒', titulo: 'Oposición', desc: 'Oponte al tratamiento de tus datos en cualquier momento.' },
]
</script>

<template>
    <PublicLayout title="Política de Privacidad">
        <div class="legal-page">

            <!-- HERO -->
            <header class="legal-hero">
                <div class="legal-hero__bg"></div>
                <div class="legal-hero__content">
                    <span class="legal-tag">Protocolo de Confidencialidad</span>
                    <h1 class="legal-title">Protección de <em>Datos</em></h1>
                    <p class="legal-hero__desc">Cumplimiento RGPD y LOPDGDD — Tu información fiscal, siempre protegida</p>
                </div>
            </header>

            <!-- CONTENIDO -->
            <div class="legal-wrapper">
                <div class="legal-card">

                    <article class="legal-article">
                        <h2 class="legal-article-title">
                            <span class="legal-article-num">01</span>
                            Compromiso RGPD
                        </h2>
                        <p>En Selecto Asesores, la seguridad de la información fiscal y contable de nuestros clientes es el activo más valioso. Cumplimos rigurosamente con el Reglamento (UE) 2016/679 (RGPD) y la Ley Orgánica 3/2018 (LOPDGDD).</p>
                        <p>Cada fragmento de información que usted sube a nuestro panel de control es tratado bajo cifrado de extremo a extremo, garantizando que solo su asesor asignado tenga acceso a la documentación sensible.</p>
                    </article>

                    <article class="legal-article">
                        <h2 class="legal-article-title">
                            <span class="legal-article-num">02</span>
                            Gestión de Documentación Tributaria
                        </h2>
                        <p>La finalidad principal del tratamiento de sus datos es la correcta ejecución de los servicios de asesoría contratados: presentación de trimestrales de IVA, modelos de IRPF, Impuesto de Sociedades y gestiones ante la Seguridad Social.</p>
                        <p>Sus datos <strong>nunca serán cedidos a terceros con fines publicitarios</strong>. Su información solo viaja hacia los servidores seguros de la Agencia Tributaria o por requerimiento legal expreso.</p>
                    </article>

                    <article class="legal-article">
                        <h2 class="legal-article-title">
                            <span class="legal-article-num">03</span>
                            Tus Derechos
                        </h2>
                        <p>Usted mantiene el control total sobre su huella digital en Selecto Asesores. Puede ejercer cualquiera de los siguientes derechos en cualquier momento:</p>

                        <!-- Grid de derechos -->
                        <div class="privacy-rights-grid">
                            <div v-for="d in derechos" :key="d.titulo" class="privacy-right-card">
                                <span class="privacy-right-icon">{{ d.icono }}</span>
                                <h4>{{ d.titulo }}</h4>
                                <p>{{ d.desc }}</p>
                            </div>
                        </div>

                        <div class="legal-highlight">
                            <span class="legal-highlight__icon">✉</span>
                            <p>Para ejercer tus derechos, envía un email a <strong>info@selectoasesores.com</strong> acreditando tu identidad. Nos comprometemos a responder en un plazo máximo de <strong>48 horas laborales</strong>.</p>
                        </div>
                    </article>

                </div>

                <!-- CTA -->
                <div class="legal-cta">
                    <p class="legal-cta__text">¿Prefieres hablar directamente con nosotros?</p>
                    <Link :href="route('contacto')" class="legal-cta__btn">
                        Hablar con un asesor personal
                    </Link>
                </div>
            </div>

        </div>
    </PublicLayout>
</template>