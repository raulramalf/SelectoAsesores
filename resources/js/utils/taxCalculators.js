// Lógica fiscal de las calculadoras públicas (estimaciones orientativas, ejercicio 2026).
// Revisar estas constantes cada año: la escala autonómica varía por comunidad y la
// normativa de cotización se actualiza con la Orden anual de cotización.

// Escala general IRPF: estatal + autonómica supletoria (tipos combinados).
export const ESCALA_GENERAL = [
    { hasta: 12450, tipo: 0.19 },
    { hasta: 20200, tipo: 0.24 },
    { hasta: 35200, tipo: 0.30 },
    { hasta: 60000, tipo: 0.37 },
    { hasta: 300000, tipo: 0.45 },
    { hasta: Infinity, tipo: 0.47 },
]

// Escala del ahorro (ganancias patrimoniales, dividendos, intereses).
export const ESCALA_AHORRO = [
    { hasta: 6000, tipo: 0.19 },
    { hasta: 50000, tipo: 0.21 },
    { hasta: 200000, tipo: 0.23 },
    { hasta: 300000, tipo: 0.27 },
    { hasta: Infinity, tipo: 0.28 },
]

// Seguridad Social trabajador por cuenta ajena (2026).
export const SS_TRABAJADOR = 0.0650        // 4,70 + 1,55 + 0,10 + MEI 0,15
export const SS_EMPRESA = 0.3215           // contingencias, desempleo, FOGASA, FP, MEI 0,75 y AT/EP medio
export const BASE_MAXIMA_ANUAL = 5101.2 * 12
export const GASTOS_TRABAJO = 2000
export const MINIMO_PERSONAL = 5550

// Autónomos 2026: bases mínimas por tramo de rendimientos netos mensuales y tipo total.
export const TIPO_RETA = 0.315
export const TRAMOS_RETA = [
    { hasta: 670, base: 653.59 },
    { hasta: 900, base: 718.95 },
    { hasta: 1166.7, base: 849.67 },
    { hasta: 1300, base: 949.01 },
    { hasta: 1500, base: 960.78 },
    { hasta: 1700, base: 960.78 },
    { hasta: 1850, base: 1013.07 },
    { hasta: 2030, base: 1029.41 },
    { hasta: 2330, base: 1045.75 },
    { hasta: 2760, base: 1078.43 },
    { hasta: 3190, base: 1143.79 },
    { hasta: 3620, base: 1209.15 },
    { hasta: 4050, base: 1274.51 },
    { hasta: 6000, base: 1372.55 },
    { hasta: Infinity, base: 1732.03 },
]

export const round2 = (n) => Math.round((Number(n) + Number.EPSILON) * 100) / 100
const num = (v) => (Number.isFinite(Number(v)) ? Math.max(0, Number(v)) : 0)

export function aplicarEscala(base, escala) {
    let resto = num(base)
    let anterior = 0
    let cuota = 0
    for (const { hasta, tipo } of escala) {
        if (resto <= 0) break
        const tramo = Math.min(resto, hasta - anterior)
        cuota += tramo * tipo
        resto -= tramo
        anterior = hasta
    }
    return cuota
}

export function tipoMarginal(base, escala) {
    const b = num(base)
    return (escala.find((t) => b <= t.hasta) ?? escala[escala.length - 1]).tipo
}

// Reducción por obtención de rendimientos del trabajo (art. 20 LIRPF).
export function reduccionTrabajo(rendimientoNeto) {
    if (rendimientoNeto <= 14852) return 7302
    if (rendimientoNeto <= 17673.52) return Math.max(0, 7302 - 1.75 * (rendimientoNeto - 14852))
    if (rendimientoNeto <= 19747.5) return Math.max(0, 2364.34 - 1.14 * (rendimientoNeto - 17673.52))
    return 0
}

export function minimoFamiliar({ hijos = 0, mayor65 = false } = {}) {
    const porHijo = [2400, 2700, 4000, 4500]
    let total = MINIMO_PERSONAL
    for (let i = 0; i < Math.min(num(hijos), 20); i++) total += porHijo[Math.min(i, 3)]
    if (mayor65) total += 1150
    return total
}

// IRPF de un rendimiento del trabajo dependiente (o asimilado) dada la cuota de SS pagada.
export function irpfTrabajo({ bruto, ssPagada, hijos = 0, mayor65 = false }) {
    const b = num(bruto)
    const rendimientoPrevio = Math.max(0, b - ssPagada - GASTOS_TRABAJO)
    const rendimientoNeto = Math.max(0, rendimientoPrevio - reduccionTrabajo(rendimientoPrevio))
    const minimo = minimoFamiliar({ hijos, mayor65 })
    const cuota = Math.max(0, aplicarEscala(rendimientoNeto, ESCALA_GENERAL) - aplicarEscala(Math.min(minimo, rendimientoNeto), ESCALA_GENERAL))
    return { baseLiquidable: rendimientoNeto, cuota }
}

export function nominaDesdeBruto({ bruto, pagas = 14, hijos = 0, mayor65 = false }) {
    const b = num(bruto)
    const ss = Math.min(b, BASE_MAXIMA_ANUAL) * SS_TRABAJADOR
    const { baseLiquidable, cuota } = irpfTrabajo({ bruto: b, ssPagada: ss, hijos, mayor65 })
    const neto = b - ss - cuota
    return {
        bruto: b,
        ss,
        irpf: cuota,
        baseLiquidable,
        neto,
        netoMensual: neto / pagas,
        brutoMensual: b / pagas,
        tipoEfectivo: b > 0 ? cuota / b : 0,
        tipoMarginal: tipoMarginal(baseLiquidable, ESCALA_GENERAL),
        presionTotal: b > 0 ? (b - neto) / b : 0,
        costeEmpresa: b + Math.min(b, BASE_MAXIMA_ANUAL) * SS_EMPRESA,
    }
}

// Inversa: bruto necesario para un neto anual (bisección; el neto es monótono creciente).
export function nominaDesdeNeto({ neto, pagas = 14, hijos = 0, mayor65 = false }) {
    const objetivo = num(neto)
    let lo = objetivo
    let hi = Math.max(objetivo * 3, 10000)
    for (let i = 0; i < 80; i++) {
        const mid = (lo + hi) / 2
        if (nominaDesdeBruto({ bruto: mid, pagas, hijos, mayor65 }).neto < objetivo) lo = mid
        else hi = mid
    }
    return nominaDesdeBruto({ bruto: hi, pagas, hijos, mayor65 })
}

// Ganancia patrimonial por compraventa de acciones o vivienda.
export function compraventa({
    tipo = 'acciones',
    valorCompra, gastosCompra = 0, mejoras = 0,
    valorVenta, gastosVenta = 0, plusvaliaMunicipal = 0,
    otrasRentasAhorro = 0,
    viviendaHabitual = false, reinversion = 0, mayor65 = false,
}) {
    const adquisicion = num(valorCompra) + num(gastosCompra) + (tipo === 'vivienda' ? num(mejoras) : 0)
    const transmision = num(valorVenta) - num(gastosVenta) - (tipo === 'vivienda' ? num(plusvaliaMunicipal) : 0)
    const ganancia = transmision - adquisicion

    let exenta = 0
    let motivoExencion = ''
    if (tipo === 'vivienda' && ganancia > 0 && viviendaHabitual) {
        if (mayor65) {
            exenta = ganancia
            motivoExencion = 'Exención total: transmisión de la vivienda habitual por mayor de 65 años.'
        } else if (num(reinversion) > 0) {
            const proporcion = Math.min(1, num(reinversion) / Math.max(1, num(valorVenta) - num(gastosVenta)))
            exenta = ganancia * proporcion
            motivoExencion = `Exención por reinversión en vivienda habitual (${Math.round(proporcion * 100)} % de la ganancia).`
        }
    }

    const sujeta = Math.max(0, ganancia - exenta)
    const otras = num(otrasRentasAhorro)
    const impuesto = Math.max(0, aplicarEscala(otras + sujeta, ESCALA_AHORRO) - aplicarEscala(otras, ESCALA_AHORRO))
    return {
        adquisicion, transmision, ganancia, exenta, sujeta, impuesto,
        netoOperacion: transmision - impuesto,
        beneficioNeto: ganancia - impuesto,
        tipoEfectivo: sujeta > 0 ? impuesto / sujeta : 0,
        motivoExencion,
    }
}

export function cuotaAutonomo(rendimientoNetoMensual) {
    const r = num(rendimientoNetoMensual)
    const tramo = TRAMOS_RETA.findIndex((t) => r <= t.hasta)
    const { base } = TRAMOS_RETA[tramo]
    return { tramo: tramo + 1, base, cuotaMensual: base * TIPO_RETA }
}

// Autónomo persona física (estimación directa simplificada).
export function escenarioAutonomo({ ingresos, gastos, hijos = 0, mayor65 = false }) {
    const ing = num(ingresos)
    const gas = num(gastos)
    // La cuota depende del rendimiento neto; iteramos porque la cuota es gasto deducible.
    let cuotaAnual = 0
    let rendimientoNeto = 0
    let info = cuotaAutonomo(0)
    for (let i = 0; i < 6; i++) {
        const previo = Math.max(0, ing - gas - cuotaAnual)
        rendimientoNeto = Math.max(0, previo - Math.min(previo * 0.07, 2000))
        info = cuotaAutonomo((ing - gas) / 12)
        cuotaAnual = info.cuotaMensual * 12
    }
    const minimo = minimoFamiliar({ hijos, mayor65 })
    const irpf = Math.max(0, aplicarEscala(rendimientoNeto, ESCALA_GENERAL) - aplicarEscala(Math.min(minimo, rendimientoNeto), ESCALA_GENERAL))
    const neto = ing - gas - cuotaAnual - irpf
    return { ingresos: ing, gastos: gas, tramo: info.tramo, cuotaMensual: info.cuotaMensual, cuotaAnual, rendimientoNeto, irpf, neto, impuestosYSS: cuotaAnual + irpf }
}

// Sociedad Limitada con administrador que cobra nómina y reparte dividendos.
export function escenarioSL({ ingresos, gastos, salarioAdmin, costeGestoria = 1500, tipoIS = 0.23, repartoDividendos = 1, hijos = 0, mayor65 = false }) {
    const ing = num(ingresos)
    const gas = num(gastos) + num(costeGestoria)
    const salario = Math.min(num(salarioAdmin), Math.max(0, ing - gas))
    // Administrador con control societario: cotiza en RETA según su rendimiento (salario).
    const reta = cuotaAutonomo(salario / 12)
    const ssAdmin = salario > 0 ? reta.cuotaMensual * 12 : 0
    const baseImponible = Math.max(0, ing - gas - salario)
    const is = baseImponible * tipoIS
    const beneficioNeto = baseImponible - is
    const dividendos = beneficioNeto * Math.min(1, Math.max(0, repartoDividendos))
    const irpfDividendos = aplicarEscala(dividendos, ESCALA_AHORRO)
    const irpfSalario = salario > 0 ? irpfTrabajo({ bruto: salario, ssPagada: ssAdmin, hijos, mayor65 }).cuota : 0
    const netoSalario = salario - ssAdmin - irpfSalario
    const netoDividendos = dividendos - irpfDividendos
    const reservas = beneficioNeto - dividendos
    return {
        ingresos: ing, gastos: gas, salario, ssAdmin, irpfSalario, netoSalario,
        baseImponible, is, beneficioNeto, dividendos, irpfDividendos, netoDividendos, reservas,
        cuotaMensual: ssAdmin / 12,
        neto: netoSalario + netoDividendos,
        netoConReservas: netoSalario + netoDividendos + reservas,
        impuestosYSS: ssAdmin + irpfSalario + is + irpfDividendos,
    }
}

export const eur = (n) => new Intl.NumberFormat('es-ES', { style: 'currency', currency: 'EUR', maximumFractionDigits: 0 }).format(n || 0)
export const eur2 = (n) => new Intl.NumberFormat('es-ES', { style: 'currency', currency: 'EUR' }).format(n || 0)
export const pct = (n) => `${(100 * (n || 0)).toLocaleString('es-ES', { maximumFractionDigits: 1 })} %`
