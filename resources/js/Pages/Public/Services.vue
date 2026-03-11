<script setup>
import PublicLayout from '@/Layouts/PublicLayout.vue'

const servicios = [
    {
        nombre: 'Declaración de la renta',
        descripcion: 'Presentamos tu IRPF de forma óptima, aplicando todas las deducciones posibles para reducir al máximo tu carga fiscal de manera legal.',
        items: ['IRPF anual y declaraciones complementarias', 'Revisión de ejercicios anteriores', 'Deducciones por vivienda, hijos e inversiones', 'Gestión de rentas del capital y ganancias patrimoniales']
    },
    {
        nombre: 'Asesoría fiscal integral',
        descripcion: 'Gestión completa de todas tus obligaciones fiscales. Planificación estratégica, presentación de impuestos y optimización tributaria para tu empresa.',
        items: ['IVA trimestral e Impuesto de Sociedades', 'Planificación fiscal anual personalizada', 'Representación ante la Agencia Tributaria', 'Informes fiscales mensuales detallados']
    },
    {
        nombre: 'Contabilidad de empresa',
        descripcion: 'Llevamos la contabilidad de tu negocio al día, garantizando el cumplimiento del Plan General Contable y la fiabilidad de tus cuentas en todo momento.',
        items: ['Registro de facturas y asientos contables', 'Elaboración de cuentas anuales y balances', 'Informes de resultados mensuales', 'Conciliaciones bancarias y control de tesorería']
    },
    {
        nombre: 'Gestión de Autónomos',
        descripcion: 'Simplificamos toda la gestión fiscal y administrativa de tu actividad como autónomo para que puedas centrarte en tu negocio.',
        items: ['Alta en Hacienda y Seguridad Social', 'Declaraciones trimestrales de IVA e IRPF', 'Facturación y gestión de gastos deducibles', 'Asesoramiento en cuota de autónomos']
    },
    {
        nombre: 'Constitución de Sociedades',
        descripcion: 'Te acompañamos en todo el proceso de creación de tu empresa, desde la elección de la forma jurídica hasta la inscripción registral.',
        items: ['Asesoramiento en la forma jurídica óptima', 'Redacción de estatutos y escritura de constitución', 'Trámites con el Registro Mercantil', 'Alta censal y obtención del NIF definitivo']
    },
    {
        nombre: 'Consultoría Tributaria',
        descripcion: 'Análisis exhaustivo de tu situación fiscal para identificar riesgos, optimizar tu tributación y prepararte ante posibles inspecciones de Hacienda.',
        items: ['Revisión y diagnóstico de riesgos fiscales', 'Respuesta a requerimientos de la AEAT', 'Recursos y reclamaciones económico administrativas', 'Planificación ante inspecciones tributarias']
    },
]
</script>

<template>
    <PublicLayout>

        <!-- HEADER -->
        <section style="background:#243345;padding:64px 64px 48px;text-align:center;">
            <span style="font-size:10px;letter-spacing:.22em;text-transform:uppercase;color:#8a9ab5;display:block;margin-bottom:14px;">NUESTROS SERVICIOS</span>
            <h1 style="font-family:'Instrument Serif',serif;font-size:clamp(32px,4vw,52px);font-weight:400;color:#fff;line-height:1.15;margin-bottom:12px;">
                Todo lo que tu empresa<br>
                <em style="color:#D4AF37;font-style:italic;">necesita en un solo lugar</em>
            </h1>
            <p style="font-size:13px;color:#6a7a9a;max-width:520px;margin:0 auto;line-height:1.75;font-style:italic;">
                "Asesoría fiscal integral para autónomos, pymes y empresas. Gestionamos tu fiscalidad para que tú te centres en crecer."
            </p>
        </section>

        <!-- GRID SERVICIOS -->
        <section style="background:#151F2B;padding:56px 64px 72px;">
            <div style="display:grid;grid-template-columns:repeat(3,1fr);gap:16px;max-width:1160px;margin:0 auto;">
                <div v-for="srv in servicios" :key="srv.nombre"
                    style="background:#1c2d3f;border:1px solid rgba(255,255,255,.06);border-radius:6px;padding:28px 24px;">
                    <h3 style="font-family:'Instrument Serif',serif;font-size:17px;font-weight:400;color:#fff;margin-bottom:10px;">{{ srv.nombre }}</h3>
                    <p style="font-size:12px;color:#6a7a9a;line-height:1.75;margin-bottom:16px;">{{ srv.descripcion }}</p>
                    <ul style="list-style:none;padding:0;margin:0;display:flex;flex-direction:column;gap:7px;">
                        <li v-for="item in srv.items" :key="item" style="font-size:12px;color:#a0aabf;display:flex;align-items:flex-start;gap:8px;line-height:1.5;">
                            <span style="color:#D4AF37;flex-shrink:0;">✓</span>{{ item }}
                        </li>
                    </ul>
                </div>
            </div>
        </section>

        <!-- CTA -->
        <section style="background:#243345;padding:72px 64px;text-align:center;">
            <h2 style="font-family:'Instrument Serif',serif;font-size:clamp(26px,3vw,40px);font-weight:400;color:#fff;line-height:1.25;margin-bottom:10px;">
                ¿No sabes qué necesitas?<br>
                <em style="color:#D4AF37;">Cuéntanos tu situación y te asesoramos sin compromiso</em>
            </h2>
            <p style="font-size:13px;color:#6a7a9a;margin:16px auto 32px;max-width:460px;line-height:1.75;">
                Primera consulta gratuita. En menos de 24 horas te explicamos qué servicio se adapta mejor a tu caso.
            </p>
            <a href="/reserva" style="display:inline-block;background:#D4AF37;color:#151F2B;padding:14px 48px;border-radius:100px;font-size:12px;font-weight:500;letter-spacing:.1em;text-transform:uppercase;text-decoration:none;">
                SOLICITAR CONSULTA GRATUITA
            </a>
            <p style="font-size:13px;color:#6a7a9a;margin-top:14px;">O llámanos al <a href="tel:555555555" style="color:#8a9ab5;text-decoration:none;">555-555-555</a></p>
        </section>

    </PublicLayout>
</template>