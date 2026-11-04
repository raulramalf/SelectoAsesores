<script setup>
import PublicLayout from '@/Layouts/PublicLayout.vue'
import { Link, Head } from '@inertiajs/vue3'
import { computed } from 'vue'

const props = defineProps({ noticia: { type: Object, required: true } })

// El cuerpo se muestra como texto (nunca como HTML) y se separa en párrafos.
const parrafos = computed(() =>
    (props.noticia.content || '').split(/\n{2,}/).map(p => p.trim()).filter(Boolean)
)
const tieneFicha = computed(() => props.noticia.affects || props.noticia.impact)
</script>

<template>
    <PublicLayout>
        <Head :title="noticia.title">
            <meta v-if="noticia.summary" name="description" :content="noticia.summary" />
        </Head>

        <section class="page-hero post-hero">
            <div class="hx-container post-hero__inner">
                <Link href="/blog" class="calc-back">&larr; Blog</Link>
                <span class="hx-eyebrow">{{ noticia.category_label }}</span>
                <h1>{{ noticia.title }}</h1>
                <p v-if="noticia.summary">{{ noticia.summary }}</p>
                <span class="post-date">Publicado el {{ noticia.date }}</span>
            </div>
        </section>

        <article class="hx-section post">
            <div class="hx-container post__grid">
                <div class="post__body">
                    <p v-for="(p, i) in parrafos" :key="i">{{ p }}</p>
                </div>

                <aside class="post__side">
                    <dl v-if="tieneFicha" class="post__facts">
                        <div v-if="noticia.affects">
                            <dt>A quién afecta</dt>
                            <dd>{{ noticia.affects }}</dd>
                        </div>
                        <div v-if="noticia.impact">
                            <dt>Impacto</dt>
                            <dd>{{ noticia.impact }}</dd>
                        </div>
                    </dl>

                    <div v-if="noticia.source || noticia.source_url" class="post__source">
                        <span class="hx-label">Fuente</span>
                        <p>
                            <template v-if="noticia.source">{{ noticia.source }}</template>
                            <template v-if="noticia.source_date"> · {{ noticia.source_date }}</template>
                        </p>
                        <a v-if="noticia.source_url" :href="noticia.source_url" target="_blank" rel="noopener noreferrer" class="link-arrow">Consultar la fuente</a>
                    </div>
                </aside>
            </div>
        </article>

        <section class="hx-cta">
            <div class="hx-container">
                <h2 class="hx-title">¿Te afecta este cambio?<br><em>Te ayudamos a valorarlo</em></h2>
                <div class="hx-actions" style="margin-top:32px;">
                    <Link href="/reserva" class="btn btn--primary">Reservar cita</Link>
                    <Link href="/blog" class="link-arrow">Más noticias</Link>
                </div>
            </div>
        </section>
    </PublicLayout>
</template>
