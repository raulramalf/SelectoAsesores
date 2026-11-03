<script setup>
import PublicLayout from '@/Layouts/PublicLayout.vue'
import Promopopup from './Promopopup.vue'
import TrustpilotWidget from './TrustpilotWidget.vue'
import { Head, Link } from '@inertiajs/vue3'
import { planes } from '@/data/servicios'
import { empresa, garantias, contacto } from '@/data/empresa'

const heroImagen = 'https://images.unsplash.com/photo-1589829545856-d10d557cf95f?w=1400&q=80'

const datosClave = [
    'Primera consulta gratuita',
    'Respuesta en menos de 24 horas',
    'Asesor personal asignado',
    'Presencial o videollamada',
]

</script>

<template>
    <PublicLayout>
        <Head title="Asesoría fiscal, contable y laboral" />

        <Promopopup />

        <!-- 1 · HERO -->
        <section class="hx-hero" id="inicio">
            <div class="hx-container hx-hero__grid">
                <div class="hx-hero__text">
                    <span class="hx-eyebrow">Selecto Asesores</span>
                    <h1 class="hx-hero__title">
                        Todo lo que tu empresa<br>
                        <em>necesita en un solo lugar</em>
                    </h1>
                    <p class="hx-hero__lead">
                        Asesoría fiscal integral para autónomos, pymes y empresas. Gestionamos tu fiscalidad para que tú te centres en crecer.
                    </p>
                    <div class="hx-actions">
                        <Link href="/reserva" class="btn btn--primary">Solicita tu plaza</Link>
                        <Link href="/servicios" class="link-arrow">Ver servicios</Link>
                    </div>
                </div>
                <figure class="hx-hero__figure">
                    <img :src="heroImagen" alt="Reunión de asesoramiento en despacho" width="700" height="860"
                         fetchpriority="high" decoding="async"
                         onerror="this.closest('.hx-hero').classList.add('no-photo')">
                </figure>
            </div>
        </section>

        <section class="hx-facts" aria-label="Datos clave del servicio">
            <ul class="hx-container hx-facts__list">
                <li v-for="d in datosClave" :key="d">{{ d }}</li>
            </ul>
        </section>

        <!-- 2 · PRESENTACIÓN -->
        <section class="hx-section hx-section--alt" id="empresa">
            <div class="hx-container hx-about">
                <div class="hx-about__head">
                    <span class="hx-eyebrow">Sobre nosotros</span>
                    <h2 class="hx-title">Más que una asesoría,<br><em>tu socio estratégico</em></h2>
                </div>
                <div class="hx-about__body">
                    <p class="hx-about__lead">{{ empresa.intro }}</p>
                    <div class="hx-about__pair">
                        <div>
                            <h3 class="hx-label">Nuestra misión</h3>
                            <p>{{ empresa.mision }}</p>
                        </div>
                        <div>
                            <h3 class="hx-label">Nuestra visión</h3>
                            <p>{{ empresa.vision }}</p>
                        </div>
                    </div>
                    <Link href="/nosotros" class="link-arrow">Conocer Selecto Asesores</Link>
                </div>
            </div>
        </section>

        <!-- 3 · SERVICIOS -->
        <section class="hx-section" id="servicios">
            <div class="hx-container">
                <div class="hx-head">
                    <div>
                        <span class="hx-eyebrow">Servicios</span>
                        <h2 class="hx-title">Nuestros Servicios</h2>
                    </div>
                    <p class="hx-head__note">Transparencia total. Sin costes ocultos ni sorpresas a final de mes.</p>
                </div>

                <div class="hx-services">
                    <article v-for="plan in planes" :key="plan.nombre" class="hx-service">
                        <div class="hx-service__top">
                            <h3>{{ plan.nombre }}</h3>
                            <span v-if="plan.destacado" class="hx-tag">Más popular</span>
                        </div>
                        <p class="hx-service__desc">{{ plan.desc }}</p>
                        <ul class="hx-service__list">
                            <li v-for="f in plan.features.slice(0, 3)" :key="f">{{ f }}</li>
                        </ul>
                        <div class="hx-service__foot">
                            <div class="hx-price">
                                <small v-if="plan.nombre !== 'Particulares'">Desde</small>
                                <strong>{{ plan.precio }} €</strong>
                                <small v-if="plan.nombre !== 'Particulares'">/ mes</small>
                            </div>
                            <Link href="/servicios" class="link-arrow">Ver detalle</Link>
                        </div>
                    </article>
                </div>
            </div>
        </section>

        <!-- 4 · OFERTA -->
        <section id="seccion-oferta" class="home-oferta">

            <div class="home-oferta__inner">
                <div class="promo-premium-modal" style="border:1px solid rgba(226,203,174,0.2);border-radius:3px;max-width:100%;overflow:hidden;">
                    <div class="promo-premium-grid">

                        <div class="promo-premium-content">
                            <span class="promo-premium-badge" style="letter-spacing:0.25em;margin-bottom:16px;">Tarifa Especial Nuevos Autónomos</span>

                            <h2 class="promo-premium-title" style="margin-bottom:24px;">
                                Servicio Fiscal y Contable<br>
                                <em style="color:#E2CBAE;">Integral</em>
                            </h2>

                            <div style="display:flex;align-items:baseline;gap:12px;margin-bottom:24px;border-bottom:1px solid rgba(255,255,255,0.05);padding-bottom:24px;">
                                <div style="display:flex;flex-direction:column;align-items:flex-end;gap:2px;">
                                    <span style="font-size:11px;color:#6a7a9a;text-transform:uppercase;letter-spacing:0.1em;">Desde</span>
                                    <span style="text-decoration:line-through;font-size:16px;color:#4a5a72;">300 €</span>
                                </div>
                                <span class="promo-premium-price" style="font-size:clamp(36px,6vw,56px);font-family:'Instrument Serif',serif;line-height:1;color:#fff;">200 €</span>
                                <span class="promo-premium-period" style="font-size:14px;color:#8a9ab5;">Único</span>
                            </div>

                            <p class="promo-premium-desc" style="font-size:15px;color:#a0aabf;line-height:1.7;margin-bottom:32px;">
                                Tu tranquilidad no tiene precio, pero ahora sí tiene descuento. Únete a Selecto Asesores este mes y accede a nuestra gestión contable y tributaria completa.
                            </p>

                            <ul style="display:flex;flex-direction:column;gap:14px;margin-bottom:40px;padding:0;list-style:none;">
                                <li style="display:flex;align-items:center;gap:12px;font-size:14px;color:#fff;">
                                    <span style="color:#E2CBAE;font-size:16px;">✓</span> Asesor personal asignado
                                </li>
                                <li style="display:flex;align-items:center;gap:12px;font-size:14px;color:#fff;">
                                    <span style="color:#E2CBAE;font-size:16px;">✓</span> Presentación de impuestos (IVA, IRPF)
                                </li>
                                <li style="display:flex;align-items:center;gap:12px;font-size:14px;color:#fff;">
                                    <span style="color:#E2CBAE;font-size:16px;">✓</span> Contabilidad completa al día
                                </li>
                            </ul>

                            <a href="/reserva" class="promo-premium-btn" style="display:block;text-align:center;text-decoration:none;border:none;width:100%;padding:18px;font-size:13px;letter-spacing:0.15em;border-radius:8px;">
                                RECLAMAR MI PLAZA
                            </a>

                            <p class="promo-premium-disclaimer" style="margin-top:20px;font-size:12px;color:#6a7a9a;">
                                Plazas limitadas. Promoción válida únicamente para nuevas altas sin permanencia.
                            </p>
                        </div>

                        <!-- Imagen (oculta en mobile via CSS) -->
                        <div class="promo-premium-image" style="background-image:url('https://images.unsplash.com/photo-1450101499163-c8848c66ca85?w=800&q=80');background-size:cover;background-position:center;position:relative;">
                            <div style="position:absolute;inset:0;background:rgba(21,31,43,0.35);"></div>
                        </div>

                    </div>
                </div>
            </div>
        </section>

        <!-- 5 · POR QUÉ ELEGIRNOS -->
        <section class="hx-section" id="por-que-elegirnos">
            <div class="hx-container">
                <div class="hx-head">
                    <div>
                        <span class="hx-eyebrow">Por qué elegirnos</span>
                        <h2 class="hx-title">¿Qué puedes <em>esperar?</em></h2>
                    </div>
                </div>
                <ol class="hx-reasons">
                    <li v-for="(g, i) in garantias" :key="g.titulo">
                        <span class="hx-reasons__n">0{{ i + 1 }}</span>
                        <h3>{{ g.titulo }}</h3>
                        <p>{{ g.desc }}</p>
                    </li>
                </ol>
            </div>
        </section>

        <!-- 6 · CONFIANZA: opiniones reales de Trustpilot (solo si está configurado) -->
        <TrustpilotWidget />

        <!-- 7 · LLAMADA A LA ACCIÓN -->
        <section class="hx-cta" id="contacto">
            <div class="hx-container hx-cta__grid">
                <div>
                    <h2 class="hx-title">¿No sabes si esto es para ti?<br><em>Cuéntanos tu situación y te asesoramos</em></h2>
                    <p class="hx-cta__lead">Primera consulta gratuita. En menos de 24 horas analizamos tu caso para ver si nuestra metodología encaja con tu negocio.</p>
                    <div class="hx-actions">
                        <Link href="/reserva" class="btn btn--primary">Solicitar consulta gratuita</Link>
                        <Link href="/contacto" class="link-arrow">Escríbenos</Link>
                    </div>
                </div>
                <dl class="hx-contact">
                    <div>
                        <dt>Teléfono</dt>
                        <dd><a :href="`tel:${contacto.telefono}`">{{ contacto.telefonoVisible }}</a></dd>
                    </div>
                    <div>
                        <dt>Horario de atención</dt>
                        <dd>{{ contacto.horario[0] }}<br>{{ contacto.horario[1] }}</dd>
                    </div>
                </dl>
            </div>
        </section>
    </PublicLayout>
</template>
