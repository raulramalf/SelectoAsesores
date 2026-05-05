<script setup>
import PublicLayout from '@/Layouts/PublicLayout.vue'

const proceso = [
    { num: '01', titulo: 'Primera consulta', desc: 'Analizamos tu situación fiscal de forma gratuita y sin compromiso para entender qué necesitas.' },
    { num: '02', titulo: 'Plan personalizado', desc: 'Diseñamos una estrategia fiscal adaptada a tu actividad, tamaño y objetivos empresariales.' },
    { num: '03', titulo: 'Gestión continua', desc: 'Nos encargamos de toda la burocracia fiscal para que tú te centres en hacer crecer tu negocio.' },
    { num: '04', titulo: 'Seguimiento', desc: 'Tu asesor personal está siempre disponible para resolver dudas y anticiparse a cambios normativos.' }
]
</script>

<template>
    <PublicLayout>

        <!-- ═══ BLOQUE PRINCIPAL CONTINUO (Hero + Misión/Visión) ═══ -->
        <div style="background:#151F2B;">
            
            <!-- HERO -->
            <section style="position:relative; padding:160px 64px 80px; text-align:center; display:flex; align-items:center; justify-content:center;">
                <!-- Fondo fotográfico muy sutil fundido con el color base -->
                <div style="position:absolute; inset:0;">
                    <img src="https://images.unsplash.com/photo-1497366216548-37526070297c?auto=format&fit=crop&w=1920&q=80" alt="Fondo oficina" style="width:100%; height:100%; object-fit:cover; filter:grayscale(50%); opacity:0.15;">
                </div>
                <div style="position:absolute; inset:0; background:linear-gradient(to bottom, rgba(21,31,43,0.5) 0%, #151F2B 100%);"></div>

                <div style="position:relative; z-index:2; max-width:800px; margin:0 auto;">
                    <span style="font-size:11px; font-weight:600; letter-spacing:0.25em; text-transform:uppercase; color:#E2CBAE; display:block; margin-bottom:20px;">Sobre Nosotros</span>
                    <h1 style="font-family:'Instrument Serif',serif; font-size:clamp(48px,6vw,72px); font-weight:400; color:#fff; line-height:1.1; margin-bottom:24px;">
                        Más que una asesoría,<br>
                        <em style="color:#E2CBAE;">tu socio estratégico</em>
                    </h1>
                    <p style="font-size:16px; color:#a0aabf; line-height:1.8; max-width:640px; margin:0 auto;">
                        Nacimos con un objetivo claro: simplificar la vida de los empresarios. Combinamos la experiencia técnica con la cercanía humana para que la fiscalidad deje de ser un problema.
                    </p>
                </div>
            </section>

            <!-- IMAGEN ANCLA Y TEXTOS (Misión/Visión) -->
            <section style="padding:0 64px 140px; position:relative; z-index:2;">
                <div style="max-width:1160px; margin:0 auto;">

                    <!-- Imagen Editorial Centrada -->
                    <div style="width:100%; height:500px; border-radius:16px; overflow:hidden; margin-bottom:80px; border:1px solid rgba(255,255,255,0.05);">
                        <img src="https://images.unsplash.com/photo-1522071820081-009f0129c71c?auto=format&fit=crop&w=1200&q=80" alt="Equipo trabajando" style="width:100%; height:100%; object-fit:cover; object-position:center 40%;">
                    </div>

                    <!-- Cuadrícula limpia para Misión y Visión -->
                    <div style="display:grid; grid-template-columns:repeat(2, 1fr); gap:80px;">
                        
                        <!-- Columna Misión -->
                        <div>
                            <div style="display:flex; align-items:center; gap:16px; margin-bottom:24px;">
                                <div style="width:40px; height:1px; background:#E2CBAE;"></div>
                                <span style="font-size:11px; font-weight:600; letter-spacing:0.2em; text-transform:uppercase; color:#E2CBAE;">Nuestra Misión</span>
                            </div>
                            <h3 style="font-family:'Instrument Serif',serif; font-size:40px; font-weight:400; color:#fff; line-height:1.1; margin-bottom:20px;">¿Por qué surge<br>Selecto Asesores?</h3>
                            <p style="font-size:15px; color:#a0aabf; line-height:1.8;">
                                Simplificar la gestión fiscal de autónomos, pymes y empresas para que puedan centrarse en lo que realmente importa: hacer crecer su negocio. Queremos que la fiscalidad deje de ser una preocupación y se convierta en una ventaja competitiva.
                            </p>
                        </div>

                        <!-- Columna Visión -->
                        <div>
                            <div style="display:flex; align-items:center; gap:16px; margin-bottom:24px;">
                                <div style="width:40px; height:1px; background:#E2CBAE;"></div>
                                <span style="font-size:11px; font-weight:600; letter-spacing:0.2em; text-transform:uppercase; color:#E2CBAE;">Nuestra Visión</span>
                            </div>
                            <h3 style="font-family:'Instrument Serif',serif; font-size:40px; font-weight:400; color:#fff; line-height:1.1; margin-bottom:20px;">¿Hacia dónde<br>vamos?</h3>
                            <p style="font-size:15px; color:#a0aabf; line-height:1.8;">
                                Convertirnos en la asesoría fiscal de referencia en España, combinando la experiencia de nuestros profesionales con herramientas digitales avanzadas que aporten valor real y medible a cada uno de nuestros clientes.
                            </p>
                        </div>

                    </div>
                </div>
            </section>
            
        </div> <!-- Fin del bloque continuo -->

        <!-- ═══ PROCESO ═══ -->
        <section style="background:#1c2d3f; padding:120px 64px; border-top:1px solid rgba(255,255,255,0.03); border-bottom:1px solid rgba(255,255,255,0.03);">
            <div style="max-width:1160px; margin:0 auto; text-align:center;">
                
                <span style="font-size:10px; letter-spacing:0.22em; text-transform:uppercase; color:#8a9ab5; display:block; margin-bottom:12px;">NUESTRO PROCESO</span>
                <h2 style="font-family:'Instrument Serif',serif; font-size:48px; font-weight:400; color:#fff; line-height:1.1; margin-bottom:80px;">
                    Cómo trabajamos<br><em style="color:#E2CBAE;">contigo</em>
                </h2>

                <!-- Timeline Grid -->
                <div style="display:grid; grid-template-columns:repeat(4, 1fr); gap:40px; position:relative;">
                    
                    <!-- Línea conectora -->
                    <div style="position:absolute; top:28px; left:10%; right:10%; height:1px; background:rgba(226,203,174,0.2); z-index:1;"></div>

                    <div v-for="paso in proceso" :key="paso.num" style="position:relative; z-index:2; display:flex; flex-direction:column; align-items:center;">
                        <div style="width:56px; height:56px; border-radius:50%; background:#1c2d3f; border:2px solid #E2CBAE; display:flex; align-items:center; justify-content:center; margin-bottom:24px;">
                            <span style="font-family:'Instrument Serif',serif; font-size:24px; color:#E2CBAE;">{{ paso.num }}</span>
                        </div>
                        
                        <h4 style="font-size:16px; font-weight:600; color:#fff; margin-bottom:12px;">{{ paso.titulo }}</h4>
                        <p style="font-size:13px; color:#8a9ab5; line-height:1.6; max-width:220px;">{{ paso.desc }}</p>
                    </div>

                </div>
            </div>
        </section>

        <!-- ═══ CTA FINAL ═══ -->
        <section style="background:#243345; padding:100px 64px; text-align:center;">
            <h2 style="font-family:'Instrument Serif',serif; font-size:clamp(32px,4vw,48px); font-weight:400; color:#fff; line-height:1.2; margin-bottom:12px;">
                ¿Listo para dar el<br>
                <em style="color:#E2CBAE;">siguiente paso?</em>
            </h2>
            <p style="font-size:14px; color:#a0aabf; margin:16px auto 36px; max-width:480px; line-height:1.75;">
                Agenda una consulta gratuita de 15 minutos y descubre cómo podemos optimizar la fiscalidad de tu negocio.
            </p>
            <a href="/reserva" style="display:inline-block; background:#E2CBAE; color:#151F2B; padding:15px 48px; border-radius:100px; font-size:12px; font-weight:600; letter-spacing:0.12em; text-transform:uppercase; text-decoration:none; transition:opacity 0.2s;"
                onmouseover="this.style.opacity='0.85'" onmouseout="this.style.opacity='1'">
                RESERVAR CITA AHORA
            </a>
        </section>

    </PublicLayout>
</template>