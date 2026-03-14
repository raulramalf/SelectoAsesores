<script setup>
import AdminLayout from '@/Layouts/AdminLayout.vue'
import { useForm, usePage, router } from '@inertiajs/vue3'
import { ref, computed } from 'vue'

defineProps({
    documentos: { type: Array, default: () => [] },
    clientes:   { type: Array, default: () => [] },
})

const page = usePage()
const filtro    = ref('todos')
const buscador  = ref('')
const modalOpen = ref(false)
const docAEliminar = ref(null)

const filtros = [
    { key: 'todos',       label: 'Todos' },
    { key: 'declaracion', label: 'Declaración' },
    { key: 'contrato',    label: 'Contrato' },
    { key: 'factura',     label: 'Factura' },
    { key: 'informe',     label: 'Informe' },
    { key: 'otro',        label: 'Otro' },
]

const tipoColor = {
    declaracion: '#D4AF37',
    contrato:    '#81c784',
    factura:     '#64b5f6',
    informe:     '#ba68c8',
    otro:        '#a0aabf',
}

const form = useForm({
    user_id:     '',
    name:        '',
    description: '',
    type:        'otro',
    file:        null,
})

const fileName  = ref('')
const fileError = ref('')

function onFileChange(e) {
    const file = e.target.files[0]
    if (!file) return

    const allowed = ['application/pdf', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
        'text/plain', 'image/jpeg', 'image/png']
    const allowedExt = ['.pdf', '.docx', '.txt', '.jpg', '.jpeg', '.png']
    const ext = '.' + file.name.split('.').pop().toLowerCase()

    if (!allowed.includes(file.type) && !allowedExt.includes(ext)) {
        fileError.value = 'Solo se permiten archivos PDF, DOCX, TXT, JPG o PNG'
        fileName.value = ''
        form.file = null
        e.target.value = ''
        return
    }

    if (file.size > 10 * 1024 * 1024) {
        fileError.value = 'El archivo no puede superar 10MB'
        return
    }

    fileError.value = ''
    fileName.value  = file.name
    form.file       = file

    if (!form.name) form.name = file.name.replace(/\.[^/.]+$/, '')
}

function abrirModal() {
    form.reset()
    fileName.value  = ''
    fileError.value = ''
    modalOpen.value = true
}

function cerrarModal() {
    modalOpen.value = false
    form.reset()
    fileName.value  = ''
    fileError.value = ''
}

function subirDocumento() {
    if (!form.file) { fileError.value = 'Selecciona un archivo'; return }
    form.post(route('admin.documentos.store'), {
        forceFormData: true,
        onSuccess: () => cerrarModal(),
    })
}

function confirmarEliminar(doc) { docAEliminar.value = doc }
function cancelarEliminar()     { docAEliminar.value = null }

function eliminar() {
    router.delete(`/admin/documentos/${docAEliminar.value.id}`, {
        onSuccess: () => { docAEliminar.value = null }
    })
}

function formatBytes(bytes) {
    if (!bytes) return '—'
    if (bytes < 1024) return bytes + ' B'
    if (bytes < 1048576) return (bytes / 1024).toFixed(1) + ' KB'
    return (bytes / 1048576).toFixed(1) + ' MB'
}

const flashOk  = computed(() => page.props.flash?.status === 'documento-subido')
const flashDel = computed(() => page.props.flash?.status === 'documento-eliminado')
</script>

<template>
    <AdminLayout>
        <template #header>Documentos</template>

        <div class="dash-welcome">
            <h1 class="dash-welcome__title">Documentos</h1>
            <button @click="abrirModal" class="dash-btn-primary">+ Adjuntar documento</button>
        </div>

        <div v-if="flashOk"  class="flash-ok"    style="margin-bottom:16px;">Documento subido correctamente</div>
        <div v-if="flashDel" class="flash-error"  style="margin-bottom:16px;">Documento eliminado correctamente</div>

        <!-- FILTROS -->
        <div class="dash-panel" style="margin-bottom:16px;">
            <div style="padding:12px 18px;display:flex;align-items:center;justify-content:space-between;gap:12px;flex-wrap:wrap;">
                <div style="display:flex;gap:6px;flex-wrap:wrap;">
                    <button v-for="f in filtros" :key="f.key"
                        @click="filtro = f.key"
                        :class="['filtro-tab', filtro === f.key && 'filtro-tab--active']">
                        {{ f.label }}
                    </button>
                </div>
                <input v-model="buscador" type="text" placeholder="Buscar..." class="dash-search" style="width:200px;" />
            </div>
        </div>

        <!-- TABLA -->
        <div class="dash-panel">
            <div class="dash-panel__header">
                <h3 class="dash-panel__title">Archivos de clientes</h3>
            </div>

            <div v-if="documentos.length === 0" style="padding:48px 20px;text-align:center;">
                <p style="font-size:13px;color:var(--text-muted);">No hay documentos subidos todavía</p>
            </div>

            <table v-else class="docs-table">
                <thead>
                    <tr>
                        <th>Tipo</th>
                        <th>Nombre</th>
                        <th>Descripción</th>
                        <th>Cliente</th>
                        <th>Tamaño</th>
                        <th>Fecha</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="doc in documentos.filter(d =>
                            (filtro === 'todos' || d.tipo === filtro) &&
                            (d.nombre.toLowerCase().includes(buscador.toLowerCase()) ||
                             d.cliente?.toLowerCase().includes(buscador.toLowerCase()))
                        )" :key="doc.id">
                        <td>
                            <span class="doc-tipo" :style="`color:${tipoColor[doc.tipo] || '#a0aabf'}`">
                                {{ doc.tipo }}
                            </span>
                        </td>
                        <td style="color:#fff;font-size:13px;max-width:180px;">
                            <p style="white-space:nowrap;overflow:hidden;text-overflow:ellipsis;">{{ doc.nombre }}</p>
                        </td>
                        <td style="color:var(--text-muted);font-size:12px;max-width:160px;">
                            <p style="white-space:nowrap;overflow:hidden;text-overflow:ellipsis;">{{ doc.description || '—' }}</p>
                        </td>
                        <td style="color:var(--text-muted);font-size:12px;">{{ doc.cliente || '—' }}</td>
                        <td style="color:var(--text-muted);font-size:12px;">{{ formatBytes(doc.size) }}</td>
                        <td style="color:var(--text-muted);font-size:12px;">{{ doc.fecha }}</td>
                        <td>
                            <div style="display:flex;gap:12px;align-items:center;">
                                <a :href="`/storage/${doc.url}`" target="_blank" class="doc-btn-download">Ver</a>
                                <button @click="confirmarEliminar(doc)" class="btn-eliminar">Eliminar</button>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

        <!-- MODAL SUBIR DOCUMENTO -->
        <Teleport to="body">
            <div v-if="modalOpen" class="modal-backdrop" @click.self="cerrarModal">
                <div class="modal">
                    <div class="modal__header">
                        <div>
                            <h2 class="modal__title">Adjuntar Documento</h2>
                            <p style="font-size:12px;color:var(--text-muted);margin-top:3px;">PDF, DOCX, TXT, JPG o PNG — máx. 10MB</p>
                        </div>
                        <button @click="cerrarModal" class="modal__close">
                            <svg width="18" height="18" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12"/>
                            </svg>
                        </button>
                    </div>

                    <div class="modal__body">

                        <!-- ZONA SUBIDA -->
                        <label for="file-upload" class="upload-zone" :class="fileName && 'upload-zone--active'">
                            <svg width="28" height="28" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"
                                :style="fileName ? 'color:var(--gold)' : 'color:var(--text-dim)'">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M3 16.5v2.25A2.25 2.25 0 005.25 21h13.5A2.25 2.25 0 0021 18.75V16.5m-13.5-9L12 3m0 0l4.5 4.5M12 3v13.5"/>
                            </svg>
                            <p style="font-size:13px;font-weight:500;" :style="fileName ? 'color:#fff' : 'color:var(--text-muted)'">
                                {{ fileName || 'Haz click para seleccionar archivo' }}
                            </p>
                            <p style="font-size:11px;color:var(--text-dim);">PDF · DOCX · TXT · JPG · PNG</p>
                            <input id="file-upload" type="file" style="display:none"
                                accept=".pdf,.docx,.txt,.jpg,.jpeg,.png"
                                @change="onFileChange" />
                        </label>
                        <p v-if="fileError" class="form-error" style="margin-top:6px;">{{ fileError }}</p>

                        <div style="display:flex;flex-direction:column;gap:14px;margin-top:20px;">

                            <!-- CLIENTE -->
                            <div class="form-group">
                                <label class="form-label">Asignar a cliente *</label>
                                <select v-model="form.user_id" class="form-input modal-input"
                                    :class="{ 'form-input--error': form.errors.user_id }">
                                    <option value="" disabled>Selecciona un cliente</option>
                                    <option v-for="c in clientes" :key="c.id" :value="c.id">{{ c.name }}</option>
                                </select>
                                <span v-if="form.errors.user_id" class="form-error">{{ form.errors.user_id }}</span>
                            </div>

                            <!-- TÍTULO -->
                            <div class="form-group">
                                <label class="form-label">Título *</label>
                                <input v-model="form.name" type="text" class="form-input modal-input"
                                    :class="{ 'form-input--error': form.errors.name }"
                                    placeholder="Ej: Declaración Renta 2024" />
                                <span v-if="form.errors.name" class="form-error">{{ form.errors.name }}</span>
                            </div>

                            <!-- DESCRIPCIÓN + CATEGORÍA -->
                            <div class="modal-form-grid">
                                <div class="form-group">
                                    <label class="form-label">Categoría *</label>
                                    <select v-model="form.type" class="form-input modal-input"
                                        :class="{ 'form-input--error': form.errors.type }">
                                        <option value="declaracion">Declaración</option>
                                        <option value="contrato">Contrato</option>
                                        <option value="factura">Factura</option>
                                        <option value="informe">Informe</option>
                                        <option value="otro">Otro</option>
                                    </select>
                                    <span v-if="form.errors.type" class="form-error">{{ form.errors.type }}</span>
                                </div>

                                <div class="form-group">
                                    <label class="form-label">Descripción</label>
                                    <input v-model="form.description" type="text" class="form-input modal-input"
                                        placeholder="Breve descripción opcional" />
                                </div>
                            </div>

                        </div>

                        <div class="modal__footer">
                            <button type="button" @click="cerrarModal" class="modal__btn-cancel">Cancelar</button>
                            <button @click="subirDocumento" class="dash-btn-primary" :disabled="form.processing">
                                {{ form.processing ? 'Subiendo...' : 'Adjuntar documento' }}
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </Teleport>

        <!-- MODAL CONFIRMAR ELIMINAR -->
        <Teleport to="body">
            <div v-if="docAEliminar" class="modal-backdrop" @click.self="cancelarEliminar">
                <div class="modal modal--confirm">
                    <div class="modal__icon">
                        <svg width="26" height="26" fill="none" stroke="#e57373" stroke-width="1.5" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v3.75m-9.303 3.376c-.866 1.5.217 3.374 1.948 3.374h14.71c1.73 0 2.813-1.874 1.948-3.374L13.949 3.378c-.866-1.5-3.032-1.5-3.898 0L2.697 16.126zM12 15.75h.007v.008H12v-.008z"/>
                        </svg>
                    </div>
                    <h3 class="modal__title">¿Eliminar documento?</h3>
                    <p class="modal__text">
                        Estás a punto de eliminar
                        <strong style="color:#fff;">{{ docAEliminar.nombre }}</strong>.
                        Esta acción no se puede deshacer.
                    </p>
                    <div class="modal__actions">
                        <button @click="cancelarEliminar" class="modal__btn-cancel">Cancelar</button>
                        <button @click="eliminar" class="modal__btn-confirm">Sí, eliminar</button>
                    </div>
                </div>
            </div>
        </Teleport>

    </AdminLayout>
</template>