<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\NewsController;

Route::post('/webhooks/n8n/noticias', [NewsController::class, 'storeFromN8n']);