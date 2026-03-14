<script setup>
import AdminLayout from '@/Layouts/AdminLayout.vue'
import { useForm, usePage } from '@inertiajs/vue3'
import { ref, computed } from 'vue'

defineProps({
    users: { type: Array, default: () => [] }
})

const page = usePage()
const buscador = ref('')
const modalAbierto = ref(false)

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
    form.post(route('admin.users.store'), {
        onSuccess: () => cerrarModal(),
    })
}

const flashOk = computed(() => page.props.flash?.status === 'cliente-creado')
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

        <div class="dash-panel">
            <div class="dash-panel__header" style="display:flex;align-items:center;justify-content:space-between;">
                <h3 class="dash-panel__title">Listado de clientes ({{ users.length }})</h3>
                <input v-model="buscador" type="text" placeholder="Buscar..." class="dash-search" style="width:200px;" />
            </div>

            <div v-if="users.length === 0" style="padding:48px 20px;text-align:center;">
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
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="user in users.filter(u => u.name.toLowerCase().includes(buscador.toLowerCase()) || u.email.toLowerCase().includes(buscador.toLowerCase()))" :key="user.id">
                        <td>
                            <div style="display:flex;align-items:center;gap:10px;">
                                <div class="topbar-avatar" style="width:28px;height:28px;font-size:11px;flex-shrink:0;">
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
                    </tr>
                </tbody>
            </table>
        </div>

        <!-- MODAL -->
        <Teleport to="body">
            <div v-if="modalAbierto" class="modal-backdrop" @click.self="cerrarModal">
                <div class="modal">
                    <div class="modal__header">
                        <h2 class="modal__title">Nuevo Cliente</h2>
                        <button @click="cerrarModal" class="modal__close">
                            <svg width="18" height="18" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12"/>
                            </svg>
                        </button>
                    </div>

                    <form @submit.prevent="guardarCliente" class="modal__body appointment-form">
                        <div class="dash-cols" style="gap:14px;">
                            <div class="form-group">
                                <label class="form-label">Nombre completo *</label>
                                <input v-model="form.name" type="text" class="form-input"
                                    :class="{ 'form-input--error': form.errors.name }" placeholder="Juan García" />
                                <span v-if="form.errors.name" class="form-error">{{ form.errors.name }}</span>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Teléfono</label>
                                <input v-model="form.phone" type="tel" class="form-input" placeholder="600 000 000" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label">Email *</label>
                            <input v-model="form.email" type="email" class="form-input"
                                :class="{ 'form-input--error': form.errors.email }" placeholder="cliente@email.com" />
                            <span v-if="form.errors.email" class="form-error">{{ form.errors.email }}</span>
                        </div>

                        <div class="dash-cols" style="gap:14px;">
                            <div class="form-group">
                                <label class="form-label">Contraseña *</label>
                                <input v-model="form.password" type="password" class="form-input"
                                    :class="{ 'form-input--error': form.errors.password }" placeholder="Mínimo 8 caracteres" />
                                <span v-if="form.errors.password" class="form-error">{{ form.errors.password }}</span>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Confirmar contraseña *</label>
                                <input v-model="form.password_confirmation" type="password" class="form-input" placeholder="Repetir contraseña" />
                            </div>
                        </div>

                        <div class="modal__footer">
                            <button type="button" @click="cerrarModal" class="modal__btn-cancel">Cancelar</button>
                            <button type="submit" class="form-submit" style="width:auto;padding:10px 28px;" :disabled="form.processing">
                                {{ form.processing ? 'Guardando...' : 'Crear Cliente' }}
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </Teleport>

    </AdminLayout>
</template>