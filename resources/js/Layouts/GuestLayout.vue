<script setup>
import { Link } from '@inertiajs/vue3';
</script>

<template>
    <div class="min-h-screen flex flex-col sm:justify-center items-center pt-6 sm:pt-0 bg-[#151F2B]">
        <div>
            <Link href="/">
                <img src="/favicon.ico" alt="Selecto Asesores" class="h-20 w-auto" />
            </Link>
        </div>

        <div class="w-full sm:max-w-md mt-6 px-6 py-8 bg-[#1c2d3f] shadow-xl overflow-hidden sm:rounded-lg border border-white/5">
            <slot />
        </div>
    </div>
</template>