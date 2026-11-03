<script setup>
// Opiniones verificadas de Trustpilot. No se muestra nada hasta configurar las
// variables VITE_TRUSTPILOT_* en .env (ver docs/TRUSTPILOT.md) y no se carga el
// script de Trustpilot (que instala cookies de terceros) hasta que el visitante
// pulsa el botón.
import { ref, nextTick } from 'vue'

const businessId = import.meta.env.VITE_TRUSTPILOT_BUSINESS_ID
const templateId = import.meta.env.VITE_TRUSTPILOT_TEMPLATE_ID
const token = import.meta.env.VITE_TRUSTPILOT_TOKEN
const perfil = import.meta.env.VITE_TRUSTPILOT_URL
const alto = import.meta.env.VITE_TRUSTPILOT_HEIGHT || '240px'

const configurado = Boolean(businessId && templateId)
const cargado = ref(false)
const raiz = ref(null)

function cargar() {
    if (cargado.value) return
    cargado.value = true
    nextTick(() => {
        const iniciar = () => {
            const el = raiz.value?.querySelector('.trustpilot-widget')
            if (el && window.Trustpilot) window.Trustpilot.loadFromElement(el, true)
        }
        if (window.Trustpilot) return iniciar()
        const s = document.createElement('script')
        s.src = 'https://widget.trustpilot.com/bootstrap/v5/tp.widget.bootstrap.min.js'
        s.async = true
        s.onload = iniciar
        document.head.appendChild(s)
    })
}
</script>

<template>
    <section v-if="configurado" ref="raiz" class="hx-section hx-section--alt" id="opiniones">
        <div class="hx-container">
            <div class="hx-head">
                <div>
                    <span class="hx-eyebrow">Nuestros clientes</span>
                    <h2 class="hx-title">Opiniones <em>verificadas</em></h2>
                </div>
                <a v-if="perfil" :href="perfil" target="_blank" rel="noopener noreferrer" class="link-arrow">Ver todas en Trustpilot</a>
            </div>

            <div v-if="!cargado" class="tp-gate">
                <p>Las opiniones las muestra Trustpilot, un servicio externo que puede instalar cookies propias al cargarse.</p>
                <button type="button" class="btn btn--ghost" @click="cargar">Mostrar opiniones</button>
            </div>

            <div v-else
                 class="trustpilot-widget"
                 data-locale="es-ES"
                 :data-template-id="templateId"
                 :data-businessunit-id="businessId"
                 :data-token="token || null"
                 :data-style-height="alto"
                 data-style-width="100%"
                 data-theme="dark">
                <a v-if="perfil" :href="perfil" target="_blank" rel="noopener noreferrer">Trustpilot</a>
            </div>
        </div>
    </section>
</template>
