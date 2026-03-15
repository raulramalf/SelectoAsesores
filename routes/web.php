<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\PublicController;
use App\Http\Controllers\AppointmentController;
use App\Http\Controllers\NewsController;
use App\Http\Controllers\ContactController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\Client\DashboardController as ClientDashboard;
use App\Http\Controllers\Admin\DashboardController as AdminDashboard;
use App\Http\Controllers\Admin\UserController;
use App\Http\Controllers\Admin\DocumentController as AdminDocumentController;
use App\Http\Controllers\Admin\AppointmentController as AdminAppointmentController;

// ─── RUTAS PÚBLICAS ───────────────────────────────────────────────────────────

Route::get('/',                [PublicController::class, 'home'])->name('home');
Route::get('/servicios',       [PublicController::class, 'servicios'])->name('servicios');
Route::get('/nosotros',        [PublicController::class, 'nosotros'])->name('nosotros');
Route::get('/contacto',        [PublicController::class, 'contacto'])->name('contacto');
Route::post('/contacto',       [ContactController::class, 'store'])->name('contacto.store');
Route::get('/reserva',         [AppointmentController::class, 'create'])->name('reserva');
Route::post('/reserva',        [AppointmentController::class, 'store'])->name('reserva.store');
Route::get('/noticias',        [NewsController::class, 'index'])->name('noticias');
Route::get('/noticias/{slug}', [NewsController::class, 'show'])->name('noticias.show');

require __DIR__.'/auth.php';

// ─── PERFIL (compartido cliente y asesor) ─────────────────────────────────────

Route::middleware('auth')->group(function () {
    Route::patch('/profile',       [ProfileController::class, 'update'])->name('profile.update');
    Route::post('/profile/avatar', [ProfileController::class, 'updateAvatar'])->name('profile.avatar');
    Route::put('/password',        [ProfileController::class, 'updatePassword'])->name('password.update');
    Route::delete('/profile',      [ProfileController::class, 'destroy'])->name('profile.destroy');
});

// ─── DASHBOARD CLIENTE ────────────────────────────────────────────────────────

Route::middleware(['auth', 'role:cliente'])->group(function () {
    Route::get('/dashboard',            [ClientDashboard::class, 'index'])->name('client.index');
    Route::get('/dashboard/citas',      [ClientDashboard::class, 'citas'])->name('client.citas');
    Route::get('/dashboard/documentos', [ClientDashboard::class, 'documentos'])->name('client.documentos');
    Route::get('/dashboard/perfil',     [ClientDashboard::class, 'perfil'])->name('client.perfil');
    Route::get('/dashboard/reserva', [ClientDashboard::class, 'reserva'])->name('client.reserva');
    Route::post('/dashboard/reserva', [ClientDashboard::class, 'storeReserva'])->name('client.reserva.store');
});

// ─── DASHBOARD ASESOR / ADMIN ─────────────────────────────────────────────────

Route::middleware(['auth', 'role:asesor,admin'])->prefix('admin')->name('admin.')->group(function () {
    Route::get('/',           [AdminDashboard::class, 'index'])->name('index');
    Route::get('/citas',      [AdminDashboard::class, 'citas'])->name('citas');
    Route::get('/documentos', [AdminDashboard::class, 'documentos'])->name('documentos');
    Route::get('/analisis',   [AdminDashboard::class, 'analisis'])->name('analisis');
    Route::get('/perfil',     [AdminDashboard::class, 'perfil'])->name('perfil');
    Route::get('/users/{id}', [UserController::class, 'show'])->name('users.show');
    Route::delete('/users/{id}', [UserController::class, 'destroy'])->name('users.destroy');
    Route::get('/clientes/{id}', [UserController::class, 'show'])->name('clientes.show');
    Route::post('/documentos',        [AdminDocumentController::class, 'store'])->name('documentos.store');
    Route::delete('/documentos/{id}', [AdminDocumentController::class, 'destroy'])->name('documentos.destroy');
    // Clientes
    Route::get('/clientes',         [UserController::class, 'index'])->name('clientes');
    Route::post('/clientes',        [UserController::class, 'store'])->name('clientes.store');
    Route::delete('/clientes/{id}', [UserController::class, 'destroy'])->name('clientes.destroy');

    // Noticias
    Route::resource('noticias', NewsController::class)->except(['show']);

    //Citas
    Route::post('/citas',              [AdminAppointmentController::class, 'store'])->name('citas.store');
    Route::patch('/citas/{id}/estado', [AdminAppointmentController::class, 'updateEstado'])->name('citas.estado');
    Route::delete('/citas/{id}',       [AdminAppointmentController::class, 'destroy'])->name('citas.destroy');
    // Anñalisis 
    
});