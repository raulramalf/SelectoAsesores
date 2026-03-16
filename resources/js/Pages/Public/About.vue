<script setup>
import PublicLayout from '@/Layouts/PublicLayout.vue'

const equipo = [
    {
        nombre: 'Carlos Martínez',
        rol: 'Director y Asesor Fiscal',
        bio: 'Licenciado en Derecho Tributario, especializado en fiscalidad empresarial y planificación tributaria con más de 15 años de experiencia.',
        inicial: 'C',
    },
    {
        nombre: 'Laura Gómez',
        rol: 'Asesora Financiera',
        bio: 'Graduada en ADE con especialización en contabilidad empresarial y elaboración de cuentas anuales para empresas de todos los sectores.',
        inicial: 'L',
    },
    {
        nombre: 'Javier Ruiz',
        rol: 'Asesor Fiscal',
        bio: 'Especialista en autónomos y pymes, con amplio conocimiento en constitución de sociedades y gestión tributaria integral.',
        inicial: 'J',
    },
]

const proceso = [
    {
        numero: '01',
        titulo: 'Primera consulta',
        texto: 'Analizamos tu situación fiscal de forma gratuita y sin compromiso para entender qué necesitas.',
    },
    {
        numero: '02',
        titulo: 'Plan personalizado',
        texto: 'Diseñamos una estrategia fiscal adaptada a tu actividad, tamaño y objetivos empresariales.',
    },
    {
        numero: '03',
        titulo: 'Gestión continua',
        texto: 'Nos encargamos de toda la burocracia fiscal para que tú te centres en hacer crecer tu negocio.',
    },
    {
        numero: '04',
        titulo: 'Seguimiento',
        texto: 'Tu asesor personal está siempre disponible para resolver dudas y anticiparse a cambios normativos.',
    },
]
</script>

<template>
    <PublicLayout>

        <!-- ═══ HERO ═══ -->
        <section style="position:relative;overflow:hidden;min-height:460px;display:flex;align-items:center;">
            <div style="position:absolute;inset:0;">
                <img src="https://images.unsplash.com/photo-1554224155-8d04cb21cd6c?w=1600&q=80"
                    alt="nosotros" style="width:100%;height:100%;object-fit:cover;object-position:center;filter:grayscale(20%);">
            </div>
            <div style="position:absolute;inset:0;background:linear-gradient(105deg,rgba(21,31,43,.97) 45%,rgba(21,31,43,.6) 100%);"></div>

            <div style="position:relative;z-index:2;padding:80px 64px;width:100%;max-width:1100px;">
                <span style="font-size:10px;letter-spacing:.22em;text-transform:uppercase;color:#8a9ab5;display:block;margin-bottom:14px;">SOBRE NOSOTROS</span>
                <h1 style="font-family:'Instrument Serif',serif;font-size:clamp(36px,4vw,58px);font-weight:400;color:#fff;line-height:1.1;margin-bottom:20px;max-width:600px;">
                    Una nueva forma<br>
                    <em style="color:#D4AF37;">de entender la asesoría</em>
                </h1>
                <p style="font-size:14px;color:#a0aabf;line-height:1.85;max-width:520px;font-weight:300;">
                    Selecto Asesores nace con una visión clara: ofrecer un servicio fiscal moderno, cercano y completamente transparente. La asesoría del futuro combina el trato humano con la tecnología más avanzada.
                </p>
            </div>
        </section>

        <!-- ═══ MISIÓN Y VISIÓN ═══ -->
        <section style="background:#1a2b3c;padding:80px 64px;">
            <div style="max-width:1100px;margin:0 auto;display:grid;grid-template-columns:1fr 1fr;gap:24px;">
                <div style="background:#151F2B;border:1px solid rgba(212,175,55,.15);border-left:3px solid #D4AF37;border-radius:6px;padding:36px 32px;">
                    <span style="font-size:10px;font-weight:500;letter-spacing:.2em;text-transform:uppercase;color:#D4AF37;display:block;margin-bottom:12px;">NUESTRA MISIÓN</span>
                    <h2 style="font-family:'Instrument Serif',serif;font-size:22px;font-weight:400;color:#fff;margin-bottom:16px;">¿Por qué surge Selecto Asesores?</h2>
                    <p style="font-size:13px;color:#8a9ab5;line-height:1.85;">
                        Simplificar la gestión fiscal de autónomos, pymes y empresas para que puedan centrarse en lo que realmente importa: hacer crecer su negocio. Queremos que la fiscalidad deje de ser una preocupación y se convierta en una ventaja competitiva.
                    </p>
                </div>
                <div style="background:#151F2B;border:1px solid rgba(212,175,55,.15);border-left:3px solid #D4AF37;border-radius:6px;padding:36px 32px;">
                    <span style="font-size:10px;font-weight:500;letter-spacing:.2em;text-transform:uppercase;color:#D4AF37;display:block;margin-bottom:12px;">NUESTRA VISIÓN</span>
                    <h2 style="font-family:'Instrument Serif',serif;font-size:22px;font-weight:400;color:#fff;margin-bottom:16px;">¿A dónde vamos?</h2>
                    <p style="font-size:13px;color:#8a9ab5;line-height:1.85;">
                        Convertirnos en la asesoría fiscal de referencia en España, combinando la experiencia de nuestros profesionales con herramientas digitales avanzadas que aporten valor real y medible a cada uno de nuestros clientes.
                    </p>
                </div>
            </div>
        </section>

        <!-- ═══ CÓMO TRABAJAMOS ═══ -->
        <section style="background:#151F2B;padding:80px 64px;">
            <div style="max-width:1100px;margin:0 auto;">
                <div style="text-align:center;margin-bottom:56px;">
                    <span style="font-size:10px;letter-spacing:.22em;text-transform:uppercase;color:#8a9ab5;display:block;margin-bottom:12px;">NUESTRO PROCESO</span>
                    <h2 style="font-family:'Instrument Serif',serif;font-size:clamp(28px,3vw,40px);font-weight:400;color:#fff;line-height:1.15;">
                        Cómo trabajamos<br>
                        <em style="color:#D4AF37;">contigo</em>
                    </h2>
                </div>

                <div style="display:grid;grid-template-columns:repeat(4,1fr);gap:20px;position:relative;">
                    <!-- Línea conectora -->
                    <div style="position:absolute;top:28px;left:12%;right:12%;height:1px;background:linear-gradient(90deg,transparent,rgba(212,175,55,.3),transparent);z-index:0;"></div>

                    <div v-for="p in proceso" :key="p.numero" style="position:relative;z-index:1;text-align:center;">
                        <div style="width:56px;height:56px;border-radius:50%;background:rgba(212,175,55,.1);border:1px solid rgba(212,175,55,.3);display:flex;align-items:center;justify-content:center;margin:0 auto 20px;font-family:'Instrument Serif',serif;font-size:18px;color:#D4AF37;">
                            {{ p.numero }}
                        </div>
                        <h3 style="font-family:'Instrument Serif',serif;font-size:17px;font-weight:400;color:#fff;margin-bottom:10px;">{{ p.titulo }}</h3>
                        <p style="font-size:12px;color:#6a7a9a;line-height:1.75;">{{ p.texto }}</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- ═══ EQUIPO ═══ -->
        <section style="background:#1a2b3c;padding:80px 64px;">
            <div style="max-width:1100px;margin:0 auto;">
                <div style="text-align:center;margin-bottom:56px;">
                    <span style="font-size:10px;letter-spacing:.22em;text-transform:uppercase;color:#8a9ab5;display:block;margin-bottom:12px;">NUESTRO EQUIPO</span>
                    <h2 style="font-family:'Instrument Serif',serif;font-size:clamp(28px,3vw,40px);font-weight:400;color:#fff;line-height:1.15;">
                        Los profesionales<br>
                        <em style="color:#D4AF37;">detrás de tu tranquilidad</em>
                    </h2>
                </div>

                <div style="display:grid;grid-template-columns:repeat(3,1fr);gap:24px;">
                    <div v-for="m in equipo" :key="m.nombre"
                        style="background:#151F2B;border:1px solid rgba(255,255,255,.06);border-radius:8px;overflow:hidden;transition:border-color .2s,transform .2s;"
                        onmouseover="this.style.borderColor='rgba(212,175,55,.25)';this.style.transform='translateY(-4px)'"
                        onmouseout="this.style.borderColor='rgba(255,255,255,.06)';this.style.transform='translateY(0)'">

                        <div style="height:180px;background:linear-gradient(135deg,#1c2d3f,#243345);display:flex;align-items:center;justify-content:center;position:relative;overflow:hidden;">
                            <div style="position:absolute;inset:0;opacity:.04;background:repeating-linear-gradient(45deg,#D4AF37 0,#D4AF37 1px,transparent 0,transparent 50%);background-size:20px 20px;"></div>
                            <div style="width:88px;height:88px;border-radius:50%;background:rgba(212,175,55,.1);border:2px solid rgba(212,175,55,.3);display:flex;align-items:center;justify-content:center;font-family:'Instrument Serif',serif;font-size:36px;color:#D4AF37;position:relative;z-index:1;">
                                {{ m.inicial }}
                            </div>
                        </div>

                        <div style="padding:24px 22px 28px;">
                            <span style="font-size:10px;font-weight:500;letter-spacing:.12em;text-transform:uppercase;color:#D4AF37;display:block;margin-bottom:5px;">{{ m.rol }}</span>
                            <h3 style="font-family:'Instrument Serif',serif;font-size:19px;font-weight:400;color:#fff;margin-bottom:12px;">{{ m.nombre }}</h3>
                            <p style="font-size:12px;color:#6a7a9a;line-height:1.8;">{{ m.bio }}</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- ═══ CTA FINAL ═══ -->
        <section style="background:#151F2B;padding:80px 64px;text-align:center;border-top:1px solid rgba(255,255,255,.05);">
            <span style="font-size:10px;letter-spacing:.22em;text-transform:uppercase;color:#8a9ab5;display:block;margin-bottom:14px;">EMPIEZA HOY</span>
            <h2 style="font-family:'Instrument Serif',serif;font-size:clamp(28px,3vw,42px);font-weight:400;color:#fff;line-height:1.2;margin-bottom:16px;">
                ¿Listo para simplificar<br>
                <em style="color:#D4AF37;">tu fiscalidad?</em>
            </h2>
            <p style="font-size:14px;color:#8a9ab5;margin-bottom:36px;max-width:480px;margin-left:auto;margin-right:auto;line-height:1.75;">
                Primera consulta gratuita y sin compromiso. Cuéntanos tu situación y te ayudamos a encontrar la mejor solución.
            </p>
            <div style="display:flex;gap:14px;justify-content:center;flex-wrap:wrap;">
                <a href="/reserva" style="background:#D4AF37;color:#151F2B;padding:14px 32px;border-radius:5px;font-size:12px;font-weight:500;letter-spacing:.1em;text-transform:uppercase;text-decoration:none;transition:opacity .2s;"
                    onmouseover="this.style.opacity='.85'" onmouseout="this.style.opacity='1'">
                    Reservar cita gratuita
                </a>
                <a href="/contacto" style="border:1px solid rgba(255,255,255,.15);color:#c8d0dc;padding:14px 32px;border-radius:5px;font-size:12px;font-weight:400;letter-spacing:.1em;text-transform:uppercase;text-decoration:none;transition:border-color .2s,color .2s;"
                    onmouseover="this.style.borderColor='rgba(255,255,255,.35)';this.style.color='#fff'"
                    onmouseout="this.style.borderColor='rgba(255,255,255,.15)';this.style.color='#c8d0dc'">
                    Contactar
                </a>
            </div>
        </section>

    </PublicLayout>
</template>