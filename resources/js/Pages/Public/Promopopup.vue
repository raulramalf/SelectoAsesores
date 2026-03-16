<template>
    <Transition name="fade-premium">
        <div v-if="isVisible" class="promo-premium-overlay" @click.self="closePopup">
            <div class="promo-premium-modal">
                <button class="promo-premium-close" @click="closePopup" aria-label="Cerrar">&times;</button>
                
                <div class="promo-premium-grid">
                    <div class="promo-premium-image">
                        <div class="promo-premium-image-overlay"></div>
                    </div>
                    
                    <div class="promo-premium-content">
                        <span class="promo-premium-badge">Oferta Exclusiva</span>
                        
                        <h2 class="promo-premium-title">
                            Impulsa tu negocio<br>
                            <em>al siguiente nivel</em>
                        </h2>
                        
                        <div class="promo-premium-pricing">
                            <span class="promo-premium-price">200 €</span>
                            <span class="promo-premium-period">/ 3 meses</span>
                        </div>
                        
                        <p class="promo-premium-desc">
                            Delega tu gestión fiscal, laboral y contable en manos de expertos. Planificación estratégica y soporte dedicado para nuevos clientes de Selecto Asesores.
                        </p>
                        
                        <ul class="promo-premium-features">
                            <li><span class="check">✓</span> Asesor personal asignado</li>
                            <li><span class="check">✓</span> Análisis y optimización fiscal</li>
                            <li><span class="check">✓</span> Soporte prioritario en menos de 24h</li>
                        </ul>
                        
                        <Link href="/reserva" class="promo-premium-btn" @click="closePopup">
                            Reserva tu cita ahora
                        </Link>
                        
                        <p class="promo-premium-disclaimer">
                            Plazas limitadas. Promoción válida únicamente para nuevas altas.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </Transition>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { Link } from '@inertiajs/vue3';

const isVisible = ref(false);

const closePopup = () => {
    isVisible.value = false;
    sessionStorage.setItem('promo_vista', '1');
};

onMounted(() => {
    if (!sessionStorage.getItem('promo_vista')) {
        setTimeout(() => {
            isVisible.value = true;
        }, 1200);
    }
});
</script>