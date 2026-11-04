<script setup>
import PublicLayout from '@/Layouts/PublicLayout.vue'
import { Link, Head, router } from '@inertiajs/vue3'
import { ref, watch } from 'vue'

const props = defineProps({
    noticias: { type: Object, default: () => ({ data: [] }) },
    categorias: { type: Array, default: () => [] },
    filtros: { type: Object, default: () => ({ categoria: null, q: '' }) },
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

const busqueda = ref(props.filtros.q || '')

function filtrar(extra = {}) {
    const params = { categoria: props.filtros.categoria, q: busqueda.value, ...extra }
    Object.keys(params).forEach(k => { if (!params[k]) delete params[k] })
    router.get('/blog', params, { preserveState: true, preserveScroll: true, replace: true, only: ['noticias', 'filtros'] })
}

let temporizador
watch(busqueda, () => {
    clearTimeout(temporizador)
    temporizador = setTimeout(() => filtrar({ q: busqueda.value }), 350)
})

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
                <img src="/images/blog/cabecera.webp" alt="" loading="eager" decoding="async" onerror="this.style.display='none'" />
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
                        <button type="button" class="filtro-chip" :class="{ 'is-active': !filtros.categoria }" @click="filtrar({ categoria: null })">Todas</button>
                        <button v-for="c in categorias" :key="c.slug" type="button" class="filtro-chip"
                            :class="{ 'is-active': filtros.categoria === c.slug }" @click="filtrar({ categoria: c.slug })">
                            {{ c.label }}
                        </button>
                    </div>
                    <input v-model="busqueda" type="search" placeholder="Buscar artículos..." class="news-busqueda" aria-label="Buscar artículos" />
                </div>
            </section>

            <section class="news-grid-section" style="min-height:60vh;">
                <div v-if="noticias.data.length > 0" class="news-grid">
                    <article v-for="noticia in noticias.data" :key="noticia.id" class="blog-card">
                        <Link :href="`/blog/${noticia.slug}`" class="blog-card__img" :aria-label="noticia.title">
                            <img :src="noticia.image" alt="" loading="lazy" decoding="async">
                        </Link>
                        <div class="blog-card__body">
                            <span class="blog-card__source">{{ noticia.category_label }}</span>
                            <Link :href="`/blog/${noticia.slug}`" class="blog-card__link">
                                <h3 class="blog-card__title">{{ noticia.title }}</h3>
                            </Link>
                            <p class="blog-card__summary">{{ noticia.summary }}</p>
                            <div class="blog-card__foot">
                                <span class="blog-card__date">{{ noticia.date }}</span>
                                <Link :href="`/blog/${noticia.slug}`" class="blog-card__more">Leer artículo</Link>
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
                    <h3>{{ filtros.categoria || filtros.q ? 'Sin resultados' : 'Noticias en camino' }}</h3>
                    <p v-if="filtros.categoria || filtros.q">No hay artículos con ese filtro. Prueba con otra categoría o búsqueda.</p>
                    <p v-else>Pronto encontrarás aquí las últimas novedades fiscales, actualizadas automáticamente cada día.</p>
                </div>

                <nav v-if="noticias.last_page > 1" class="blog-pager" aria-label="Paginación">
                    <Link v-if="noticias.prev_page_url" :href="noticias.prev_page_url" preserve-scroll class="link-arrow blog-pager__prev">Anterior</Link>
                    <span v-else></span>
                    <span class="blog-pager__info">Página {{ noticias.current_page }} de {{ noticias.last_page }}</span>
                    <Link v-if="noticias.next_page_url" :href="noticias.next_page_url" preserve-scroll class="link-arrow">Siguiente</Link>
                    <span v-else></span>
                </nav>
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
