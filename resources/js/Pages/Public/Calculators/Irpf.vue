<script setup>
import PublicLayout from '@/Layouts/PublicLayout.vue'
import { Link, Head } from '@inertiajs/vue3'
import { ref, computed } from 'vue'
import { nominaDesdeBruto, nominaDesdeNeto, compraventa, eur, eur2, pct } from '@/utils/taxCalculators'

const modo = ref('salario')

// Salario
const sentido = ref('bruto')
const importe = ref(30000)
const pagas = ref(14)
const hijos = ref(0)
const mayor65 = ref(false)

const nomina = computed(() => {
    const args = { pagas: Number(pagas.value), hijos: Number(hijos.value), mayor65: mayor65.value }
    return sentido.value === 'bruto'
        ? nominaDesdeBruto({ bruto: importe.value, ...args })
        : nominaDesdeNeto({ neto: importe.value, ...args })
})

// Compraventa
const activo = ref('acciones')
const compra = ref(10000)
const gastosCompra = ref(0)
const mejoras = ref(0)
const venta = ref(20000)
const gastosVenta = ref(0)
const plusvaliaMunicipal = ref(0)
const otrasRentas = ref(0)
const viviendaHabitual = ref(false)
const reinversion = ref(0)
const mayor65Venta = ref(false)

const operacion = computed(() => compraventa({
    tipo: activo.value,
    valorCompra: compra.value, gastosCompra: gastosCompra.value, mejoras: mejoras.value,
    valorVenta: venta.value, gastosVenta: gastosVenta.value, plusvaliaMunicipal: plusvaliaMunicipal.value,
    otrasRentasAhorro: otrasRentas.value,
    viviendaHabitual: viviendaHabitual.value, reinversion: reinversion.value, mayor65: mayor65Venta.value,
}))
</script>

<template>
    <PublicLayout>
        <Head title="Calculadora IRPF" />
        <section class="calc-hero">
            <Link href="/blog?tab=calculadoras" class="calc-back">&larr; Blog · Calculadoras</Link>
            <span class="calc-hero__tag">Calculadora IRPF</span>
            <h1>Salario neto vs bruto<br>y compraventa de acciones o vivienda</h1>
            <p>Estima cuánto cobras realmente y cuánto tributas al vender un activo.</p>
        </section>

        <section class="calc-wrap">
            <div class="calc-tabs" style="max-width:1200px;margin:0 auto 18px;">
                <button class="calc-tab" :class="{ 'is-active': modo === 'salario' }" @click="modo = 'salario'">Salario neto / bruto</button>
                <button class="calc-tab" :class="{ 'is-active': modo === 'venta' }" @click="modo = 'venta'">Compraventa acciones / vivienda</button>
            </div>

            <!-- SALARIO -->
            <div v-if="modo === 'salario'" class="calc-grid">
                <div class="calc-card">
                    <h2>Tus datos</h2>
                    <div class="calc-field">
                        <label>Quiero calcular a partir del salario…</label>
                        <select v-model="sentido">
                            <option value="bruto">Bruto anual &rarr; neto</option>
                            <option value="neto">Neto anual &rarr; bruto necesario</option>
                        </select>
                    </div>
                    <div class="calc-field">
                        <label>Salario {{ sentido }} anual (€)</label>
                        <input type="number" min="0" step="500" v-model.number="importe">
                    </div>
                    <div class="calc-row2">
                        <div class="calc-field">
                            <label>Número de pagas</label>
                            <select v-model.number="pagas"><option :value="12">12</option><option :value="14">14</option></select>
                        </div>
                        <div class="calc-field">
                            <label>Hijos a cargo</label>
                            <input type="number" min="0" max="10" v-model.number="hijos">
                        </div>
                    </div>
                    <label class="calc-check"><input type="checkbox" v-model="mayor65"> Mayor de 65 años</label>
                </div>

                <div class="calc-card">
                    <h2>Resultado</h2>
                    <div class="calc-result__big">{{ eur(nomina.neto) }}</div>
                    <div class="calc-result__sub">Neto anual · {{ eur(nomina.netoMensual) }} al mes en {{ pagas }} pagas</div>
                    <div class="calc-line"><span>Salario bruto anual</span><strong>{{ eur(nomina.bruto) }}</strong></div>
                    <div class="calc-line calc-line--neg"><span>Seguridad Social trabajador</span><strong>- {{ eur(nomina.ss) }}</strong></div>
                    <div class="calc-line calc-line--neg"><span>IRPF estimado</span><strong>- {{ eur(nomina.irpf) }}</strong></div>
                    <div class="calc-line"><span>Tipo efectivo IRPF / marginal</span><strong>{{ pct(nomina.tipoEfectivo) }} / {{ pct(nomina.tipoMarginal) }}</strong></div>
                    <div class="calc-line"><span>Presión total (SS + IRPF)</span><strong>{{ pct(nomina.presionTotal) }}</strong></div>
                    <div class="calc-line calc-line--total"><span>Coste total para la empresa</span><strong>{{ eur(nomina.costeEmpresa) }}</strong></div>
                </div>
            </div>

            <!-- COMPRAVENTA -->
            <div v-else class="calc-grid">
                <div class="calc-card">
                    <h2>La operación</h2>
                    <div class="calc-field">
                        <label>Activo vendido</label>
                        <select v-model="activo"><option value="acciones">Acciones / fondos</option><option value="vivienda">Vivienda / inmueble</option></select>
                    </div>
                    <div class="calc-row2">
                        <div class="calc-field"><label>Valor de compra (€)</label><input type="number" min="0" v-model.number="compra"></div>
                        <div class="calc-field"><label>Gastos de compra (€)</label><input type="number" min="0" v-model.number="gastosCompra"></div>
                    </div>
                    <div class="calc-row2">
                        <div class="calc-field"><label>Valor de venta (€)</label><input type="number" min="0" v-model.number="venta"></div>
                        <div class="calc-field"><label>Gastos de venta (€)</label><input type="number" min="0" v-model.number="gastosVenta"></div>
                    </div>
                    <template v-if="activo === 'vivienda'">
                        <div class="calc-row2">
                            <div class="calc-field"><label>Mejoras y reformas (€)</label><input type="number" min="0" v-model.number="mejoras"></div>
                            <div class="calc-field"><label>Plusvalía municipal pagada (€)</label><input type="number" min="0" v-model.number="plusvaliaMunicipal"></div>
                        </div>
                        <label class="calc-check"><input type="checkbox" v-model="viviendaHabitual"> Es mi vivienda habitual</label>
                        <template v-if="viviendaHabitual">
                            <label class="calc-check"><input type="checkbox" v-model="mayor65Venta"> Tengo más de 65 años</label>
                            <div v-if="!mayor65Venta" class="calc-field">
                                <label>Importe reinvertido en nueva vivienda habitual (€)</label>
                                <input type="number" min="0" v-model.number="reinversion">
                            </div>
                        </template>
                    </template>
                    <div class="calc-field">
                        <label>Otras rentas del ahorro del año (dividendos, intereses) (€)</label>
                        <input type="number" min="0" v-model.number="otrasRentas">
                    </div>
                </div>

                <div class="calc-card">
                    <h2>Resultado</h2>
                    <div class="calc-result__big">{{ eur(operacion.impuesto) }}</div>
                    <div class="calc-result__sub">IRPF estimado de la operación · tipo efectivo {{ pct(operacion.tipoEfectivo) }}</div>
                    <div class="calc-line"><span>Valor de adquisición</span><strong>{{ eur(operacion.adquisicion) }}</strong></div>
                    <div class="calc-line"><span>Valor de transmisión</span><strong>{{ eur(operacion.transmision) }}</strong></div>
                    <div class="calc-line" :class="operacion.ganancia >= 0 ? 'calc-line--pos' : 'calc-line--neg'"><span>{{ operacion.ganancia >= 0 ? 'Ganancia patrimonial' : 'Pérdida patrimonial' }}</span><strong>{{ eur(operacion.ganancia) }}</strong></div>
                    <div v-if="operacion.exenta > 0" class="calc-line"><span>Ganancia exenta</span><strong>{{ eur(operacion.exenta) }}</strong></div>
                    <div class="calc-line"><span>Ganancia sujeta a tributación</span><strong>{{ eur(operacion.sujeta) }}</strong></div>
                    <div class="calc-line calc-line--total"><span>Beneficio neto tras impuestos</span><strong>{{ eur2(operacion.beneficioNeto) }}</strong></div>
                    <p v-if="operacion.motivoExencion" class="calc-verdict" style="margin-top:14px;">{{ operacion.motivoExencion }}</p>
                    <p v-if="operacion.ganancia < 0" class="calc-verdict" style="margin-top:14px;">Una pérdida puede compensarse con ganancias patrimoniales del mismo ejercicio y de los cuatro siguientes.</p>
                </div>
            </div>

            <p class="calc-note">
                Estimación orientativa del ejercicio 2026: escala general combinada (estatal + autonómica supletoria) y escala del ahorro del 19 % al 28 %. La retención real de tu nómina y tu cuota autonómica pueden variar. No incluye deducciones autonómicas, coeficientes de abatimiento (inmuebles adquiridos antes de 1994) ni la regla antiaplicación de 2 meses en acciones.
                ¿Quieres un cálculo exacto? <Link href="/reserva">Reserva una cita con nuestros asesores</Link>.
            </p>
        </section>
    </PublicLayout>
</template>
