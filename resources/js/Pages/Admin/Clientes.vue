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

function abrirModal() { form.reset(); modalAbierto.value = true }
function cerrarModal() { modalAbierto.value = false; form.reset() }
function guardarCliente() {
    form.post(route('admin.clientes.store'), { onSuccess: () => cerrarModal() })
}
function confirmarEliminar(user) { clienteAEliminar.value = user }
function cancelarEliminar() { clienteAEliminar.value = null }
function eliminar() {
    router.delete(route('admin.clientes.destroy', clienteAEliminar.value.id), {
        onSuccess: () => { clienteAEliminar.value = null },
        onFinish:  () => { clienteAEliminar.value = null }
    })
}

const flashOk      = computed(() => page.props.flash?.status === 'cliente-creado')
const flashDeleted = computed(() => page.props.flash?.status === 'cliente-eliminado')
</script>

<template>
    <AdminLayout>
        <template #header>Clientes</template>

        <div class="dash-welcome">
            <h1 class="dash-welcome__title">Clientes</h1>
            <button @click="abrirModal" class="dash-btn-primary">+ Añadir cliente</button>
        </div>

        <div v-if="flashOk" class="flash-ok" style="margin-bottom:16px;">Cliente creado correctamente</div>
        <div v-if="flashDeleted" class="flash-error" style="margin-bottom:16px;">Cliente eliminado correctamente</div>

        <div class="dash-panel">
            <div class="clientes-panel-header">
                <h3 class="dash-panel__title">Listado de clientes ({{ users.length }})</h3>
                <input v-model="buscador" type="text" placeholder="Buscar por nombre o email..." class="dash-search clientes-search" />
            </div>

            <div v-if="users.length === 0" style="padding:56px 20px;text-align:center;">
                <p style="font-size:13px;color:var(--text-muted);">No hay clientes registrados todavía</p>
                <button @click="abrirModal" class="dash-btn-primary" style="margin-top:16px;font-size:11px;">Añadir primer cliente</button>
            </div>

            <template v-else>
                <!-- Vista escritorio: tabla -->
                <table class="docs-table clientes-table-desktop">
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
                                    <Link :href="route('admin.clientes.show', user.id)" class="doc-btn-download">Ver perfil</Link>
                                    <button @click="confirmarEliminar(user)" class="btn-eliminar">Eliminar</button>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>

                <!-- Vista móvil: tarjetas -->
                <div class="clientes-cards-mobile">
                    <div v-for="user in users.filter(u =>
                            u.name.toLowerCase().includes(buscador.toLowerCase()) ||
                            u.email.toLowerCase().includes(buscador.toLowerCase())
                        )" :key="user.id" class="cliente-card">
                        <div class="cliente-card__top">
                            <div class="topbar-avatar" style="width:36px;height:36px;font-size:14px;flex-shrink:0;">
                                <img v-if="user.avatar" :src="`/storage/${user.avatar}`" :alt="user.name" />
                                <span v-else>{{ user.name?.charAt(0) }}</span>
                            </div>
                            <div class="cliente-card__info">
                                <span class="cliente-card__name">{{ user.name }}</span>
                                <span class="cliente-card__email">{{ user.email }}</span>
                            </div>
                        </div>
                        <div v-if="user.phone" class="cliente-card__meta">
                                <svg width="13" height="13" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M2.25 6.75c0 8.284 6.716 15 15 15h2.25a2.25 2.25 0 002.25-2.25v-1.372c0-.516-.351-.966-.852-1.091l-4.423-1.106c-.44-.11-.902.055-1.173.417l-.97 1.293c-.282.376-.769.542-1.21.38a12.035 12.035 0 01-7.143-7.143c-.162-.441.004-.928.38-1.21l1.293-.97c.363-.271.527-.734.417-1.173L6.963 3.102a1.125 1.125 0 00-1.091-.852H4.5A2.25 2.25 0 002.25 4.5v2.25z"/></svg>
                                {{ user.phone }}
                            </div>
                        <div class="cliente-card__actions">
                            <Link :href="route('admin.clientes.show', user.id)" class="doc-btn-download">Ver perfil</Link>
                            <button @click="confirmarEliminar(user)" class="btn-eliminar">Eliminar</button>
                        </div>
                    </div>
                </div>
            </template>
        </div>

        <Teleport to="body">
            <div v-if="modalAbierto" class="modal-backdrop" @click.self="cerrarModal">
                <div class="modal">
                    <div class="modal__header">
                        <h2 class="modal__title">Nuevo Cliente</h2>
                        <button @click="cerrarModal" class="modal__close">×</button>
                    </div>
                    <form @submit.prevent="guardarCliente" class="modal__body">
                        <div style="display:flex; flex-direction:column; gap:16px; margin-bottom:24px;">
                            <div>
                                <label class="modal-label">Nombre completo *</label>
                                <input v-model="form.name" type="text" required class="modal-input" placeholder="Ej. Juan Pérez" />
                                <div v-if="form.errors.name" class="modal-error">{{ form.errors.name }}</div>
                            </div>
                            <div>
                                <label class="modal-label">Email *</label>
                                <input v-model="form.email" type="email" required class="modal-input" placeholder="correo@ejemplo.com" />
                                <div v-if="form.errors.email" class="modal-error">{{ form.errors.email }}</div>
                            </div>
                            <div>
                                <label class="modal-label">Teléfono</label>
                                <input v-model="form.phone" type="tel" class="modal-input" placeholder="600 000 000" />
                                <div v-if="form.errors.phone" class="modal-error">{{ form.errors.phone }}</div>
                            </div>
                            <div class="modal-pwd-grid">
                                <div>
                                    <label class="modal-label">Contraseña *</label>
                                    <input v-model="form.password" type="password" required class="modal-input" placeholder="••••••••" />
                                    <div v-if="form.errors.password" class="modal-error">{{ form.errors.password }}</div>
                                </div>
                                <div>
                                    <label class="modal-label">Confirmar Contraseña *</label>
                                    <input v-model="form.password_confirmation" type="password" required class="modal-input" placeholder="••••••••" />
                                </div>
                            </div>
                        </div>
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