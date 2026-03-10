<?php

namespace App\Http\Controllers;

use Inertia\Inertia;
use App\Models\News;

class PublicController extends Controller
{
    public function home()
    {
        return Inertia::render('Public/Home');
    }

    public function servicios()
    {
        return Inertia::render('Public/Servicios');
    }

    public function nosotros()
    {
        return Inertia::render('Public/Nosotros');
    }

    public function contacto()
    {
        return Inertia::render('Public/Contacto');
    }
}