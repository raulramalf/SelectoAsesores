<script setup>
import PublicLayout from '@/Layouts/PublicLayout.vue'
import { Link, Head } from '@inertiajs/vue3'
import { ref, computed } from 'vue'

const props = defineProps({
    noticias: { type: Array, default: () => [] },
    tab: { type: String, default: 'noticias' },
})

const tabActivo = ref(props.tab)
function cambiarTab(t) {
    tabActivo.value = t
    try {
        const url = new URL(window.location.href)
        t === 'calculadoras' ? url.searchParams.set('tab', t) : url.searchParams.delete('tab')
        window.history.replaceState({}, '', url)
    } catch (e) { /* sin historial disponible */ }
}

const filtroActivo = ref('Todas')
const busqueda = ref('')
const filtros = ['Todas', 'IRPF', 'IVA', 'Sociedades', 'Autónomos', 'BOE']

const noticiasFiltradas = computed(() => props.noticias.filter(n => {
    const etiqueta = `${n.category ?? ''} ${n.source ?? ''}`.toLowerCase()
    const matchFiltro = filtroActivo.value === 'Todas' || etiqueta.includes(filtroActivo.value.toLowerCase())
    const matchBusqueda = (n.title ?? '').toLowerCase().includes(busqueda.value.toLowerCase())
    return matchFiltro && matchBusqueda
}))

const calculadoras = [
    {
        href: '/blog/calculadoras/irpf',
        titulo: 'IRPF: salario neto vs bruto y compraventas',
        texto: 'Calcula tu nómina neta desde el bruto (o al revés) y el IRPF de la venta de acciones o de una vivienda.',
    },
    {
        href: '/blog/calculadoras/autonomos',
        titulo: 'Autónomos: cuota y SL vs autónomo',
        texto: 'Tu cuota de autónomo según rendimientos netos y una comparativa del neto que te queda como autónomo o como SL.',
    },
]
</script>

<template>
    <PublicLayout>
        <Head title="Blog" />

        <section class="news-hero">
            <div class="blog-hero__bg">
                <img src="https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=1600&q=80" alt="" />
            </div>
            <div class="blog-hero__overlay"></div>
            <div class="news-hero__content">
                <span class="blog-hero__tag">BLOG</span>
                <h1 class="blog-hero__title">Noticias y<br>novedades tributarias</h1>
                <p class="blog-hero__desc">
                    Mantente informado sobre los últimos cambios en legislación fiscal, novedades de la AEAT y consejos para optimizar tu situación tributaria. Además, calculadoras para decidir con números.
                </p>
            </div>
        </section>

        <section class="blog-tabs">
            <div class="blog-tabs__inner" role="tablist">
                <button role="tab" :aria-selected="tabActivo === 'noticias'" class="blog-tab" :class="{ 'is-active': tabActivo === 'noticias' }" @click="cambiarTab('noticias')">Noticias</button>
                <button role="tab" :aria-selected="tabActivo === 'calculadoras'" class="blog-tab" :class="{ 'is-active': tabActivo === 'calculadoras' }" @click="cambiarTab('calculadoras')">Calculadoras</button>
            </div>
        </section>

        <!-- NOTICIAS -->
        <template v-if="tabActivo === 'noticias'">
            <section class="blog-filtros">
                <div class="news-filtros">
                    <div class="news-filtros__tabs">
                        <button v-for="f in filtros" :key="f" @click="filtroActivo = f"
                            class="filtro-chip" :class="{ 'is-active': filtroActivo === f }">
                            {{ f }}
                        </button>
                    </div>
                    <input v-model="busqueda" type="text" placeholder="Buscar noticias..." class="news-busqueda" />
                </div>
            </section>

            <section class="news-grid-section" style="min-height:60vh;">
                <div v-if="noticiasFiltradas.length > 0" class="news-grid">
                    <article v-for="noticia in noticiasFiltradas" :key="noticia.id" class="blog-card">
                        <a :href="noticia.source_url" target="_blank" rel="noopener noreferrer" class="blog-card__img">
                            <img v-if="noticia.image" :src="noticia.image" :alt="noticia.title">
                            <div v-else class="blog-card__ph">
                                <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="#2a3a52" stroke-width="1.2">
                                    <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/>
                                </svg>
                            </div>
                        </a>
                        <div class="blog-card__body">
                            <span class="blog-card__source">{{ noticia.source }}</span>
                            <a :href="noticia.source_url" target="_blank" rel="noopener noreferrer" class="blog-card__link">
                                <h3 class="blog-card__title">{{ noticia.title }}</h3>
                            </a>
                            <p class="blog-card__summary">{{ noticia.summary }}</p>
                            <div class="blog-card__foot">
                                <span class="blog-card__date">{{ noticia.published_at }}</span>
                                <a :href="noticia.source_url" target="_blank" rel="noopener noreferrer" class="blog-card__more">Leer original</a>
                            </div>
                        </div>
                    </article>
                </div>

                <div v-else class="blog-empty">
                    <div class="blog-empty__icon">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#4a5a72" stroke-width="1.2">
                            <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/>
                        </svg>
                    </div>
                    <h3>Noticias en camino</h3>
                    <p>Pronto encontrarás aquí las últimas novedades fiscales, actualizadas automáticamente cada día.</p>
                </div>
            </section>
        </template>

        <!-- CALCULADORAS -->
        <section v-else class="news-grid-section" style="min-height:60vh;">
            <div class="blog-calcs">
                <Link v-for="c in calculadoras" :key="c.href" :href="c.href" class="blog-calc">
                    <h3>{{ c.titulo }}</h3>
                    <p>{{ c.texto }}</p>
                    <span>Abrir calculadora &rarr;</span>
                </Link>
            </div>
            <p class="blog-calcs__note">Resultados orientativos con normativa estatal y escala autonómica general. No sustituyen el asesoramiento personalizado.</p>
        </section>
    </PublicLayout>
</template>
