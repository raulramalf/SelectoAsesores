<script setup>
import AdminLayout from '@/Layouts/AdminLayout.vue'
import { useForm, usePage, Link, router } from '@inertiajs/vue3'
import { ref, computed } from 'vue'

defineProps({
    users: { type: Array, default: () => [] }
})

const page = usePage()
const buscador = ref('')
const modalAbierto = ref(false)
const clienteAEliminar = ref(null)

const form = useForm({
    name:                  '',
    email:                 '',
    phone:                 '',
    password:              '',
    password_confirmation: '',
})

function abrirModal() {
    form.reset()
    modalAbierto.value = true
}

function cerrarModal() {
    modalAbierto.value = false
    form.reset()
}

function guardarCliente() {
    form.post(route('admin.clientes.store'), {
        onSuccess: () => cerrarModal(),
    })
}

function confirmarEliminar(user) {
    clienteAEliminar.value = user
}

function cancelarEliminar() {
    clienteAEliminar.value = null
}

function eliminar() {
    router.delete(`/admin/clientes/${clienteAEliminar.value.id}`, {
        onSuccess: () => { clienteAEliminar.value = null }
    })
}

const flashOk = computed(() => page.props.flash?.status === 'cliente-creado')
const flashDeleted = computed(() => page.props.flash?.status === 'cliente-eliminado')
</script>

<template>
    <AdminLayout>
        <template #header>Clientes</template>

        <div class="dash-welcome">
            <h1 class="dash-welcome__title">Clientes</h1>
            <button @click="abrirModal" class="dash-btn-primary">+ Añadir cliente</button>
        </div>

        <div v-if="flashOk" class="flash-ok" style="margin-bottom:16px;">
            Cliente creado correctamente
        </div>
        <div v-if="flashDeleted" class="flash-error" style="margin-bottom:16px;">
            Cliente eliminado correctamente
        </div>

        <div class="dash-panel">
            <div class="dash-panel__header" style="display:flex;align-items:center;justify-content:space-between;">
                <h3 class="dash-panel__title">Listado de clientes ({{ users.length }})</h3>
                <input v-model="buscador" type="text" placeholder="Buscar por nombre o email..." class="dash-search" style="width:240px;" />
            </div>

            <div v-if="users.length === 0" style="padding:56px 20px;text-align:center;">
                <p style="font-size:13px;color:var(--text-muted);">No hay clientes registrados todavía</p>
                <button @click="abrirModal" class="dash-btn-primary" style="margin-top:16px;font-size:11px;">Añadir primer cliente</button>
            </div>

            <table v-else class="docs-table">
                <thead>
                    <tr>
                        <th>Nombre</th>
                        <th>Email</th>
                        <th>Teléfono</th>
                        <th>Registro</th>
                        <th>Estado</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="user in users.filter(u =>
                            u.name.toLowerCase().includes(buscador.toLowerCase()) ||
                            u.email.toLowerCase().includes(buscador.toLowerCase())
                        )" :key="user.id">
                        <td>
                            <div style="display:flex;align-items:center;gap:10px;">
                                <div class="topbar-avatar" style="width:30px;height:30px;font-size:12px;flex-shrink:0;">
                                    <img v-if="user.avatar" :src="`/storage/${user.avatar}`" :alt="user.name" />
                                    <span v-else>{{ user.name?.charAt(0) }}</span>
                                </div>
                                <span style="font-size:13px;color:#fff;">{{ user.name }}</span>
                            </div>
                        </td>
                        <td style="color:var(--text-muted);font-size:12px;">{{ user.email }}</td>
                        <td style="color:var(--text-muted);font-size:12px;">{{ user.phone || '—' }}</td>
                        <td style="color:var(--text-muted);font-size:12px;">{{ user.created_at }}</td>
                        <td>
                            <span style="font-size:10px;padding:3px 10px;border-radius:100px;background:rgba(129,199,132,.15);color:#81c784;font-weight:500;">
                                Activo
                            </span>
                        </td>
                        <td>
                            <div style="display:flex;align-items:center;gap:14px;">
                                <Link :href="`/admin/clientes/${user.id}`" class="doc-btn-download">Ver perfil →</Link>
                                <button @click="confirmarEliminar(user)" class="btn-eliminar">Eliminar</button>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

        <!-- MODAL AÑADIR CLIENTE -->
        <Teleport to="body">
            <div v-if="modalAbierto" class="modal-backdrop" @click.self="cerrarModal">
                <div class="modal">
                    <div class="modal__header">
                        <div>
                            <h2 class="modal__title">Nuevo Cliente</h2>
                            <p style="font-size:12px;color:var(--text-muted);margin-top:3px;">Rellena los datos para crear un acceso de cliente</p>
                        </div>
                        <button @click="cerrarModal" class="modal__close">
                            <svg width="18" height="18" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12"/>
                            </svg>
                        </button>
                    </div>

                    <form @submit.prevent="guardarCliente" class="modal__body">
                        <div class="modal-form-grid">
                            <div class="form-group">
                                <label class="form-label">Nombre completo *</label>
                                <input v-model="form.name" type="text" class="form-input modal-input"
                                    :class="{ 'form-input--error': form.errors.name }"
                                    placeholder="Ej: Juan Pérez" autofocus />
                                <span v-if="form.errors.name" class="form-error">{{ form.errors.name }}</span>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Teléfono</label>
                                <input v-model="form.phone" type="tel" class="form-input modal-input"
                                    placeholder="Ej: +34 600 000 000" />
                            </div>
                        </div>

                        <div class="form-group" style="margin-top:16px;">
                            <label class="form-label">Correo electrónico *</label>
                            <input v-model="form.email" type="email" class="form-input modal-input"
                                :class="{ 'form-input--error': form.errors.email }"
                                placeholder="ejemplo@correo.com" />
                            <span v-if="form.errors.email" class="form-error">{{ form.errors.email }}</span>
                        </div>

                        <div class="modal-divider"><span>Acceso al portal</span></div>

                        <div class="modal-form-grid">
                            <div class="form-group">
                                <label class="form-label">Contraseña *</label>
                                <input v-model="form.password" type="password" class="form-input modal-input"
                                    :class="{ 'form-input--error': form.errors.password }"
                                    placeholder="Mínimo 8 caracteres" />
                                <span v-if="form.errors.password" class="form-error">{{ form.errors.password }}</span>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Confirmar contraseña *</label>
                                <input v-model="form.password_confirmation" type="password" class="form-input modal-input"
                                    placeholder="Repite la contraseña" />
                            </div>
                        </div>

                        <div class="modal__footer">
                            <button type="button" @click="cerrarModal" class="modal__btn-cancel">Cancelar</button>
                            <button type="submit" class="dash-btn-primary" :disabled="form.processing">
                                {{ form.processing ? 'Guardando...' : 'Crear Cliente' }}
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </Teleport>

        <!-- MODAL CONFIRMAR ELIMINAR -->
        <Teleport to="body">
            <div v-if="clienteAEliminar" class="modal-backdrop" @click.self="cancelarEliminar">
                <div class="modal modal--confirm">
                    <div class="modal__icon">
                        <svg width="26" height="26" fill="none" stroke="#e57373" stroke-width="1.5" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v3.75m-9.303 3.376c-.866 1.5.217 3.374 1.948 3.374h14.71c1.73 0 2.813-1.874 1.948-3.374L13.949 3.378c-.866-1.5-3.032-1.5-3.898 0L2.697 16.126zM12 15.75h.007v.008H12v-.008z"/>
                        </svg>
                    </div>
                    <h3 class="modal__title">¿Eliminar cliente?</h3>
                    <p class="modal__text">
                        Estás a punto de eliminar a
                        <strong style="color:#fff;">{{ clienteAEliminar.name }}</strong>.
                        Esta acción no se puede deshacer y se perderán todos sus datos.
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