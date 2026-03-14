<script setup>
import { Link, Head, usePage } from '@inertiajs/vue3'
import { computed } from 'vue'
const page = usePage()
const user = computed(() => page.props.auth?.user)
</script>

<template>
    <Head>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link href="https://fonts.googleapis.com/css2?family=Instrument+Serif:ital@0;1&family=Inria+Serif:ital,wght@0,400;0,700;1,400&family=Inter:wght@300;400;500&display=swap" rel="stylesheet">
    </Head>

    <div>
        <nav class="nav">
            <Link href="/" class="nav__logo">SA</Link>
            <ul class="nav__links">
                <li><Link href="/">Inicio</Link></li>
                <li><Link href="/servicios">Servicios</Link></li>
                <li><Link href="/nosotros">Nosotros</Link></li>
                <li><Link href="/noticias">Noticias</Link></li>
                <li><Link href="/contacto">Contacto</Link></li>
            </ul>
            <div class="nav__right">
                <template v-if="user">
                    <Link :href="user.role === 'cliente' ? '/dashboard' : '/admin'" class="nav__user">
                        <svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 6a3.75 3.75 0 1 1-7.5 0 3.75 3.75 0 0 1 7.5 0ZM4.501 20.118a7.5 7.5 0 0 1 14.998 0A17.933 17.933 0 0 1 12 21.75c-2.676 0-5.216-.584-7.499-1.632Z"/>
                        </svg>
                        Mi panel
                    </Link>
                </template>
                <template v-else>
                    <Link href="/login" class="nav__login">
                        <svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 6a3.75 3.75 0 1 1-7.5 0 3.75 3.75 0 0 1 7.5 0ZM4.501 20.118a7.5 7.5 0 0 1 14.998 0A17.933 17.933 0 0 1 12 21.75c-2.676 0-5.216-.584-7.499-1.632Z"/>
                        </svg>
                        Acceder
                    </Link>
                    <Link href="/reserva" class="nav__cta">Reservar cita</Link>
                </template>
            </div>
        </nav>

        <main>
            <slot />
        </main>

        <footer class="footer">
            <div class="footer__grid">
                <div>
                    <Link href="/" class="footer__logo">SA</Link>
                    <p class="footer__desc">Asesoría fiscal y contable para autónomos, pymes y empresas. Profesionalidad y confianza desde el primer día.</p>
                </div>
                <div>
                    <p class="footer__heading">Servicios</p>
                    <ul class="footer__list">
                        <li><Link href="/servicios">Declaración de la Renta</Link></li>
                        <li><Link href="/servicios">Asesoría Fiscal</Link></li>
                        <li><Link href="/servicios">Contabilidad</Link></li>
                        <li><Link href="/servicios">Autónomos</Link></li>
                    </ul>
                </div>
                <div>
                    <p class="footer__heading">Empresa</p>
                    <ul class="footer__list">
                        <li><Link href="/nosotros">Nosotros</Link></li>
                        <li><Link href="/noticias">Noticias</Link></li>
                        <li><Link href="/reserva">Reservar cita</Link></li>
                        <li><Link href="/contacto">Contacto</Link></li>
                    </ul>
                </div>
                <div>
                    <p class="footer__heading">Contacto</p>
                    <ul class="footer__list">
                        <li><span>555-555-555</span></li>
                        <li><span>selectoasesores@contacto.com</span></li>
                        <li><span>@selectoasesores</span></li>
                        <li><span>linkedin/selectoasesores</span></li>
                    </ul>
                </div>
            </div>
            <div class="footer__bottom">
                <span class="footer__copy">© 2025 Selecto Asesores S.L. Todos los derechos reservados.</span>
                <div class="footer__legal">
                    <Link href="#">Aviso Legal</Link>
                    <Link href="#">Privacidad</Link>
                    <Link href="#">Cookies</Link>
                </div>
            </div>
        </footer>

        <!-- WHATSAPP FLOTANTE -->
        <a
            href="https://wa.me/34555555555?text=Hola,%20me%20gustaría%20obtener%20información%20sobre%20sus%20servicios%20de%20asesoría."
            target="_blank"
            rel="noopener noreferrer"
            class="whatsapp-btn"
            aria-label="Contactar por WhatsApp"
        >
            <svg width="26" height="26" viewBox="0 0 24 24" fill="currentColor">
                <path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893a11.821 11.821 0 00-3.48-8.413z"/>
            </svg>
            <span class="whatsapp-btn__text">¿Hablamos?</span>
        </a>

    </div>
</template>