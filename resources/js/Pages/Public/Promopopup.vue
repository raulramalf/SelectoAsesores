<template>
    <Transition name="fade-premium">
        <div v-if="isVisible" class="promo-premium-overlay" @click.self="closePopup">
            <div class="promo-premium-modal" style="max-width: 1200px; width: 95%;">
                <button class="promo-premium-close" @click="closePopup" aria-label="Cerrar">&times;</button>
                
                <div class="promo-premium-grid" style="display: flex;">
                    
                    <!-- 1. CONTENIDO A LA IZQUIERDA -->
                    <div class="promo-premium-content" style="flex: 1.2; padding: 56px 64px; display:flex; flex-direction:column; justify-content:center;">
                        <span class="promo-premium-badge">Tarifa Especial Nuevos Clientes</span>
                        
                        <h2 class="promo-premium-title">
                            Servicio Fiscal y Contable<br>
                            <em>Integral</em>
                        </h2>
                        
                        <div class="promo-premium-pricing" style="display: flex; align-items: baseline;">
                            <span style="font-size: 16px; color: #a0aabf; margin-right: 8px;">Desde</span>
                            <span class="promo-premium-price" style="text-decoration: line-through; font-size: 0.7em; color: #6a7a9a; margin-right: 8px;">300 €</span>
                            <span class="promo-premium-price">200 €</span>
                            <span class="promo-premium-period">/ mes</span>
                        </div>
                        
                        <p class="promo-premium-desc">
                            Tu tranquilidad no tiene precio, pero ahora sí tiene descuento. Únete a Selecto Asesores este mes y accede a nuestra gestión contable y tributaria completa.
                        </p>
                        
                        <ul class="promo-premium-features">
                            <li><span class="check">✓</span> Asesor personal asignado</li>
                            <li><span class="check">✓</span> Presentación de impuestos (IVA, IRPF)</li>
                            <li><span class="check">✓</span> Contabilidad completa al día</li>
                        </ul>
                        
                        <button class="promo-premium-btn" @click="irAOferta" style="border: none; width: 100%; cursor: pointer;">
                            Reclamar mi plaza
                        </button>
                        
                        <p class="promo-premium-disclaimer">
                            Plazas limitadas. Promoción válida únicamente para nuevas altas sin permanencia.
                        </p>
                    </div>

                    <!-- 2. NUEVA IMAGEN A LA DERECHA -->
                    <div class="promo-premium-image" style="flex: 1; background-image: url('https://images.unsplash.com/photo-1450101499163-c8848c66ca85?w=800&q=80'); background-size: cover; background-position: center; position: relative;">
                        <!-- Degradado invertido (funde de derecha a izquierda) -->
                        <div class="promo-premium-image-overlay" style="position: absolute; inset: 0; background: linear-gradient(to left, rgba(21, 31, 43, 0.1), rgba(28, 45, 63, 1) 98%);"></div>
                    </div>

                </div>
            </div>
        </div>
    </Transition>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue';
import { router } from '@inertiajs/vue3';

const isVisible = ref(false);
let observer = null;

const closePopup = () => {
    isVisible.value = false;
    sessionStorage.setItem('promo_vista', '1');
};

const irAOferta = () => {
    closePopup();
    
    if (window.location.pathname === '/') {
        const seccion = document.getElementById('seccion-oferta');
        if (seccion) {
            seccion.scrollIntoView({ behavior: 'smooth', block: 'center' });
        }
    } else {
        router.visit('/#seccion-oferta');
    }
};

onMounted(() => {
    sessionStorage.removeItem('promo_vista'); // Para facilitar tus pruebas

    if (!sessionStorage.getItem('promo_vista')) {
        setTimeout(() => {
            isVisible.value = true;
            
            const seccionOferta = document.getElementById('seccion-oferta');
            if (seccionOferta) {
                observer = new IntersectionObserver((entries) => {
                    if (entries[0].isIntersecting && isVisible.value) {
                        closePopup(); 
                    }
                }, { threshold: 0.6 }); 
                
                observer.observe(seccionOferta);
            }
        }, 800);
    }
});

onUnmounted(() => {
    if (observer) observer.disconnect();
});
</script>