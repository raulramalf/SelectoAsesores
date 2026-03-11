<script setup>
import PublicLayout from '@/Layouts/PublicLayout.vue'

const equipo = [
    {
        nombre: 'Asesor 1 Selecto',
        rol: 'Director y Asesor Fiscal',
        bio: 'Licenciado en Derecho Tributario, especializado en fiscalidad empresarial y planificación tributaria.',
    },
    {
        nombre: 'Asesor 2- Selecto',
        rol: 'Asesor Financiero',
        bio: 'Graduado en ADE con especialización en contabilidad empresarial y elaboración de cuentas anuales.',
    },
    {
        nombre: 'Asesor 3 Selecto',
        rol: 'Asesor Fiscal',
        bio: 'Especialista en autónomos y pymes, con amplio conocimiento en constitución de sociedades y gestión tributaria.',
    },
]
</script>

<template>
    <PublicLayout>

        <!-- ═══ HERO ═══ -->
        <section style="position:relative;overflow:hidden;min-height:320px;display:flex;align-items:center;">
            <!-- Imagen de fondo -->
            <div style="position:absolute;inset:0;">
                <img src="https://images.unsplash.com/photo-1554224155-8d04cb21cd6c?w=1600&q=80"
                    alt="nosotros" style="width:100%;height:100%;object-fit:cover;object-position:center;filter:grayscale(20%);">
            </div>
            <div style="position:absolute;inset:0;background:linear-gradient(100deg,rgba(21,31,43,.97) 40%,rgba(21,31,43,.65) 100%);"></div>

            <div style="position:relative;z-index:2;padding:0 64px;display:grid;grid-template-columns:1fr auto;gap:64px;align-items:center;width:100%;max-width:1100px;">
                <div>
                    <span style="font-size:10px;letter-spacing:.22em;text-transform:uppercase;color:#8a9ab5;display:block;margin-bottom:14px;">SOBRE NOSOTROS</span>
                    <h1 style="font-family:'Instrument Serif',serif;font-size:clamp(30px,3.5vw,46px);font-weight:400;color:#fff;line-height:1.15;margin-bottom:16px;">
                        Una nueva forma<br>
                        <em style="color:#D4AF37;">de entender la asesoría</em>
                    </h1>
                    <p style="font-size:13px;color:#a0aabf;line-height:1.85;max-width:480px;font-weight:300;">
                        Selecto Asesores nace con una visión clara: ofrecer un servicio fiscal moderno, cercano y completamente transparente. Creemos que la asesoría del futuro combina el trato humano con la tecnología más avanzada.
                    </p>
                </div>

                <!-- Logo box -->
                <div style="background:#1c2d3f;border:1px solid rgba(212,175,55,.3);border-radius:8px;padding:40px 48px;text-align:center;flex-shrink:0;">
                    <div style="font-family:'Instrument Serif',serif;font-size:64px;font-weight:400;color:#D4AF37;line-height:1;letter-spacing:.04em;">SA</div>
                    <div style="font-size:11px;color:#6a7a9a;letter-spacing:.16em;text-transform:uppercase;margin-top:10px;">SELECTO ASESORES</div>
                </div>
            </div>
        </section>

        <!-- ═══ MISIÓN Y VISIÓN ═══ -->
        <section style="position:relative;overflow:hidden;padding:64px;">
            <!-- Imagen de fondo -->
            <div style="position:absolute;inset:0;">
                <img src="https://images.unsplash.com/photo-1521791136064-7986c2920216?w=1600&q=80"
                    alt="equipo" style="width:100%;height:100%;object-fit:cover;filter:grayscale(20%);">
            </div>
            <div style="position:absolute;inset:0;background:rgba(21,31,43,.88);"></div>

            <div style="position:relative;z-index:2;display:grid;grid-template-columns:1fr 1fr;gap:20px;max-width:900px;">
                <div style="background:rgba(28,45,63,.9);border:1px solid rgba(255,255,255,.08);border-radius:6px;padding:32px 28px;">
                    <span style="font-size:10px;font-weight:500;letter-spacing:.2em;text-transform:uppercase;color:#D4AF37;display:block;margin-bottom:10px;">NUESTRA MISIÓN</span>
                    <h2 style="font-family:'Instrument Serif',serif;font-size:20px;font-weight:400;color:#fff;margin-bottom:14px;">¿Por qué surge Selecto Asesores?</h2>
                    <p style="font-size:12px;color:#8a9ab5;line-height:1.85;">
                        Simplificar la gestión fiscal de autónomos, pymes y empresas para que puedan centrarse en lo que realmente importa: hacer crecer su negocio. Queremos que la fiscalidad deje de ser una preocupación y se convierta en una ventaja competitiva.
                    </p>
                </div>
                <div style="background:rgba(28,45,63,.9);border:1px solid rgba(255,255,255,.08);border-radius:6px;padding:32px 28px;">
                    <span style="font-size:10px;font-weight:500;letter-spacing:.2em;text-transform:uppercase;color:#D4AF37;display:block;margin-bottom:10px;">NUESTRA VISIÓN</span>
                    <h2 style="font-family:'Instrument Serif',serif;font-size:20px;font-weight:400;color:#fff;margin-bottom:14px;">¿A dónde vamos?</h2>
                    <p style="font-size:12px;color:#8a9ab5;line-height:1.85;">
                        Convertirnos en la asesoría fiscal de referencia en España, combinando la experiencia de nuestros profesionales con herramientas digitales avanzadas que aporten valor real y medible a cada uno de nuestros clientes.
                    </p>
                </div>
            </div>
        </section>

        <!-- ═══ EQUIPO ═══ -->
        <section style="background:#151F2B;padding:64px;">
            <div style="text-align:center;margin-bottom:48px;">
                <span style="font-size:10px;letter-spacing:.22em;text-transform:uppercase;color:#8a9ab5;display:block;margin-bottom:12px;">NUESTRO EQUIPO</span>
                <h2 style="font-family:'Instrument Serif',serif;font-size:clamp(28px,3vw,40px);font-weight:400;color:#fff;line-height:1.15;">
                    Los profesionales<br>
                    <em style="color:#D4AF37;">detrás de tu tranquilidad</em>
                </h2>
            </div>
            <div style="display:grid;grid-template-columns:repeat(3,1fr);gap:20px;max-width:880px;margin:0 auto;">
                <div v-for="m in equipo" :key="m.nombre"
                    style="background:#1c2d3f;border:1px solid rgba(255,255,255,.06);border-radius:6px;overflow:hidden;text-align:center;">
                    <!-- Foto placeholder gris -->
                    <div style="height:160px;background:#243345;display:flex;align-items:center;justify-content:center;">
                        <div style="width:72px;height:72px;border-radius:50%;background:#151F2B;border:1px solid rgba(255,255,255,.1);display:flex;align-items:center;justify-content:center;">
                            <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="#4a5a72" stroke-width="1.2" stroke-linecap="round" stroke-linejoin="round">
                                <circle cx="12" cy="8" r="4"/>
                                <path d="M4 20c0-4 3.6-7 8-7s8 3 8 7"/>
                            </svg>
                        </div>
                    </div>
                    <div style="padding:20px 16px 24px;">
                        <span style="font-size:10px;font-weight:500;letter-spacing:.12em;text-transform:uppercase;color:#D4AF37;display:block;margin-bottom:4px;">{{ m.rol }}</span>
                        <h3 style="font-family:'Instrument Serif',serif;font-size:17px;font-weight:400;color:#fff;margin-bottom:10px;">{{ m.nombre }}</h3>
                        <p style="font-size:11px;color:#6a7a9a;line-height:1.75;">{{ m.bio }}</p>
                    </div>
                </div>
            </div>
        </section>

    </PublicLayout>
</template>