<?php

namespace App\Http\Controllers\Client;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;

class DashboardController extends Controller
{
    public function index()
    {
        return Inertia::render('Client/Dashboard');
    }

    public function citas()
    {
        return Inertia::render('Client/Appoiments', [
            'citas' => Auth::user()->appointmentsAsClient()->get(),
        ]);
    }

    public function documentos()
    {
        return Inertia::render('Client/Documents', [
            'documentos' => Auth::user()->documents()->get(),
        ]);
    }

    public function perfil()
    {
        return Inertia::render('Client/Profile');
    }
}