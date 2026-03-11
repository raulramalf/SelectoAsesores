<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\PublicController;
use App\Http\Controllers\AppointmentController;
use App\Http\Controllers\DocumentController;
use App\Http\Controllers\NewsController;
use App\Http\Controllers\ContactController;
use App\Http\Controllers\Client\DashboardController as ClientDashboard;
use App\Http\Controllers\Admin\DashboardController as AdminDashboard;
use App\Http\Controllers\Admin\UserController;

// ─── RUTAS PÚBLICAS ───────────────────────────────────────────────────────────

Route::get('/',                  [PublicController::class, 'home'])->name('home');
Route::get('/servicios',         [PublicController::class, 'servicios'])->name('servicios');
Route::get('/nosotros',          [PublicController::class, 'nosotros'])->name('nosotros');
Route::get('/contacto',          [PublicController::class, 'contacto'])->name('contacto');
Route::post('/contacto',         [ContactController::class, 'store'])->name('contacto.store');
Route::get('/reserva',           [AppointmentController::class, 'create'])->name('reserva');
Route::post('/reserva',          [AppointmentController::class, 'store'])->name('reserva.store');
Route::get('/noticias',          [NewsController::class, 'index'])->name('noticias');
Route::get('/noticias/{slug}',   [NewsController::class, 'show'])->name('noticias.show');

require __DIR__.'/auth.php';

// ─── DASHBOARD CLIENTE ────────────────────────────────────────────────────────

Route::middleware(['auth', 'role:cliente'])->group(function () {
    Route::get('/dashboard',             [ClientDashboard::class, 'index'])->name('client.index');
    Route::get('/dashboard/citas',       [ClientDashboard::class, 'citas'])->name('client.citas');
    Route::get('/dashboard/documentos',  [ClientDashboard::class, 'documentos'])->name('client.documentos');
    Route::get('/dashboard/perfil',      [ClientDashboard::class, 'perfil'])->name('client.perfil');
});

// ─── DASHBOARD ASESOR / ADMIN ─────────────────────────────────────────────────

Route::middleware(['auth', 'role:asesor,admin'])->prefix('admin')->name('admin.')->group(function () {
    Route::get('/',                      [AdminDashboard::class, 'index'])->name('index');
    Route::get('/citas',                 [AdminDashboard::class, 'citas'])->name('citas');
    Route::get('/documentos',            [AdminDashboard::class, 'documentos'])->name('documentos');
    Route::get('/analisis',              [AdminDashboard::class, 'analisis'])->name('analisis');
    Route::get('/perfil',                [AdminDashboard::class, 'perfil'])->name('perfil');
    Route::resource('users',             UserController::class);
    Route::resource('noticias',          NewsController::class)->except(['show']);
});