<script setup>
import PublicLayout from '@/Layouts/PublicLayout.vue'
import Promopopup from './Promopopup.vue' 

const testimonios = [
    {
        nombre: 'Marco Ramírez',
        imagen: 'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=150&h=150&fit=crop&q=80',
        texto: '"Lo que más valoro es la agilidad. Tener un asesor personal asignado que conoce mi histórico y responde en menos de 24 horas marca la diferencia entre un gestor común y un servicio de élite."'
    },
    {
        nombre: 'Marta Ramírez',
        imagen: 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=150&h=150&fit=crop&q=80',
        texto: '"La planificación fiscal estratégica que ofrecen no es un gasto, es una inversión. Gracias a su análisis, hemos optimizado costes que ni siquiera habíamos detectado. Son el socio que toda gran empresa necesita."'
    }
]
</script>

<template>
    <PublicLayout>

        <Promopopup />

        <!-- ═══ HERO PRINCIPAL ═══ -->
        <section style="position:relative;overflow:hidden;min-height:80vh;display:flex;align-items:center;justify-content:center;text-align:center;">
            <div style="position:absolute;inset:0;">
                <img src="https://images.unsplash.com/photo-1589829545856-d10d557cf95f?w=1600&q=85" alt="Hero" style="width:100%;height:100%;object-fit:cover;object-position:center 20%;filter:grayscale(30%);">
            </div>
            <div style="position:absolute;inset:0;background:linear-gradient(180deg,rgba(21,31,43,0.80) 0%,rgba(21,31,43,0.95) 100%);"></div>

            <div style="position:relative;z-index:2;padding:80px 64px;width:100%;max-width:900px;">
                <span style="font-size:11px;letter-spacing:0.22em;text-transform:uppercase;color:#E2CBAE;display:block;margin-bottom:16px;">SELECTO ASESORES</span>
                <h1 style="font-family:'Instrument Serif',serif;font-size:clamp(40px,5vw,64px);font-weight:400;color:#fff;line-height:1.1;margin-bottom:24px;">
                    Todo lo que tu empresa<br>
                    <em style="color:#E2CBAE;">necesita en un solo lugar</em>
                </h1>
                <p style="font-size:15px;color:#a0aabf;line-height:1.85;max-width:600px;margin:0 auto 36px;font-weight:300;">
                    Asesoría fiscal integral para autónomos, pymes y empresas. Gestionamos tu fiscalidad para que tú te centres en crecer.
                </p>
                <a href="/reserva" style="display:inline-block;background:transparent;border:1px solid #E2CBAE;color:#E2CBAE;padding:12px 32px;border-radius:4px;font-size:11px;font-weight:600;letter-spacing:0.16em;text-transform:uppercase;text-decoration:none;transition:all 0.2s;"
                    onmouseover="this.style.background='#E2CBAE'; this.style.color='#151F2B';"
                    onmouseout="this.style.background='transparent'; this.style.color='#E2CBAE';">
                    SOLICITA TU PLAZA
                </a>
            </div>
        </section>

       <!-- ═══ SECCIÓN OFERTA ESPECIAL (Formato Tarjeta, Texto Izq, Imagen Der) ═══ -->
        <section id="seccion-oferta" style="background:#151F2B;padding:120px 64px;position:relative;overflow:hidden;">
            
            <!-- Halo trasero para destacar la tarjeta -->
            <div style="position:absolute;top:50%;left:50%;transform:translate(-50%,-50%);width:1000px;height:500px;background:radial-gradient(circle, rgba(226,203,174,0.04) 0%, transparent 70%);pointer-events:none;"></div>

            <!-- Contenedor central -->
            <div style="max-width:1200px;margin:0 auto;position:relative;z-index:2;">
                
                <!-- La caja de la tarjeta -->
                <div class="promo-premium-modal" style="box-shadow: 0 30px 60px -15px rgba(0,0,0,0.5); border: 1px solid rgba(226,203,174,0.15); border-radius: 16px; max-width: 100%;">
                    <div class="promo-premium-grid" style="min-height: 520px; display: flex;"> 
                        
                        <!-- 1. CONTENIDO A LA IZQUIERDA -->
                        <div class="promo-premium-content" style="flex: 1.2; padding: 56px 64px; display:flex; flex-direction:column; justify-content:center;">
                            <span class="promo-premium-badge" style="letter-spacing: 0.25em; margin-bottom: 16px;">Tarifa Especial Nuevos Clientes</span>
                            
                            <h2 class="promo-premium-title" style="font-size: 42px; margin-bottom: 24px;">
                                Servicio Fiscal y Contable<br>
                                <em style="color:#E2CBAE;">Integral</em>
                            </h2>
                            
                            <div class="promo-premium-pricing" style="display: flex; align-items: baseline; gap: 12px; margin-bottom: 24px; border-bottom: 1px solid rgba(255,255,255,0.05); padding-bottom: 24px;">
                                <div style="display:flex; flex-direction:column; align-items:flex-end; gap:2px;">
                                    <span style="font-size: 11px; color: #6a7a9a; text-transform: uppercase; letter-spacing: 0.1em;">Desde</span>
                                    <span style="text-decoration: line-through; font-size: 16px; color: #4a5a72;">300 €</span>
                                </div>
                                <span class="promo-premium-price" style="font-size: 56px; font-family: 'Instrument Serif', serif; line-height: 1; color: #fff;">200 €</span>
                                <span class="promo-premium-period" style="font-size: 14px; color: #8a9ab5;">/ mes</span>
                            </div>
                            
                            <p class="promo-premium-desc" style="font-size: 15px; color: #a0aabf; line-height: 1.7; margin-bottom: 32px;">
                                Tu tranquilidad no tiene precio, pero ahora sí tiene descuento. Únete a Selecto Asesores este mes y accede a nuestra gestión contable y tributaria completa.
                            </p>
                            
                            <ul class="promo-premium-features" style="display:flex; flex-direction:column; gap: 14px; margin-bottom: 40px; padding: 0; list-style: none;">
                                <li style="display:flex; align-items:center; gap:12px; font-size: 14px; color: #fff;">
                                    <span style="color: #E2CBAE; font-size: 16px;">✓</span> Asesor personal asignado
                                </li>
                                <li style="display:flex; align-items:center; gap:12px; font-size: 14px; color: #fff;">
                                    <span style="color: #E2CBAE; font-size: 16px;">✓</span> Presentación de impuestos (IVA, IRPF)
                                </li>
                                <li style="display:flex; align-items:center; gap:12px; font-size: 14px; color: #fff;">
                                    <span style="color: #E2CBAE; font-size: 16px;">✓</span> Contabilidad completa al día
                                </li>
                            </ul>
                            
                            <a href="/reserva" class="promo-premium-btn" style="display: block; text-align: center; text-decoration: none; border: none; width: 100%; padding: 18px; font-size: 13px; letter-spacing: 0.15em; border-radius: 8px;">
                                RECLAMAR MI PLAZA
                            </a>
                            
                            <p class="promo-premium-disclaimer" style="margin-top: 20px; font-size: 12px; color: #6a7a9a;">
                                Plazas limitadas. Promoción válida únicamente para nuevas altas sin permanencia.
                            </p>
                        </div>

                        <!-- 2. NUEVA IMAGEN A LA DERECHA -->
                        <div class="promo-premium-image" style="flex: 1; background-image: url('https://images.unsplash.com/photo-1450101499163-c8848c66ca85?w=800&q=80'); background-size: cover; background-position: center; position: relative;">
                            <div class="promo-premium-image-overlay" style="position: absolute; inset: 0; background: linear-gradient(to left, rgba(21, 31, 43, 0.1), rgba(28, 45, 63, 1) 98%);"></div>
                        </div>
                        
                    </div>
                </div>

            </div>
        </section>

        <!-- ═══ TESTIMONIOS ═══ -->
        <section style="background:#1c2d3f;padding:80px 64px;">
            <div style="max-width:1160px;margin:0 auto;">
                <div style="text-align:center;margin-bottom:48px;">
                    <span style="font-size:10px;letter-spacing:0.22em;text-transform:uppercase;color:#8a9ab5;display:block;">NUESTROS CLIENTES</span>
                </div>
                
                <div style="display:grid;grid-template-columns:repeat(2,1fr);gap:24px;max-width:960px;margin:0 auto;">
                    <div v-for="t in testimonios" :key="t.nombre" style="background:#151F2B;border:1px solid rgba(255,255,255,0.05);border-radius:8px;padding:32px;display:flex;align-items:flex-start;gap:20px;">
                        <img :src="t.imagen" :alt="t.nombre" style="width:64px;height:64px;border-radius:50%;object-fit:cover;border:2px solid #E2CBAE;flex-shrink:0;box-shadow:0 4px 12px rgba(0,0,0,0.2);">
                        <div>
                            <!-- Subimos el nombre a 16px para mantener jerarquía -->
                            <h4 style="font-size:16px;color:#fff;font-weight:600;margin-bottom:8px;">{{ t.nombre }}</h4>
                            
                            <!-- FUENTE CORREGIDA: Quitamos 'Instrument Serif', subimos a 14px y mejoramos el interlineado -->
                            <p style="font-size:14px;color:#a0aabf;line-height:1.7;font-style:italic;">{{ t.texto }}</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- ═══ CTA FINAL ═══ -->
        <section style="background:#243345;padding:80px 64px;text-align:center;">
            <h2 style="font-family:'Instrument Serif',serif;font-size:clamp(32px,4vw,48px);font-weight:400;color:#fff;line-height:1.2;margin-bottom:12px;">
                ¿No sabes si esto es para ti?<br>
                <em style="color:#E2CBAE;">Cuéntanos tu situación y te asesoramos</em>
            </h2>
            <p style="font-size:14px;color:#a0aabf;margin:16px auto 36px;max-width:480px;line-height:1.75;">
                Primera consulta gratuita. En menos de 24 horas analizamos tu caso para ver si nuestra metodología encaja con tu negocio.
            </p>
            <a href="/reserva" style="display:inline-block;background:#E2CBAE;color:#151F2B;padding:15px 48px;border-radius:100px;font-size:12px;font-weight:600;letter-spacing:0.12em;text-transform:uppercase;text-decoration:none;transition:opacity 0.2s;"
                onmouseover="this.style.opacity='0.85'" onmouseout="this.style.opacity='1'">
                SOLICITAR CONSULTA GRATUITA
            </a>
        </section>

    </PublicLayout>
</template>