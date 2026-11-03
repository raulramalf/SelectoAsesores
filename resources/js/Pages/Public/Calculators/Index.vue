<script setup>
import PublicLayout from '@/Layouts/PublicLayout.vue'
import { Link, Head } from '@inertiajs/vue3'
</script>

<template>
    <PublicLayout>
        <Head title="Calculadoras fiscales" />
        <section class="calc-hero">
            <Link href="/noticias" class="calc-back">&larr; Volver a noticias</Link>
            <span class="calc-hero__tag">Calculadoras</span>
            <h1>Herramientas fiscales<br>para decidir con números</h1>
            <p>Simula tu salario neto, el impacto fiscal de una compraventa o qué te conviene más: autónomo o sociedad limitada.</p>
        </section>

        <section class="calc-wrap">
            <div class="calc-hub">
                <Link href="/noticias/calculadoras/irpf" class="calc-hub__card">
                    <h3>IRPF: salario neto vs bruto y compraventas</h3>
                    <p>Calcula tu nómina neta desde el bruto (o al revés) y el IRPF de la venta de acciones o de una vivienda.</p>
                    <span>Abrir calculadora &rarr;</span>
                </Link>
                <Link href="/noticias/calculadoras/autonomos" class="calc-hub__card">
                    <h3>Autónomos: cuota y SL vs autónomo</h3>
                    <p>Tu cuota de autónomo según rendimientos netos y una comparativa del neto que te queda como autónomo o como SL.</p>
                    <span>Abrir calculadora &rarr;</span>
                </Link>
            </div>
            <p class="calc-note">Resultados orientativos con normativa estatal y escala autonómica general. No sustituyen el asesoramiento personalizado.</p>
        </section>
    </PublicLayout>
</template>
