// Datos de servicios y tarifas (fuente única para Inicio y Servicios).
export const planes = [
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
        desc: 'Acompañamiento personal en cada trámite: rentas, herencias, prestaciones y gestiones del día a día, explicado en un lenguaje que entiendas.',
        precio: '30',
        features: [
            'Declaración anual de la Renta (IRPF), con revisión de deducciones aplicables',
            'Gestión de herencias, donaciones y particiones entre herederos',
            'Impuestos de transmisiones patrimoniales (ITP) en compraventas',
            'Tramitación de prestaciones sociales (paro, IMV, jubilación...)',
            'Asesoramiento y comparativa en seguros (vida, hogar, vehículos...)',
            'Gestión de transferencias y cambios de titularidad de vehículos',
            'Atención personalizada por videollamada, teléfono o WhatsApp'
        ],
        boton: 'Quiero asesorarme'
    }
]

export const servicios = [
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
        descripcion: 'Gestión y acompañamiento cercano para las necesidades fiscales y administrativas de cualquier persona, con el mismo rigor que aplicamos a las empresas.',
        items: [
            'Declaración de la Renta (IRPF): revisión de borrador, deducciones autonómicas y optimización.',
            'Herencias y donaciones: cálculo y presentación del impuesto, reparto entre herederos.',
            'Impuesto de Transmisiones Patrimoniales (ITP) en compraventa de vivienda o vehículos.',
            'Prestaciones sociales: solicitud de paro, IMV, jubilación y otras ayudas públicas.',
            'Asesoramiento y comparativa de seguros personales (vida, hogar, vehículos).',
            'Transferencia y cambio de titularidad de vehículos ante Tráfico.',
            'Gestión de alquileres: contratos, fianzas y declaración de rendimientos.'
        ]
    }
]
