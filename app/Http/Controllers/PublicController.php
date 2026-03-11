<?php

namespace App\Http\Controllers;

use Inertia\Inertia;

class PublicController extends Controller
{
    public function home()
    {
        return Inertia::render('Public/Home');
    }

    public function servicios()
    {
        return Inertia::render('Public/Services');
    }

    public function nosotros()
    {
        return Inertia::render('Public/About');
    }

    public function contacto()
    {
        return Inertia::render('Public/Contact');
    }
}