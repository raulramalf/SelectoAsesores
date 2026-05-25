<script setup>
import { Link } from '@inertiajs/vue3';
</script>

<template>
    <div class="guest-layout">
        <!-- Background SA monogram -->
        <div class="guest-monogram" aria-hidden="true">SA</div>

        <!-- Centered form card -->
        <div class="guest-card">
            <Link href="/" class="guest-logo-link">
                <img src="/favicon.ico" alt="Selecto Asesores" class="guest-logo-img" />
            </Link>
            <div class="guest-card__body">
                <slot />
            </div>
        </div>
    </div>
</template>

<style>
@import '../../css/guestlayout.css';
</style>