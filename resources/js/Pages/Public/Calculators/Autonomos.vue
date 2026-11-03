<script setup>
import PublicLayout from '@/Layouts/PublicLayout.vue'
import { Link, Head } from '@inertiajs/vue3'
import { ref, computed } from 'vue'
import { cuotaAutonomo, escenarioAutonomo, escenarioSL, eur, eur2, pct } from '@/utils/taxCalculators'

const modo = ref('cuota')

// Cuota
const rendimientoMensual = ref(2000)
const cuota = computed(() => cuotaAutonomo(rendimientoMensual.value))

// Autónomo vs SL
const ingresos = ref(60000)
const gastos = ref(15000)
const salarioAdmin = ref(18000)
const costeGestoria = ref(1500)
const tipoIS = ref(0.23)
const reparto = ref(100)
const hijos = ref(0)

const auto = computed(() => escenarioAutonomo({ ingresos: ingresos.value, gastos: gastos.value, hijos: hijos.value }))
const sl = computed(() => escenarioSL({
    ingresos: ingresos.value, gastos: gastos.value, salarioAdmin: salarioAdmin.value,
    costeGestoria: costeGestoria.value, tipoIS: Number(tipoIS.value),
    repartoDividendos: reparto.value / 100, hijos: hijos.value,
}))
const diferencia = computed(() => sl.value.neto - auto.value.neto)
const veredicto = computed(() => {
    const d = Math.abs(diferencia.value)
    if (d < 300) return 'Con estos datos ambas fórmulas quedan prácticamente igual. Priorizad otros factores: responsabilidad, imagen o planes de crecimiento.'
    return diferencia.value > 0
        ? `Con estos datos la SL te deja unos ${eur(d)} más al año en el bolsillo (sin contar lo que dejes en reservas).`
        : `Con estos datos ser autónomo te deja unos ${eur(d)} más al año que la SL, incluso contando sus costes de gestión.`
})
</script>

<template>
    <PublicLayout>
        <Head title="Calculadora autónomos" />
        <section class="calc-hero">
            <Link href="/blog?tab=calculadoras" class="calc-back">&larr; Blog · Calculadoras</Link>
            <span class="calc-hero__tag">Calculadora autónomos</span>
            <h1>Cuota de autónomo<br>y SL vs autónomo</h1>
            <p>Conoce tu cuota por ingresos reales y compara cuánto te queda como autónomo o con sociedad limitada.</p>
        </section>

        <section class="calc-wrap">
            <div class="calc-tabs" style="max-width:1200px;margin:0 auto 18px;">
                <button class="calc-tab" :class="{ 'is-active': modo === 'cuota' }" @click="modo = 'cuota'">Cuota de autónomo</button>
                <button class="calc-tab" :class="{ 'is-active': modo === 'comparar' }" @click="modo = 'comparar'">SL vs autónomo</button>
            </div>

            <!-- CUOTA -->
            <div v-if="modo === 'cuota'" class="calc-grid">
                <div class="calc-card">
                    <h2>Tus rendimientos</h2>
                    <div class="calc-field">
                        <label>Rendimientos netos mensuales previstos (€)</label>
                        <input type="number" min="0" step="50" v-model.number="rendimientoMensual">
                    </div>
                    <p style="font-size:12px;color:#6a7a9a;line-height:1.7;">Rendimiento neto = ingresos &minus; gastos deducibles (antes de la cuota de autónomos), en media mensual del año.</p>
                </div>
                <div class="calc-card">
                    <h2>Resultado</h2>
                    <div class="calc-result__big">{{ eur2(cuota.cuotaMensual) }}</div>
                    <div class="calc-result__sub">Cuota mensual estimada · tramo {{ cuota.tramo }} de 15</div>
                    <div class="calc-line"><span>Base de cotización mínima del tramo</span><strong>{{ eur2(cuota.base) }}</strong></div>
                    <div class="calc-line"><span>Tipo de cotización</span><strong>31,5 %</strong></div>
                    <div class="calc-line calc-line--total"><span>Cuota anual</span><strong>{{ eur(cuota.cuotaMensual * 12) }}</strong></div>
                </div>
            </div>

            <!-- COMPARATIVA -->
            <div v-else class="calc-grid">
                <div class="calc-card">
                    <h2>Tu actividad</h2>
                    <div class="calc-row2">
                        <div class="calc-field"><label>Facturación anual (€)</label><input type="number" min="0" step="1000" v-model.number="ingresos"></div>
                        <div class="calc-field"><label>Gastos deducibles anuales (€)</label><input type="number" min="0" step="500" v-model.number="gastos"></div>
                    </div>
                    <div class="calc-row2">
                        <div class="calc-field"><label>Sueldo bruto del administrador en la SL (€)</label><input type="number" min="0" step="500" v-model.number="salarioAdmin"></div>
                        <div class="calc-field"><label>Coste extra gestoría SL (€/año)</label><input type="number" min="0" step="100" v-model.number="costeGestoria"></div>
                    </div>
                    <div class="calc-row2">
                        <div class="calc-field">
                            <label>Impuesto de Sociedades</label>
                            <select v-model="tipoIS"><option :value="0.23">23 % (general)</option><option :value="0.15">15 % (nueva creación)</option></select>
                        </div>
                        <div class="calc-field">
                            <label>Beneficio repartido como dividendos (%)</label>
                            <input type="number" min="0" max="100" v-model.number="reparto">
                        </div>
                    </div>
                    <div class="calc-field"><label>Hijos a cargo</label><input type="number" min="0" max="10" v-model.number="hijos"></div>
                </div>

                <div class="calc-card">
                    <h2>Comparativa anual</h2>
                    <div class="calc-compare">
                        <div class="calc-compare__box" :class="{ 'is-winner': diferencia <= 0 }">
                            <div class="calc-compare__name">Autónomo</div>
                            <div class="calc-compare__val">{{ eur(auto.neto) }}</div>
                        </div>
                        <div class="calc-compare__box" :class="{ 'is-winner': diferencia > 0 }">
                            <div class="calc-compare__name">SL</div>
                            <div class="calc-compare__val">{{ eur(sl.neto) }}</div>
                        </div>
                    </div>
                    <p class="calc-verdict">{{ veredicto }}</p>

                    <div class="calc-line"><span><strong>Autónomo</strong> · cuota SS ({{ eur2(auto.cuotaMensual) }}/mes)</span><strong>- {{ eur(auto.cuotaAnual) }}</strong></div>
                    <div class="calc-line"><span>Autónomo · IRPF</span><strong>- {{ eur(auto.irpf) }}</strong></div>
                    <div class="calc-line"><span><strong>SL</strong> · cuota autónomo societario ({{ eur2(sl.cuotaMensual) }}/mes)</span><strong>- {{ eur(sl.ssAdmin) }}</strong></div>
                    <div class="calc-line"><span>SL · IRPF del sueldo</span><strong>- {{ eur(sl.irpfSalario) }}</strong></div>
                    <div class="calc-line"><span>SL · Impuesto de Sociedades</span><strong>- {{ eur(sl.is) }}</strong></div>
                    <div class="calc-line"><span>SL · IRPF de dividendos</span><strong>- {{ eur(sl.irpfDividendos) }}</strong></div>
                    <div class="calc-line"><span>SL · beneficio retenido en reservas</span><strong>{{ eur(sl.reservas) }}</strong></div>
                    <div class="calc-line calc-line--total"><span>Impuestos y SS totales (autónomo / SL)</span><strong>{{ eur(auto.impuestosYSS) }} / {{ eur(sl.impuestosYSS) }}</strong></div>
                </div>
            </div>

            <p class="calc-note">
                Estimación orientativa 2026: cuota por tramos de rendimientos netos con el tipo del 31,5 % sobre la base mínima de cada tramo; estimación directa simplificada (7 % de gastos de difícil justificación, máx. 2.000 €); el administrador de la SL cotiza en autónomos según su sueldo. No incluye tarifa plana, deducciones, bonificaciones ni costes de constitución. ¿Dudas sobre qué forma jurídica te conviene?
                <Link href="/reserva">Reserva una cita con nuestros asesores</Link>.
            </p>
        </section>
    </PublicLayout>
</template>
