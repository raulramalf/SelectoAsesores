<script setup>
import PublicLayout from '@/Layouts/PublicLayout.vue'

const planes = [
    {
        nombre: 'Autónomos',
        target: 'Para particulares', 
        desc: 'Gestión fiscal completa y asesoramiento continuo para trabajadores por cuenta propia.',
        precio: '60',
        features: [
            'Alta en Hacienda y Seguridad Social',
            'Declaraciones trimestrales (IVA, IRPF)',
            'Asesoramiento contable y fiscal por WhatsApp',
            'Informes de rendimiento trimestral',
            'Consultas ilimitadas para resolver tus dudas'
        ],
        boton: 'Solicita tu alta'
    },
    {
        nombre: 'Empresas',
        target: 'Para Pymes',
        desc: 'Solución integral con contabilidad y gestión laboral adaptada a empresas.',
        precio: '200',
        destacado: true,
        features: [
            'Contabilidad adaptada al PGC',
            'Presentación de impuestos (mensual o trimestral)',
            'Gestión de nóminas y contratos, altas y bajas en la seguridad social',
            'Asesoramiento financiero, fiscal y estratégico',
            'Soporte continuo y visión proactiva'
        ],
        boton: 'Solicitar propuesta'
    },
    {
        nombre: 'Particulares',
        target: 'Para individuos',
        desc: 'Asesoramiento y gestión de trámites puntuales, rentas y herencias.',
        precio: '30',
        features: [
            'Declaración anual de la Renta (IRPF)',
            'Gestión de herencias y donaciones',
            'Impuestos de transmisiones patrimoniales (ITP)',
            'Tramitación de prestaciones sociales (paro, IMV...)',
            'Asesoramiento en seguros (vida, hogar, vehículos...)'
        ],
        boton: 'Quiero asesorarme'
    }
]

const servicios = [
    {
        nombre: 'Asesoría Contable',
        descripcion: 'Asesoría fiscal, contable y laboral para autónomos, pymes y emprendedores con confianza y profesionalismo.',
        items: [
            'Libros contables, conciliaciones, balances y seguimiento.', 
            'Informes mensuales o trimestrales.', 
            'Análisis y control financiero.'
        ]
    },
    {
        nombre: 'Asesoría Laboral',
        descripcion: 'Asesoría fiscal, contable y laboral para autónomos, pymes y emprendedores con confianza y profesionalismo.',
        items: [
            'Altas y bajas en Seguridad Social.', 
            'Nóminas, contratos y finiquitos.', 
            'Bonificaciones y bajas médicas.'
        ]
    },
    {
        nombre: 'Asesoría Fiscal',
        descripcion: 'Asesoría fiscal, contable y laboral para autónomos, pymes y emprendedores con confianza y profesionalismo.',
        items: [
            'IVA, IRPF, pagos fraccionados, modelo 130, 303, 390...', 
            'Impuestos de sociedades (IS)', 
            'Alta, baja y modificación censal (modelos 036/037)'
        ]
    },
    {
        nombre: 'Servicios particulares',
        descripcion: 'Asesoría fiscal, contable y laboral para autónomos, pymes y emprendedores con confianza y profesionalismo.',
        items: [
            'Declaración de la renta.', 
            'Herencias, donaciones, ITP.', 
            'Paro, IMV, prestaciones y seguros.', 
            'Transferencia de vehículos'
        ]
    }
]
</script>

<template>
    <PublicLayout>

        <!-- ═══ HEADER SERVICIOS ═══ -->
        <section style="background:#151F2B;padding:80px 64px 40px;text-align:center;border-bottom:1px solid rgba(255,255,255,.05);">
            <span style="font-size:11px;letter-spacing:.22em;text-transform:uppercase;color:#8a9ab5;display:block;margin-bottom:16px;">CATÁLOGO DE SERVICIOS</span>
            <h1 style="font-family:'Instrument Serif',serif;font-size:clamp(36px,5vw,56px);font-weight:400;color:#fff;line-height:1.15;margin-bottom:16px;">
                Especialistas en<br>
                <em style="color:#E2CBAE;font-style:italic;">gestión fiscal y contable</em>
            </h1>
            <p style="font-size:15px;color:#a0aabf;max-width:560px;margin:0 auto;line-height:1.75;font-weight:300;">
                Descubre cómo podemos ayudarte. Desde planes integrales hasta servicios específicos diseñados para cubrir todas las necesidades de tu negocio.
            </p>
        </section>

        <!-- ═══ SECCIÓN PLANES ═══ -->
        <section style="background:#1c2d3f;padding:72px 64px;">
            <div style="max-width:1160px;margin:0 auto;">
                <div style="text-align:center;margin-bottom:48px;">
                    <h2 style="font-family:'Instrument Serif',serif;font-size:36px;font-weight:400;color:#fff;margin-bottom:12px;">Nuestros Servicios</h2>
                    <p style="font-size:13px;color:#8a9ab5;">Transparencia total. Sin costes ocultos ni sorpresas a final de mes.</p>
                </div>

                <div style="display:grid;grid-template-columns:repeat(3,1fr);gap:24px;">
                    <div v-for="plan in planes" :key="plan.nombre"
                        :style="`background:#151F2B;border:1px solid ${plan.destacado ? 'rgba(226,203,174,.45)' : 'rgba(255,255,255,.06)'};border-radius:8px;padding:36px 32px;display:flex;flex-direction:column;position:relative;`">
                        
                        <div v-if="plan.destacado" style="position:absolute;top:-12px;left:50%;transform:translateX(-50%);background:#E2CBAE;color:#151F2B;padding:4px 16px;border-radius:100px;font-size:9px;font-weight:600;letter-spacing:.1em;text-transform:uppercase;">
                            Más Popular
                        </div>

                        <h3 style="font-family:'Instrument Serif',serif;font-size:26px;font-weight:400;color:#fff;margin-bottom:8px;text-align:center;">{{ plan.nombre }}</h3>
                        <p style="font-size:12px;color:#6a7a9a;line-height:1.65;margin-bottom:24px;min-height:40px;text-align:center;">{{ plan.desc }}</p>
                        
                        <ul style="list-style:none;padding:0;margin:0 0 32px 0;display:flex;flex-direction:column;gap:10px;flex:1;">
                            <li v-for="feat in plan.features" :key="feat" style="font-size:12px;color:#a0aabf;display:flex;align-items:flex-start;gap:8px;line-height:1.5;">
                                <span style="color:#E2CBAE;flex-shrink:0;font-size:10px;margin-top:2px;">◆</span>
                                {{ feat }}
                            </li>
                        </ul>

                        <div style="border-top:1px solid rgba(255,255,255,.06);padding-top:20px;margin-bottom:20px;text-align:center;">
                            <span style="font-size:11px;color:#6a7a9a;display:block;margin-bottom:4px;" v-if="plan.nombre !== 'Particulares'">Desde</span>
                            <div style="display:flex;align-items:baseline;justify-content:center;gap:6px;">
                                <span style="font-family:'Instrument Serif',serif;font-size:36px;font-weight:400;color:#fff;">{{ plan.precio }}€</span>
                                <span style="font-size:11px;color:#6a7a9a;" v-if="plan.nombre !== 'Particulares'">/ mes</span>
                            </div>
                        </div>

                        <a href="/reserva" :style="`display:block;text-align:center;padding:12px;border-radius:4px;font-size:11px;font-weight:500;letter-spacing:.12em;text-transform:uppercase;text-decoration:none;transition:all .2s;${plan.destacado ? 'background:#E2CBAE;color:#151F2B;' : 'background:transparent;border:1px solid rgba(226,203,174,.4);color:#E2CBAE;'}`"
                            @mouseover="!plan.destacado ? ($event.target.style.background='#E2CBAE', $event.target.style.color='#151F2B') : ($event.target.style.opacity='.85')"
                            @mouseout="!plan.destacado ? ($event.target.style.background='transparent', $event.target.style.color='#E2CBAE') : ($event.target.style.opacity='1')">
                            {{ plan.boton }}
                        </a>
                    </div>
                </div>
            </div>
        </section>

        <!-- ═══ SERVICIOS DETALLADOS (ESTÁTICOS) ═══ -->
        <section style="background:#151F2B;padding:80px 64px;">
            <div style="max-width:1160px;margin:0 auto;">
                <div style="margin-bottom:56px;border-bottom:1px solid rgba(255,255,255,.05);padding-bottom:24px;text-align:center;">
                    <h2 style="font-family:'Instrument Serif',serif;font-size:32px;font-weight:400;color:#fff;margin-bottom:16px;">
                        Nuestros Servicios
                    </h2>
                    <p style="font-size:15px;color:#a0aabf;line-height:1.75;">
                        Asesoría fiscal, contable y laboral para autónomos, pymes y emprendedores<br>con confianza y profesionalismo.
                    </p>
                </div>

                <div style="display:grid;grid-template-columns:repeat(2,1fr);gap:32px;">
                    <div v-for="srv in servicios" :key="srv.nombre"
                        style="background:#1c2d3f;border-left:3px solid #E2CBAE;border-radius:0 8px 8px 0;padding:32px 36px;">
                        
                        <h3 style="font-family:'Instrument Serif',serif;font-size:24px;font-weight:400;color:#fff;margin-bottom:20px;text-align:center;">{{ srv.nombre }}</h3>
                        
                        <!-- Lista cambiada para que sea en una sola columna hacia abajo, igual que en la imagen -->
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

        <!-- ═══ CTA FINAL ═══ -->
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