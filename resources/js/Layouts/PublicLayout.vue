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
                    <Link
                        :href="user.role === 'cliente' ? '/dashboard' : '/admin'"
                        class="nav__user"
                    >
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
    </div>
</template>