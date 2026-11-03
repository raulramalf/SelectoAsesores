<script setup>
import PublicLayout from '@/Layouts/PublicLayout.vue'

import { planes, servicios } from '@/data/servicios'
</script>

<template>
    <PublicLayout>

        <section class="page-hero">
            <div class="hx-container">
                <span class="hx-eyebrow">Catálogo de servicios</span>
                <h1>Especialistas en<br><em>gestión fiscal y contable</em></h1>
                <p>Descubre cómo podemos ayudarte. Desde planes integrales hasta servicios específicos diseñados para cubrir todas las necesidades de tu negocio.</p>
            </div>
        </section>

        <section style="background:#1c2d3f;padding:72px 64px;">
            <div style="max-width:1160px;margin:0 auto;">
                <div style="text-align:left;margin-bottom:48px;">
                    <h2 style="font-family:'Instrument Serif',serif;font-size:36px;font-weight:400;color:#fff;margin-bottom:12px;">Nuestros Servicios</h2>
                    <p style="font-size:13px;color:#8a9ab5;">Transparencia total. Sin costes ocultos ni sorpresas a final de mes.</p>
                </div>

                <div style="display:grid;grid-template-columns:repeat(3,1fr);gap:24px;">
                    <div v-for="plan in planes" :key="plan.nombre"
                        :style="`background:#151F2B;border:1px solid ${plan.destacado ? 'rgba(226,203,174,.45)' : 'rgba(255,255,255,.06)'};border-radius:8px;padding:36px 32px;display:flex;flex-direction:column;position:relative;`">
                        
                        <div v-if="plan.destacado" style="position:absolute;top:-12px;left:50%;transform:translateX(-50%);background:#E2CBAE;color:#151F2B;padding:4px 16px;border-radius:100px;font-size:9px;font-weight:600;letter-spacing:.1em;text-transform:uppercase;">
                            Más Popular
                        </div>

                        <h3 style="font-family:'Instrument Serif',serif;font-size:26px;font-weight:400;color:#fff;margin-bottom:8px;text-align:left;">{{ plan.nombre }}</h3>
                        <p style="font-size:12px;color:#6a7a9a;line-height:1.65;margin-bottom:24px;min-height:40px;text-align:left;">{{ plan.desc }}</p>
                        
                        <ul style="list-style:none;padding:0;margin:0 0 32px 0;display:flex;flex-direction:column;gap:10px;flex:1;">
                            <li v-for="feat in plan.features" :key="feat" style="font-size:12px;color:#a0aabf;display:flex;align-items:flex-start;gap:8px;line-height:1.5;">
                                <span style="color:#E2CBAE;flex-shrink:0;font-size:10px;margin-top:2px;">◆</span>
                                {{ feat }}
                            </li>
                        </ul>

                        <div style="border-top:1px solid rgba(255,255,255,.06);padding-top:20px;margin-bottom:20px;text-align:left;">
                            <span style="font-size:11px;color:#6a7a9a;display:block;margin-bottom:4px;" v-if="plan.nombre !== 'Particulares'">Desde</span>
                            <div style="display:flex;align-items:baseline;justify-content:flex-start;gap:6px;">
                                <span style="font-family:'Instrument Serif',serif;font-size:36px;font-weight:400;color:#fff;">{{ plan.precio }}€</span>
                                <span style="font-size:11px;color:#6a7a9a;" v-if="plan.nombre !== 'Particulares'">/ mes</span>
                            </div>
                        </div>

                        <a href="/reserva" :style="`display:block;text-align:left;padding:12px;border-radius:4px;font-size:11px;font-weight:500;letter-spacing:.12em;text-transform:uppercase;text-decoration:none;transition:all .2s;${plan.destacado ? 'background:#E2CBAE;color:#151F2B;' : 'background:transparent;border:1px solid rgba(226,203,174,.4);color:#E2CBAE;'}`"
                            @mouseover="!plan.destacado ? ($event.target.style.background='#E2CBAE', $event.target.style.color='#151F2B') : ($event.target.style.opacity='.85')"
                            @mouseout="!plan.destacado ? ($event.target.style.background='transparent', $event.target.style.color='#E2CBAE') : ($event.target.style.opacity='1')">
                            {{ plan.boton }}
                        </a>
                    </div>
                </div>
            </div>
        </section>

        <section style="background:#151F2B;padding:80px 64px;">
            <div style="max-width:1160px;margin:0 auto;">
                <div style="margin-bottom:56px;border-bottom:1px solid rgba(255,255,255,.05);padding-bottom:24px;text-align:left;">
                    <h2 style="font-family:'Instrument Serif',serif;font-size:32px;font-weight:400;color:#fff;margin-bottom:16px;">
                        Servicios en detalle
                    </h2>
                    <p style="font-size:15px;color:#a0aabf;line-height:1.75;">
                        Asesoría fiscal, contable y laboral para autónomos, pymes y emprendedores<br>con confianza y profesionalismo.
                    </p>
                </div>

                <div style="display:grid;grid-template-columns:repeat(2,1fr);gap:32px;">
                    <div v-for="srv in servicios" :key="srv.nombre"
                        style="background:#1c2d3f;border-left:3px solid #E2CBAE;border-radius:0 8px 8px 0;padding:32px 36px;">
                        
                        <h3 style="font-family:'Instrument Serif',serif;font-size:24px;font-weight:400;color:#fff;margin-bottom:20px;text-align:left;">{{ srv.nombre }}</h3>
                        
                        <div style="display:flex;flex-direction:column;gap:12px;">
                            <div v-for="item in srv.items" :key="item" style="font-size:12px;color:#a0aabf;display:flex;align-items:flex-start;gap:8px;line-height:1.4;">
                                <span style="color:#E2CBAE;flex-shrink:0;">•</span>
                                {{ item }}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section style="background:#243345;padding:72px 64px;text-align:center;border-top:1px solid rgba(255,255,255,.05);">
            <h2 style="font-family:'Instrument Serif',serif;font-size:clamp(28px,3vw,42px);font-weight:400;color:#fff;line-height:1.2;margin-bottom:16px;">
                ¿Hablamos sobre<br>
                <em style="color:#E2CBAE;">el futuro de tu negocio?</em>
            </h2>
            <a href="/reserva" style="display:inline-block;background:#E2CBAE;color:#151F2B;padding:14px 42px;border-radius:100px;font-size:12px;font-weight:600;letter-spacing:.12em;text-transform:uppercase;text-decoration:none;transition:opacity .2s;margin-top:16px;"
                onmouseover="this.style.opacity='.85'" onmouseout="this.style.opacity='1'">
                Solicitar Cita
            </a>
        </section>

    </PublicLayout>
</template>