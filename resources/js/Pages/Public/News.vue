<script setup>
import PublicLayout from '@/Layouts/PublicLayout.vue'
import { ref, computed } from 'vue'

const props = defineProps({
    noticias: { type: Array, default: () => [] }
})

const filtroActivo = ref('Todas')
const busqueda = ref('')
const filtros = ['Todas', 'IRPF', 'IVA', 'Sociedades', 'Autónomos', 'BOE']

const noticiasFiltradas = computed(() => {
    return props.noticias.filter(n => {
        const matchFiltro = filtroActivo.value === 'Todas' || n.category === filtroActivo.value
        const matchBusqueda = n.title.toLowerCase().includes(busqueda.value.toLowerCase())
        return matchFiltro && matchBusqueda
    })
})
</script>

<template>
    <PublicLayout>

        <!-- ═══ HERO ═══ -->
        <section style="position:relative;overflow:hidden;min-height:280px;display:flex;align-items:flex-end;">
            <div style="position:absolute;inset:0;">
                <img src="https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=1600&q=80"
                    alt="noticias" style="width:100%;height:100%;object-fit:cover;object-position:center top;filter:grayscale(25%);">
            </div>
            <div style="position:absolute;inset:0;background:linear-gradient(180deg,rgba(21,31,43,.5) 0%,rgba(21,31,43,.92) 100%);"></div>
            <div style="position:relative;z-index:2;padding:0 64px 48px;">
                <span style="font-size:10px;letter-spacing:.22em;text-transform:uppercase;color:#D4AF37;display:block;margin-bottom:10px;">ACTUALIDAD FISCAL</span>
                <h1 style="font-family:'Instrument Serif',serif;font-size:clamp(36px,5vw,60px);font-weight:400;color:#fff;line-height:1.05;margin-bottom:12px;">
                    Noticias y<br>novedades tributarias
                </h1>
                <p style="font-size:13px;color:#a0aabf;max-width:520px;line-height:1.75;font-weight:300;">
                    Mantente informado sobre los últimos cambios en legislación fiscal, novedades de la AEAT y consejos para optimizar tu situación tributaria.
                </p>
            </div>
        </section>

        <!-- ═══ FILTROS ═══ -->
        <section style="background:#151F2B;border-bottom:1px solid rgba(255,255,255,.06);">
            <div style="padding:0 64px;display:flex;align-items:center;justify-content:space-between;height:56px;gap:16px;">
                <div style="display:flex;gap:2px;">
                    <button v-for="f in filtros" :key="f"
                        @click="filtroActivo = f"
                        :style="`padding:6px 16px;border-radius:100px;font-size:11px;font-weight:400;cursor:pointer;font-family:'Inter',sans-serif;letter-spacing:.06em;transition:all .2s;border:${filtroActivo === f ? '1px solid rgba(212,175,55,.4)' : '1px solid transparent'};background:${filtroActivo === f ? 'rgba(212,175,55,.1)' : 'transparent'};color:${filtroActivo === f ? '#D4AF37' : '#6a7a9a'};`">
                        {{ f }}
                    </button>
                </div>
                <input v-model="busqueda"
                    type="text"
                    placeholder="Buscar noticias..."
                    style="background:#1c2d3f;border:1px solid rgba(255,255,255,.07);border-radius:4px;padding:7px 12px;color:#a0aabf;font-size:12px;outline:none;width:200px;font-family:'Inter',sans-serif;" />
            </div>
        </section>

        <!-- ═══ GRID NOTICIAS ═══ -->
        <section style="background:#243345;padding:48px 64px 80px;">

            <!-- Con noticias -->
            <div v-if="noticiasFiltradas.length > 0"
                style="display:grid;grid-template-columns:repeat(3,1fr);gap:16px;max-width:1160px;margin:0 auto;">
                <div v-for="noticia in noticiasFiltradas" :key="noticia.id"
                    style="background:#151F2B;border:1px solid rgba(255,255,255,.06);border-radius:6px;overflow:hidden;cursor:pointer;">
                    <div style="height:140px;background:#1c2d3f;overflow:hidden;">
                        <img v-if="noticia.image" :src="noticia.image" :alt="noticia.title"
                            style="width:100%;height:100%;object-fit:cover;">
                        <div v-else style="width:100%;height:100%;display:flex;align-items:center;justify-content:center;">
                            <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="#2a3a52" stroke-width="1.2">
                                <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/>
                                <polyline points="14 2 14 8 20 8"/>
                                <line x1="16" y1="13" x2="8" y2="13"/>
                                <line x1="16" y1="17" x2="8" y2="17"/>
                                <polyline points="10 9 9 9 8 9"/>
                            </svg>
                        </div>
                    </div>
                    <div style="padding:18px 16px;">
                        <span style="font-size:9px;font-weight:500;letter-spacing:.16em;text-transform:uppercase;color:#D4AF37;display:block;margin-bottom:7px;">{{ noticia.category }}</span>
                        <h3 style="font-family:'Instrument Serif',serif;font-size:16px;font-weight:400;color:#fff;line-height:1.35;margin-bottom:8px;">{{ noticia.title }}</h3>
                        <p style="font-size:11px;color:#6a7a9a;line-height:1.7;margin-bottom:14px;">{{ noticia.summary }}</p>
                        <div style="display:flex;justify-content:space-between;align-items:center;">
                            <span style="font-size:10px;color:#4a5a72;">{{ noticia.published_at }}</span>
                            <a :href="`/noticias/${noticia.slug}`" style="font-size:10px;color:#D4AF37;text-decoration:none;letter-spacing:.08em;text-transform:uppercase;">Leer más →</a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Sin noticias -->
            <div v-else style="text-align:center;padding:80px 20px;max-width:400px;margin:0 auto;">
                <div style="width:56px;height:56px;border:1px solid rgba(255,255,255,.08);border-radius:6px;display:flex;align-items:center;justify-content:center;margin:0 auto 20px;">
                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#4a5a72" stroke-width="1.2">
                        <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/>
                        <polyline points="14 2 14 8 20 8"/>
                    </svg>
                </div>
                <h3 style="font-family:'Instrument Serif',serif;font-size:22px;font-weight:400;color:#fff;margin-bottom:10px;">Noticias en camino</h3>
                <p style="font-size:13px;color:#6a7a9a;line-height:1.75;">Pronto encontrarás aquí las últimas novedades fiscales, actualizadas automáticamente cada día.</p>
            </div>

        </section>

    </PublicLayout>
</template>