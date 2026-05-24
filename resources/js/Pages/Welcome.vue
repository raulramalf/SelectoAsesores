<script setup>
import { Head, Link } from '@inertiajs/vue3';

defineProps({
    canLogin: {
        type: Boolean,
    },
    canRegister: {
        type: Boolean,
    },
    laravelVersion: {
        type: String,
        required: true,
    },
    phpVersion: {
        type: String,
        required: true,
    },
});
</script>

<template>
    <Head title="Inicio | Selecto Asesores" />

    <div class="min-h-screen">
        <header class="flex justify-between items-center px-[5vw] py-8 border-b border-brand-secondary bg-brand-main">
            <div class="font-serif text-3xl text-brand-gold tracking-wide">
                SELECTO ASESORES
            </div>
            
            <nav class="flex items-center gap-8">
                <ul class="flex gap-8 m-0 p-0 list-none">
                    <li><a href="#inicio" class="text-white text-sm uppercase tracking-wider hover:text-brand-gold transition-colors duration-300">Inicio</a></li>
                    <li><a href="#servicios" class="text-white text-sm uppercase tracking-wider hover:text-brand-gold transition-colors duration-300">Servicios</a></li>
                    <li><a href="#nosotros" class="text-white text-sm uppercase tracking-wider hover:text-brand-gold transition-colors duration-300">Nosotros</a></li>
                    <li><a href="#noticias" class="text-white text-sm uppercase tracking-wider hover:text-brand-gold transition-colors duration-300">Noticias</a></li>
                </ul>

                <div v-if="canLogin" class="flex gap-4 border-l border-brand-secondary pl-8">
                    <Link v-if="$page.props.auth.user" :href="route('dashboard')" class="text-brand-gold font-semibold text-sm uppercase tracking-wider hover:text-white transition-colors">
                        Ir al Dashboard
                    </Link>
                    <template v-else>
                        <Link :href="route('login')" class="text-brand-gold font-semibold text-sm uppercase tracking-wider hover:text-white transition-colors">
                            Acceso Clientes
                        </Link>
                    </template>
                </div>
            </nav>
        </header>

        <main>
            <section id="inicio" class="bg-brand-secondary text-center py-32 px-[5vw]">
                <h1 class="font-serif text-5xl md:text-6xl text-brand-gold mb-6 font-normal">
                    Una nueva forma de entender la asesoría
                </h1>
                <p class="text-lg md:text-xl max-w-2xl mx-auto mb-10 leading-relaxed text-gray-200 font-light">
                    Asesoría fiscal personalizada para tu empresa. Gestionamos la totalidad de tus declaraciones e impuestos.
                </p>
                <a href="#contacto" class="inline-block bg-brand-gold text-brand-main px-8 py-3 font-semibold rounded uppercase text-sm tracking-wider hover:bg-white transition-colors duration-300">
                    SOLICITA TU PLAZA
                </a>
            </section>

            <section id="servicios" class="py-24 px-[5vw] bg-brand-main">
                <h2 class="font-serif text-4xl text-brand-gold mb-12 text-center">NUESTROS SERVICIOS</h2>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-12 max-w-5xl mx-auto">
                    <div>
                        <ul class="space-y-4 text-lg text-gray-300 font-light">
                            <li class="flex items-center gap-3"><span class="text-brand-gold">✦</span> Declaración de la renta</li>
                            <li class="flex items-center gap-3"><span class="text-brand-gold">✦</span> Asesoría fiscal integral</li>
                            <li class="flex items-center gap-3"><span class="text-brand-gold">✦</span> Contabilidad de empresa</li>
                            <li class="flex items-center gap-3"><span class="text-brand-gold">✦</span> Gestión de Autónomos</li>
                            <li class="flex items-center gap-3"><span class="text-brand-gold">✦</span> Constitución de Sociedades</li>
                            <li class="flex items-center gap-3"><span class="text-brand-gold">✦</span> Consultoría Tributaria</li>
                        </ul>
                    </div>
                    <div class="flex flex-col justify-center gap-6 border-l border-brand-secondary pl-12">
                        <p class="text-3xl font-semibold text-white"><span class="text-brand-gold">120€</span> / mes + IVA</p>
                        <p class="text-3xl font-semibold text-white"><span class="text-brand-gold">200€</span> / mes + IVA</p>
                    </div>
                </div>
            </section>

            <section id="nosotros" class="py-24 px-[5vw] bg-brand-tertiary text-center">
                <h2 class="font-serif text-4xl text-brand-gold mb-4">SELECTO ASESORES</h2>
                <p class="text-xl text-gray-300 font-light mb-16">Los profesionales detrás de tu tranquilidad</p>
                
                <div class="grid grid-cols-1 md:grid-cols-2 gap-12 max-w-4xl mx-auto text-left">
                    <div class="bg-brand-main p-8 rounded-lg border border-brand-secondary">
                        <h3 class="font-serif text-2xl text-brand-gold mb-4">NUESTRA MISIÓN</h3>
                        <p class="text-gray-300 font-light leading-relaxed">Proporcionar seguridad y eficiencia fiscal a nuestros clientes, garantizando el cumplimiento normativo mientras optimizamos sus recursos.</p>
                    </div>
                    <div class="bg-brand-main p-8 rounded-lg border border-brand-secondary">
                        <h3 class="font-serif text-2xl text-brand-gold mb-4">NUESTRA VISIÓN</h3>
                        <p class="text-gray-300 font-light leading-relaxed">Ser la firma de referencia en asesoramiento digital, integrando tecnología y trato humano para impulsar el éxito empresarial.</p>
                    </div>
                </div>
            </section>

            <section id="noticias" class="py-24 px-[5vw] bg-brand-secondary">
                <div class="max-w-4xl mx-auto text-center">
                    <h2 class="font-serif text-4xl text-brand-gold mb-6">Noticias y novedades tributarias</h2>
                    <p class="text-lg text-gray-300 font-light mb-12">Todo lo que tu empresa necesita en un solo lugar</p>
                    
                    <div class="bg-brand-main h-48 flex items-center justify-center rounded-lg border border-dashed border-brand-tertiary mb-16">
                        <p class="text-gray-500 italic">Espacio dinámico para noticias (Conectado a N8N en próximos sprints)</p>
                    </div>

                    <h3 class="font-serif text-3xl text-brand-gold mb-8" id="contacto">Cuéntanos tu situación</h3>
                    </div>
            </section>
        </main>
    </div>
</template>