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
    // Generamos la URL de borrado con el ID dinámico del cliente
    router.delete(route('admin.clientes.destroy', clienteAEliminar.value.id), {
        onSuccess: () => { 
            clienteAEliminar.value = null 
        },
        onFinish: () => {
            clienteAEliminar.value = null
        }
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
                            <div style="display:flex;align-items:center;gap:14px;">
                                <Link :href="route('admin.clientes.show', user.id)" class="doc-btn-download">Ver perfil →</Link>
                                <button @click="confirmarEliminar(user)" class="btn-eliminar">Eliminar</button>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

        <Teleport to="body">
            <div v-if="modalAbierto" class="modal-backdrop" @click.self="cerrarModal">
                <div class="modal">
                    <div class="modal__header">
                        <h2 class="modal__title">Nuevo Cliente</h2>
                        <button @click="cerrarModal" class="modal__close">×</button>
                    </div>
                    <form @submit.prevent="guardarCliente" class="modal__body">
                        <div class="modal__footer">
                            <button type="button" @click="cerrarModal" class="modal__btn-cancel">Cancelar</button>
                            <button type="submit" class="dash-btn-primary" :disabled="form.processing">Crear Cliente</button>
                        </div>
                    </form>
                </div>
            </div>

            <div v-if="clienteAEliminar" class="modal-backdrop" @click.self="cancelarEliminar">
                <div class="modal modal--confirm">
                    <h3 class="modal__title">¿Eliminar cliente?</h3>
                    <p class="modal__text">Estás a punto de eliminar a <strong>{{ clienteAEliminar.name }}</strong>.</p>
                    <div class="modal__actions">
                        <button @click="cancelarEliminar" class="modal__btn-cancel">Cancelar</button>
                        <button @click="eliminar" class="modal__btn-confirm">Sí, eliminar</button>
                    </div>
                </div>
            </div>
        </Teleport>
    </AdminLayout>
</template>