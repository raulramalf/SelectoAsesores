<script setup>
import PublicLayout from '@/Layouts/PublicLayout.vue'
import { ref, computed } from 'vue'

const props = defineProps({ noticias: { type: Array, default: () => [] } })
const filtroActivo = ref('Todas')
const busqueda = ref('')
const filtros = ['Todas', 'IRPF', 'IVA', 'Sociedades', 'Autónomos', 'BOE']

const noticiasFiltradas = computed(() => props.noticias.filter(n => {
    const tituloSeguro = n.title || n.titulo || '';
    const fuenteSegura = n.source || n.fuente || 'General';
    
    const matchFiltro = filtroActivo.value === 'Todas' || fuenteSegura === filtroActivo.value
    const matchBusqueda = tituloSeguro.toLowerCase().includes(busqueda.value.toLowerCase())
    
    return matchFiltro && matchBusqueda
}))
</script>

<template>
    <PublicLayout>

        <section class="news-hero">
            <div style="position:absolute;inset:0;">
                <img src="https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=1600&q=80"
                     alt="noticias" style="width:100%;height:100%;object-fit:cover;object-position:center top;filter:grayscale(25%);">
            </div>
            <div style="position:absolute;inset:0;background:linear-gradient(180deg,rgba(21,31,43,.5) 0%,rgba(21,31,43,.92) 100%);"></div>
            <div class="news-hero__content">
                <span style="font-size:10px;letter-spacing:.22em;text-transform:uppercase;color:#E2CBAE;display:block;margin-bottom:10px;">ACTUALIDAD FISCAL</span>
                <h1 style="font-family:'Instrument Serif',serif;font-size:clamp(28px,5vw,60px);font-weight:400;color:#fff;line-height:1.05;margin-bottom:12px;">
                    Noticias y<br>novedades tributarias
                </h1>
                <p style="font-size:13px;color:#a0aabf;max-width:520px;line-height:1.75;font-weight:300;">
                    Mantente informado sobre los últimos cambios en legislación fiscal, novedades de la AEAT y consejos para optimizar tu situación tributaria.
                </p>
            </div>
        </section>

        <section style="background:#151F2B;border-bottom:1px solid rgba(255,255,255,.06);">
            <div class="news-filtros">
                <div class="news-filtros__tabs">
                    <button v-for="f in filtros" :key="f" @click="filtroActivo = f"
                        :style="`padding:6px 16px;border-radius:100px;font-size:11px;font-weight:400;cursor:pointer;font-family:'Inter',sans-serif;letter-spacing:.06em;transition:all .2s;border:${filtroActivo === f ? '1px solid rgba(226,203,174,.4)' : '1px solid transparent'};background:${filtroActivo === f ? 'rgba(226,203,174,.1)' : 'transparent'};color:${filtroActivo === f ? '#E2CBAE' : '#6a7a9a'};flex-shrink:0;`">
                        {{ f }}
                    </button>
                </div>
                <input v-model="busqueda" type="text" placeholder="Buscar noticias..."
                    class="news-busqueda" />
            </div>
        </section>

        <section class="news-grid-section" style="min-height:60vh;">

            <div v-if="noticiasFiltradas.length > 0" class="news-grid" style="display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 1.5rem;">
                <div v-for="noticia in noticiasFiltradas" :key="noticia.id"
                    style="background:#151F2B;border:1px solid rgba(255,255,255,.06);border-radius:6px;overflow:hidden; display: flex; flex-direction: column; height: 100%;">

                    <a :href="noticia.source_url || noticia.url" target="_blank" rel="noopener noreferrer"
                        style="display:block;height:140px;background:#1c2d3f;overflow:hidden;cursor:pointer;flex-shrink: 0;">
                        <img v-if="noticia.image || noticia.imagen" :src="noticia.image || noticia.imagen" :alt="noticia.title || noticia.titulo"
                            style="width:100%;height:100%;object-fit:cover;transition:transform .3s;"
                            @mouseover="$event.target.style.transform='scale(1.04)'"
                            @mouseleave="$event.target.style.transform='scale(1)'">
                        
                        <div v-else style="width:100%;height:100%;display:flex;align-items:center;justify-content:center;">
                            <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="#2a3a52" stroke-width="1.2">
                                <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/>
                            </svg>
                        </div>
                    </a>

                    <div style="padding:18px 16px; display: flex; flex-direction: column; flex-grow: 1;">
                        <span style="font-size:9px;font-weight:500;letter-spacing:.16em;text-transform:uppercase;color:#E2CBAE;display:block;margin-bottom:7px;">
                            {{ noticia.source || noticia.fuente }}
                        </span>
                        
                        <a :href="noticia.source_url || noticia.url" target="_blank" rel="noopener noreferrer" style="text-decoration:none;">
                            <h3 style="font-family:'Instrument Serif',serif;font-size:16px;font-weight:400;color:#fff;line-height:1.35;margin-bottom:8px;transition:color .2s; height: 3.9em; overflow: hidden; display: -webkit-box; -webkit-line-clamp: 3; -webkit-box-orient: vertical;"
                                @mouseover="$event.target.style.color='#E2CBAE'"
                                @mouseleave="$event.target.style.color='#fff'">
                                {{ noticia.title || noticia.titulo }}
                            </h3>
                        </a>
                        
                        <p style="font-size:11px;color:#6a7a9a;line-height:1.7;margin-bottom:14px; text-align: justify; flex-grow: 1; height: 8.5em; overflow: hidden; display: -webkit-box; -webkit-line-clamp: 5; -webkit-box-orient: vertical;">
                            {{ noticia.summary || noticia.resumen }}
                        </p>
                        
                        <div style="display:flex;justify-content:space-between;align-items:center; margin-top: auto;">
                            <span style="font-size:10px;color:#4a5a72;">{{ noticia.published_at || '' }}</span>
                            <a :href="noticia.source_url || noticia.url" target="_blank" rel="noopener noreferrer"
                                style="font-size:10px;color:#E2CBAE;text-decoration:none;letter-spacing:.08em;text-transform:uppercase;">Leer original</a>
                        </div>
                    </div>
                </div>
            </div>

            <div v-else style="text-align:center;padding:80px 20px;max-width:400px;margin:0 auto;">
                <div style="width:56px;height:56px;border:1px solid rgba(255,255,255,.08);border-radius:6px;display:flex;align-items:center;justify-content:center;margin:0 auto 20px;">
                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#4a5a72" stroke-width="1.2">
                        <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/>
                    </svg>
                </div>
                <h3 style="font-family:'Instrument Serif',serif;font-size:22px;font-weight:400;color:#fff;margin-bottom:10px;">Noticias en camino</h3>
                <p style="font-size:13px;color:#6a7a9a;line-height:1.75;">Pronto encontrarás aquí las últimas novedades fiscales, actualizadas automáticamente cada día.</p>
            </div>
        </section>

    </PublicLayout>
</template>