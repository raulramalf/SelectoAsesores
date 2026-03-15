<script setup>
import { Link, usePage, router } from '@inertiajs/vue3'
import { computed, ref } from 'vue'

const page = usePage()
const user = computed(() => page.props.auth?.user)
const dropdownOpen = ref(false)

const avatarUrl = computed(() => {
    if (user.value?.avatar) return `/storage/${user.value.avatar}`
    return null
})

function logout() {
    router.post('/logout')
}

const navItems = [
    { label: 'Dashboard',  href: '/dashboard',             icon: 'M2.25 12l8.954-8.955c.44-.439 1.152-.439 1.591 0L21.75 12M4.5 9.75v10.125c0 .621.504 1.125 1.125 1.125H9.75v-4.875c0-.621.504-1.125 1.125-1.125h2.25c.621 0 1.125.504 1.125 1.125V21h4.125c.621 0 1.125-.504 1.125-1.125V9.75M8.25 21h8.25' },
    { label: 'Solicitar Cita', href: '/dashboard/reserva', icon: 'M6.75 3v2.25M17.25 3v2.25M3 18.75V7.5a2.25 2.25 0 012.25-2.25h13.5A2.25 2.25 0 0121 7.5v11.25m-18 0A2.25 2.25 0 005.25 21h13.5A2.25 2.25 0 0021 18.75m-18 0v-7.5A2.25 2.25 0 015.25 9h13.5A2.25 2.25 0 0121 11.25v7.5' },    { label: 'Documentos', href: '/dashboard/documentos',  icon: 'M19.5 14.25v-2.625a3.375 3.375 0 00-3.375-3.375h-1.5A1.125 1.125 0 0113.5 7.125v-1.5a3.375 3.375 0 00-3.375-3.375H8.25m0 12.75h7.5m-7.5 3H12M10.5 2.25H5.625c-.621 0-1.125.504-1.125 1.125v17.25c0 .621.504 1.125 1.125 1.125h12.75c.621 0 1.125-.504 1.125-1.125V11.25a9 9 0 00-9-9z' },
    { label: 'Perfil',     href: '/dashboard/perfil',      icon: 'M15.75 6a3.75 3.75 0 11-7.5 0 3.75 3.75 0 017.5 0zM4.501 20.118a7.5 7.5 0 0114.998 0A17.933 17.933 0 0112 21.75c-2.676 0-5.216-.584-7.499-1.632z' },
]
</script>

<template>
    <div class="dashboard-layout">

        <!-- SIDEBAR -->
        <aside class="sidebar">
            <div class="sidebar__header">
                <Link href="/" class="sidebar__logo">SA</Link>
            </div>

            <nav class="sidebar__nav">
                <Link v-for="item in navItems" :key="item.href" :href="item.href" class="sidebar__item">
                    <svg width="18" height="18" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" :d="item.icon"/>
                    </svg>
                    {{ item.label }}
                </Link>
            </nav>

            <div class="sidebar__footer">
                <button @click="logout" class="sidebar__logout-btn">
                    <svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 9V5.25A2.25 2.25 0 0013.5 3h-6a2.25 2.25 0 00-2.25 2.25v13.5A2.25 2.25 0 007.5 21h6a2.25 2.25 0 002.25-2.25V15M12 9l-3 3m0 0l3 3m-3-3h12.75"/>
                    </svg>
                    Cerrar sesión
                </button>
            </div>
        </aside>

        <!-- CONTENIDO -->
        <div class="dashboard-content">

            <!-- TOPBAR -->
            <header class="dashboard-header">
                <div class="dashboard-header__title">
                    <slot name="header">Área Cliente</slot>
                </div>

                <div class="dashboard-header__right">
                    <button class="topbar-icon-btn">
                        <svg width="19" height="19" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M14.857 17.082a23.848 23.848 0 005.454-1.31A8.967 8.967 0 0118 9.75v-.7V9A6 6 0 006 9v.75a8.967 8.967 0 01-2.312 6.022c1.733.64 3.56 1.085 5.455 1.31m5.714 0a24.255 24.255 0 01-5.714 0m5.714 0a3 3 0 11-5.714 0"/>
                        </svg>
                    </button>

                    <div class="topbar-user" @click="dropdownOpen = !dropdownOpen">
                        <div class="topbar-avatar">
                            <img v-if="avatarUrl" :src="avatarUrl" :alt="user?.name" />
                            <span v-else>{{ user?.name?.charAt(0) }}</span>
                        </div>
                        <svg width="13" height="13" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"
                            :style="dropdownOpen ? 'transform:rotate(180deg);transition:.2s' : 'transition:.2s'">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 8.25l-7.5 7.5-7.5-7.5"/>
                        </svg>

                        <div v-if="dropdownOpen" class="topbar-dropdown">
                            <div class="topbar-dropdown__info">
                                <div style="display:flex;align-items:center;gap:10px;margin-bottom:10px;">
                                    <div class="topbar-avatar" style="width:36px;height:36px;font-size:15px;flex-shrink:0;">
                                        <img v-if="avatarUrl" :src="avatarUrl" :alt="user?.name" />
                                        <span v-else>{{ user?.name?.charAt(0) }}</span>
                                    </div>
                                    <div>
                                        <p class="topbar-dropdown__name">{{ user?.name }}</p>
                                        <p class="topbar-dropdown__email">{{ user?.email }}</p>
                                    </div>
                                </div>
                                <span class="topbar-dropdown__role">Cliente</span>
                            </div>
                            <div class="topbar-dropdown__divider"></div>
                            <Link href="/dashboard/perfil" class="topbar-dropdown__item">Mi perfil</Link>
                            <button @click="logout" class="topbar-dropdown__item topbar-dropdown__item--danger">Cerrar sesión</button>
                        </div>
                    </div>
                </div>
            </header>

            <main class="dashboard-main">
                <slot />
            </main>
        </div>

    </div>
</template>