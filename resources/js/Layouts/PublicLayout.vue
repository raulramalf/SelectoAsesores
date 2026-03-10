<script setup>
import { Link } from '@inertiajs/vue3';
</script>

<template>
  <div class="min-h-screen bg-gray-50 text-gray-900 font-sans">
    <header class="bg-white shadow-sm sticky top-0 z-50">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between h-16 items-center">
          <div class="flex-shrink-0 flex items-center">
            <Link href="/" class="text-2xl font-bold text-blue-900 tracking-tighter">
              SELECTO<span class="font-light">ASESORES</span>
            </Link>
          </div>
          <nav class="hidden md:flex space-x-8">
            <Link href="/" class="text-gray-700 hover:text-blue-600 font-medium">INICIO</Link>
            <Link href="/servicios" class="text-gray-700 hover:text-blue-600 font-medium">SERVICIOS</Link>
            <Link href="/nosotros" class="text-gray-700 hover:text-blue-600 font-medium">NOSOTROS</Link>
            <Link href="/noticias" class="text-gray-700 hover:text-blue-600 font-medium">NOTICIAS</Link>
          </nav>
          <div>
            <Link href="/reserva" class="bg-blue-600 hover:bg-blue-700 text-white px-5 py-2 rounded-md font-medium transition">
              SOLICITA TU PLAZA
            </Link>
          </div>
        </div>
      </div>
    </header>

    <main>
      <slot />
    </main>

    <footer class="bg-gray-900 text-white py-8 mt-12">
      <div class="max-w-7xl mx-auto px-4 text-center">
        <p>&copy; 2024 Selecto Asesores. Todos los derechos reservados.</p>
      </div>
    </footer>
  </div>
</template>