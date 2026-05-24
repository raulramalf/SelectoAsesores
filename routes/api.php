<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\NewsController;

Route::post('/noticias/n8n', [NewsController::class, 'storeFromN8n']);