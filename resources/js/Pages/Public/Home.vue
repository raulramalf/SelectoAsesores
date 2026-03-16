<script setup>
import PublicLayout from '@/Layouts/PublicLayout.vue'
import Promopopup from './Promopopup.vue'; // Importación del componente

const planes = [
    {
        tag: 'Plan Básico',
        subtitulo: 'Para particulares',
        precio: 60,
        destacado: false,
        descripcion: 'Ideal para autónomos que empiezan y particulares con declaración anual.',
        features: [
            'Declaración de la Renta (IRPF)',
            'Consultas fiscales básicas (hasta 2/mes)',
            'Acceso al dashboard cliente',
            'Gestión de notificaciones y citas',
        ],
    },
    {
        tag: 'Plan Profesional',
        subtitulo: 'Para autónomos',
        precio: 120,
        destacado: true,
        descripcion: 'El plan más completo para autónomos con actividad económica regular.',
        features: [
            'Todo lo del plan básico',
            'Declaraciones trimestrales (IVA, IRPF)',
            'Gestión de autónomos',
            'Consultas ilimitadas',
            'Informes fiscales mensuales',
            'Análisis de rendimiento básico',
        ],
    },
    {
        tag: 'Plan Empresa',
        subtitulo: 'Para Pymes',
        precio: 200,
        destacado: false,
        descripcion: 'Solución integral para empresas con contabilidad completa y asesor dedicado.',
        features: [
            'Todo lo del plan profesional',
            'Contabilidad completa de empresa',
            'Constitución de sociedades',
            'Planificación fiscal anual',
            'Informe de rendimiento semanal',
            'Asesor personal asignado',
            'Prioridad en respuesta (24h)',
        ],
    },
]

const servicios = [
    {
        nombre: 'Declaración de la Renta',
        descripcion: 'Presentamos tu IRPF de forma óptima, aplicando todas las deducciones posibles para reducir al máximo tu carga fiscal de manera legal.',
        items: ['IRPF anual y declaraciones complementarias', 'Revisión de ejercicios anteriores', 'Deducciones por vivienda, hijos e inversiones', 'Gestión de rentas del capital y ganancias patrimoniales'],
    },
    {
        nombre: 'Asesoría fiscal integral',
        descripcion: 'Gestión completa de todas tus obligaciones fiscales. Planificación estratégica, presentación de impuestos y optimización tributaria.',
        items: ['IVA trimestral e Impuesto de Sociedades', 'Planificación fiscal anual personalizada', 'Representación ante la Agencia Tributaria', 'Informes fiscales mensuales detallados'],
    },
    {
        nombre: 'Contabilidad de empresa',
        descripcion: 'Llevamos la contabilidad de tu negocio al día, garantizando el cumplimiento del Plan General Contable.',
        items: ['Registro de facturas y asientos contables', 'Elaboración de cuentas anuales y balances', 'Informes de resultados mensuales', 'Conciliaciones bancarias y control de tesorería'],
    },
    {
        nombre: 'Gestión de Autónomos',
        descripcion: 'Simplificamos toda la gestión fiscal y administrativa de tu actividad como autónomo.',
        items: ['Alta en Hacienda y Seguridad Social', 'Declaraciones trimestrales de IVA e IRPF', 'Facturación y gestión de gastos deducibles', 'Asesoramiento en cuota de autónomos'],
    },
    {
        nombre: 'Constitución de Sociedades',
        descripcion: 'Te acompañamos en todo el proceso de creación de tu empresa, desde la elección de la forma jurídica hasta la inscripción registral.',
        items: ['Asesoramiento en la forma jurídica óptima', 'Redacción de estatutos y escritura de constitución', 'Trámites con el Registro Mercantil', 'Alta censal y obtención del NIF definitivo'],
    },
    {
        nombre: 'Consultoría Tributaria',
        descripcion: 'Análisis exhaustivo de tu situación fiscal para identificar riesgos y prepararte ante posibles inspecciones de Hacienda.',
        items: ['Revisión y diagnóstico de riesgos fiscales', 'Respuesta a requerimientos de la AEAT', 'Recursos y reclamaciones económico-administrativas', 'Planificación ante inspecciones tributarias'],
    },
]

const testimonios = [
    {
        nombre: 'Marco Ramírez',
        foto: '',
        texto: 'Lo que más valoro es la agilidad. Tener un asesor personal asignado que conoce mi histórico y responde en menos de 24 horas marca la diferencia entre un gestor común y un servicio de élite.',
    },
    {
        nombre: 'Marta Ramírez',
        foto: '',
        texto: 'La planificación fiscal estratégica que ofrecen no es un gasto, es una inversión. Gracias a su análisis con IA, hemos optimizado costes que ni siquiera habíamos detectado. Son el socio que toda gran empresa necesita.',
    },
]
</script>

<template>
    <PublicLayout>

        <section class="hero">
            <div class="hero__bg"></div>
            <div class="hero__overlay"></div>
            <div class="hero__content">
                <h1 class="hero__title">Selecto Asesores</h1>
                <p class="hero__text">
                    Asesoría fiscal personalizada para autónomos, pymes y empresas.<br>
                    Gestionamos tu contabilidad, declaraciones y obligaciones tributarias con precisión y total tranquilidad.
                </p>
                <a href="/reserva" class="hero__btn">Solicita tu plaza</a>
            </div>
        </section>

        <section class="section-header">
            <span class="section-tag">Nuestros servicios</span>
            <h2 class="section-title">
                Todo lo que tu empresa<br>
                <em>necesita en un solo lugar</em>
            </h2>
            <p class="section-subtitle">"Asesoría fiscal integral para autónomos, pymes y empresas. Gestionamos tu fiscalidad para que tú te centres en crecer."</p>
        </section>

        <section class="planes">
            <div class="planes__grid">
                <div
                    v-for="plan in planes"
                    :key="plan.tag"
                    :class="['plan-card', plan.destacado && 'plan-card--destacado']"
                >
                    <div class="plan-card__header">
                        <div :class="['plan-card__badge', plan.destacado && 'plan-card__badge--gold']">
                            {{ plan.precio }}
                        </div>
                        <span class="plan-card__tag">{{ plan.tag }}</span>
                    </div>
                    <h3 class="plan-card__nombre">{{ plan.subtitulo }}</h3>
                    <p class="plan-card__desc">{{ plan.descripcion }}</p>
                    <ul class="plan-card__features">
                        <li v-for="f in plan.features" :key="f">
                            <span>•</span> {{ f }}
                        </li>
                    </ul>
                    <div class="plan-card__precio">
                        <strong>{{ plan.precio }} €</strong>
                        <span>/ mes + IVA</span>
                    </div>
                    <a href="/reserva" :class="['plan-card__btn', plan.destacado && 'plan-card__btn--gold']">
                        Seleccionar
                    </a>
                </div>
            </div>
        </section>

        <section class="servicios-detalle">
            <div class="servicios-detalle__grid">
                <div v-for="srv in servicios" :key="srv.nombre" class="servicio-card">
                    <h3 class="servicio-card__titulo">{{ srv.nombre }}</h3>
                    <p class="servicio-card__desc">{{ srv.descripcion }}</p>
                    <ul class="servicio-card__list">
                        <li v-for="item in srv.items" :key="item">
                            <span>✓</span> {{ item }}
                        </li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="testimonios">
            <div style="text-align:center;margin-bottom:48px;">
                <span class="section-tag">Nuestros clientes</span>
            </div>
            <div class="testimonios__grid">
                <div v-for="t in testimonios" :key="t.nombre" class="testimonio-card">
                    <img :src="t.foto" :alt="t.nombre" class="testimonio-card__foto">
                    <div>
                        <p class="testimonio-card__nombre">{{ t.nombre }}</p>
                        <p class="testimonio-card__texto">"{{ t.texto }}"</p>
                    </div>
                </div>
            </div>
        </section>

        <section class="cta">
            <h2 class="cta__titulo">
                ¿No sabes qué necesitas?<br>
                <em>Cuéntanos tu situación y te asesoramos sin compromiso</em>
            </h2>
            <p class="cta__texto">Primera consulta gratuita. En menos de 24 horas te explicamos qué servicio se adapta mejor a tu caso.</p>
            <a href="/reserva" class="cta__btn">Solicitar consulta gratuita</a>
            <p class="cta__tel">O llámanos al <a href="tel:555555555">555-555-555</a></p>
        </section>

        <Promopopup />

    </PublicLayout>
</template>