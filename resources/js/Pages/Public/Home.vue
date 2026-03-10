<script setup>
import PublicLayout from '@/Layouts/PublicLayout.vue'

const servicios = [
    {
        nombre: 'Declaración de la Renta',
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

const planes = [
    {
        tag: 'PLAN BÁSICO',
        subtitulo: 'Para particulares',
        descripcion: 'Ideal para autónomos que empiezan y particulares con declaración anual.',
        precio: 60,
        features: ['Declaración de la Renta (IRPF)', 'Consultas fiscales básicas (hasta 2/mes)', 'Acceso al dashboard cliente', 'Gestión de notificaciones y citas'],
        destacado: false
    },
    {
        tag: 'PLAN PROFESIONAL',
        subtitulo: 'Para autónomos',
        descripcion: 'El plan más completo para autónomos con actividad económica regular.',
        precio: 120,
        features: ['Todo lo del plan básico', 'Declaraciones trimestrales (IVA, IRPF)', 'Gestión de autónomos', 'Consultas ilimitadas', 'Informes fiscales mensuales', 'Análisis de rendimiento básico'],
        destacado: true
    },
    {
        tag: 'PLAN EMPRESA',
        subtitulo: 'Para Pymes',
        descripcion: 'Solución integral para empresas con contabilidad completa y asesor dedicado.',
        precio: 200,
        features: ['Todo lo del plan profesional', 'Contabilidad completa de empresa', 'Constitución de sociedades', 'Planificación fiscal anual', 'Informe de rendimiento empresarial semanal', 'Asesor personal asignado', 'Prioridad en respuesta (24h)'],
        destacado: false
    },
]

const testimonios = [
    {
        nombre: 'Marco Ramírez',
        texto: 'Lo que más valoro es la agilidad. Tener un asesor personal asignado que conoce mi histórico y responde en menos de 24 horas marca la diferencia entre un gestor común y un servicio de élite.',
        avatar: '👨‍💼'
    },
    {
        nombre: 'Marta Ramírez',
        texto: 'La planificación fiscal estratégica que ofrecen no es un gasto, es una inversión. Gracias a su análisis con IA, hemos optimizado costes que ni siquiera habíamos detectado. Son el socio que toda gran empresa necesita.',
        avatar: '👩‍💼'
    },
]
</script>

<template>
    <PublicLayout>

        <!-- HERO -->
        <section style="position:relative;overflow:hidden;min-height:340px;display:flex;align-items:center;">
            <div style="position:absolute;inset:0;background:url('https://images.unsplash.com/photo-1589829545856-d10d557cf95f?w=1400&q=80') center/cover no-repeat;"></div>
            <div style="position:absolute;inset:0;background:rgba(20,30,60,.72);"></div>
            <div style="position:relative;z-index:2;padding:64px 56px;max-width:600px;">
                <h1 style="font-family:'Cormorant Garamond',serif;font-size:36px;font-weight:700;color:#c8a864;letter-spacing:.06em;margin-bottom:16px;text-transform:uppercase;">SELECTO ASESORES</h1>
                <p style="font-size:15px;color:#e0e8f0;line-height:1.75;margin-bottom:28px;">Asesoría fiscal personalizada para autónomos, pymes y empresas.<br>Gestionamos tu contabilidad, declaraciones y obligaciones tributarias con precisión y total tranquilidad.</p>
                <a href="/reserva" style="display:inline-block;background:#c8a864;color:#0f1a2e;padding:12px 28px;border-radius:4px;font-size:13px;font-weight:600;letter-spacing:.1em;text-transform:uppercase;text-decoration:none;">SOLICITA TU PLAZA</a>
            </div>
        </section>

        <!-- NUESTROS SERVICIOS TÍTULO -->
        <section style="background:#1a2744;padding:64px 56px 0;">
            <div style="text-align:center;margin-bottom:8px;">
                <span style="font-size:11px;font-weight:500;letter-spacing:.22em;text-transform:uppercase;color:#a0aabf;display:block;margin-bottom:16px;">NUESTROS SERVICIOS</span>
                <h2 style="font-family:'Cormorant Garamond',serif;font-size:clamp(32px,4vw,52px);font-weight:600;color:#fff;line-height:1.1;margin-bottom:12px;">
                    Todo lo que tu empresa<br><em style="color:#c8a864;font-style:italic;">necesita en un solo lugar</em>
                </h2>
                <p style="font-size:14px;color:#6a7a9a;max-width:580px;margin:0 auto 48px;line-height:1.7;">"Asesoría fiscal integral para autónomos, pymes y empresas. Gestionamos tu fiscalidad para que tú te centres en crecer."</p>
            </div>
        </section>

        <!-- PLANES -->
        <section style="background:#1a2744;padding:0 56px 64px;">
            <div style="display:grid;grid-template-columns:repeat(3,1fr);gap:20px;max-width:1060px;margin:0 auto;">
                <div v-for="plan in planes" :key="plan.tag"
                    :style="plan.destacado
                        ? 'background:#1c2840;border:1px solid rgba(200,168,100,.4);border-radius:10px;padding:32px 28px;'
                        : 'background:#1c2840;border:1px solid rgba(255,255,255,.07);border-radius:10px;padding:32px 28px;'">
                    <div style="display:flex;align-items:center;gap:12px;margin-bottom:8px;">
                        <div :style="plan.destacado
                            ? 'background:#c8a864;border-radius:50%;width:36px;height:36px;display:flex;align-items:center;justify-content:center;font-family:Cormorant Garamond,serif;font-size:16px;font-weight:700;color:#0f1a2e;flex-shrink:0;'
                            : 'background:rgba(200,168,100,.15);border-radius:50%;width:36px;height:36px;display:flex;align-items:center;justify-content:center;font-family:Cormorant Garamond,serif;font-size:16px;font-weight:700;color:#c8a864;flex-shrink:0;'">
                            {{ plan.precio }}
                        </div>
                        <span style="font-size:11px;font-weight:600;letter-spacing:.14em;text-transform:uppercase;color:#c8a864;">{{ plan.tag }}</span>
                    </div>
                    <h3 style="font-family:'Cormorant Garamond',serif;font-size:18px;font-weight:600;color:#fff;margin-bottom:6px;">{{ plan.subtitulo }}</h3>
                    <p style="font-size:12px;color:#6a7a9a;line-height:1.6;margin-bottom:16px;">{{ plan.descripcion }}</p>
                    <ul style="list-style:none;padding:0;margin:0 0 20px;display:flex;flex-direction:column;gap:6px;">
                        <li v-for="f in plan.features" :key="f" style="font-size:12px;color:#a0aabf;display:flex;align-items:flex-start;gap:8px;line-height:1.4;">
                            <span style="color:#c8a864;flex-shrink:0;">•</span>{{ f }}
                        </li>
                    </ul>
                    <div style="border-top:1px solid rgba(255,255,255,.06);padding-top:16px;margin-bottom:16px;">
                        <span style="font-family:'Cormorant Garamond',serif;font-size:28px;font-weight:700;color:#fff;">{{ plan.precio }} €</span>
                        <span style="font-size:12px;color:#6a7a9a;"> / mes + IVA</span>
                    </div>
                    <a href="/reserva" :style="plan.destacado
                        ? 'display:block;text-align:center;background:#c8a864;color:#0f1a2e;padding:10px;border-radius:5px;font-size:11px;font-weight:600;letter-spacing:.1em;text-transform:uppercase;text-decoration:none;'
                        : 'display:block;text-align:center;background:transparent;border:1px solid rgba(200,168,100,.4);color:#c8a864;padding:10px;border-radius:5px;font-size:11px;font-weight:600;letter-spacing:.1em;text-transform:uppercase;text-decoration:none;'">
                        SELECCIONAR
                    </a>
                </div>
            </div>
        </section>

        <!-- SERVICIOS DETALLADOS -->
        <section style="background:#232f4b;padding:64px 56px;">
            <div style="display:grid;grid-template-columns:repeat(3,1fr);gap:20px;max-width:1160px;margin:0 auto;">
                <div v-for="srv in servicios" :key="srv.nombre"
                    style="background:#1c2840;border:1px solid rgba(255,255,255,.07);border-radius:10px;padding:28px 24px;">
                    <h3 style="font-family:'Cormorant Garamond',serif;font-size:18px;font-weight:600;color:#fff;margin-bottom:10px;">{{ srv.nombre }}</h3>
                    <p style="font-size:12px;color:#6a7a9a;line-height:1.7;margin-bottom:16px;">{{ srv.descripcion }}</p>
                    <ul style="list-style:none;padding:0;margin:0;display:flex;flex-direction:column;gap:6px;">
                        <li v-for="item in srv.items" :key="item" style="font-size:12px;color:#a0aabf;display:flex;align-items:flex-start;gap:8px;">
                            <span style="color:#c8a864;flex-shrink:0;">✓</span>{{ item }}
                        </li>
                    </ul>
                </div>
            </div>
        </section>

        <!-- TESTIMONIOS -->
        <section style="background:#1a2744;padding:64px 56px;">
            <div style="text-align:center;margin-bottom:40px;">
                <span style="font-size:11px;font-weight:500;letter-spacing:.22em;text-transform:uppercase;color:#a0aabf;">NUESTROS CLIENTES</span>
            </div>
            <div style="display:grid;grid-template-columns:repeat(2,1fr);gap:20px;max-width:960px;margin:0 auto;">
                <div v-for="t in testimonios" :key="t.nombre"
                    style="background:#fff;border-radius:10px;padding:28px 24px;display:flex;align-items:flex-start;gap:16px;">
                    <div style="width:56px;height:56px;border-radius:50%;overflow:hidden;background:#e0e8f0;display:flex;align-items:center;justify-content:center;font-size:28px;flex-shrink:0;">{{ t.avatar }}</div>
                    <div>
                        <p style="font-size:14px;color:#1a2744;font-weight:600;margin-bottom:8px;">{{ t.nombre }}</p>
                        <p style="font-size:13px;color:#4a5568;line-height:1.7;font-style:italic;">"{{ t.texto }}"</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- CTA -->
        <section style="background:#232f4b;padding:72px 56px;text-align:center;">
            <h2 style="font-family:'Cormorant Garamond',serif;font-size:clamp(28px,3.5vw,44px);font-weight:600;color:#fff;line-height:1.2;margin-bottom:8px;">
                ¿No sabes qué necesitas?<br>
                <em style="color:#c8a864;font-style:italic;">Cuéntanos tu situación y te asesoramos sin compromiso</em>
            </h2>
            <p style="font-size:14px;color:#6a7a9a;margin:16px auto 32px;max-width:480px;line-height:1.7;">Primera consulta gratuita. En menos de 24 horas te explicamos qué servicio se adapta mejor a tu caso.</p>
            <a href="/reserva" style="display:inline-block;background:#c8a864;color:#0f1a2e;padding:15px 48px;border-radius:100px;font-size:13px;font-weight:600;letter-spacing:.1em;text-transform:uppercase;text-decoration:none;margin-bottom:16px;">SOLICITAR CONSULTA GRATUITA</a>
            <p style="font-size:13px;color:#6a7a9a;">O llámanos al <a href="tel:555555555" style="color:#a0aabf;text-decoration:none;">555-555-555</a></p>
        </section>

    </PublicLayout>
</template>