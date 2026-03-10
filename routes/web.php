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

// RUTAS PÚBLICAS 
Route::get('/', [PublicController::class, 'home'])->name('home');
Route::get('/servicios', [PublicController::class, 'servicios'])->name('servicios');
Route::get('/nosotros', [PublicController::class, 'nosotros'])->name('nosotros');
Route::get('/noticias', [NewsController::class, 'index'])->name('noticias');
Route::get('/noticias/{slug}', [NewsController::class, 'show'])->name('noticias.show');
Route::get('/contacto', [PublicController::class, 'contacto'])->name('contacto');
Route::post('/contacto', [ContactController::class, 'store'])->name('contacto.store');
Route::get('/reserva', [AppointmentController::class, 'create'])->name('reserva');
Route::post('/reserva', [AppointmentController::class, 'store'])->name('reserva.store');


require __DIR__.'/auth.php';

// DASHBOARD CLIENTE 
Route::middleware(['auth', 'role:cliente'])->prefix('dashboard')->name('client.')->group(function () {
    Route::get('/', [ClientDashboard::class, 'index'])->name('index');
    Route::get('/citas', [AppointmentController::class, 'index'])->name('citas');
    Route::get('/documentos', [DocumentController::class, 'index'])->name('documentos');
});

// DASHBOARD ASESOR / ADMIN 
Route::middleware(['auth', 'role:asesor,admin'])->prefix('admin')->name('admin.')->group(function () {
    Route::get('/', [AdminDashboard::class, 'index'])->name('index');
    Route::resource('users', UserController::class);
    Route::resource('citas', AppointmentController::class);
    Route::resource('documentos', DocumentController::class);
    Route::resource('noticias', NewsController::class);
});