<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Models\Appointment;
use App\Models\Document;
use App\Models\ContactMessage;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;

class DashboardController extends Controller
{
    public function index()
    {
        return Inertia::render('Admin/Dashboard', [
            'stats' => [
                'clientes'   => User::where('role', 'cliente')->count(),
                'citas'      => Appointment::whereMonth('date', now()->month)->count(),
                'documentos' => Document::whereDate('created_at', '>=', now()->subDays(7))->count(),
                'mensajes'   => ContactMessage::whereNull('read_at')->count(),
            ],
            'solicitudes' => Appointment::with('user')
                ->latest()
                ->take(5)
                ->get()
                ->map(fn($c) => [
                    'id'     => $c->id,
                    'texto'  => $c->reason,
                    'nombre' => $c->user?->name ?? $c->name,
                    'estado' => $c->status ?? 'pendiente',
                    'fecha'  => $c->date,
                ]),
        ]);
    }

    public function citas()
    {
        return Inertia::render('Admin/Citas', [
            'citas' => Appointment::with('user')
                ->orderBy('date')
                ->get()
                ->map(fn($c) => [
                    'id'          => $c->id,
                    'nombre'      => $c->user?->name ?? $c->name,
                    'email'       => $c->user?->email ?? $c->email,
                    'razon'       => $c->reason,
                    'fecha'       => $c->date,
                    'descripcion' => $c->description,
                    'estado'      => $c->status ?? 'pendiente',
                ]),
        ]);
    }

    public function documentos()
    {
        return Inertia::render('Admin/Documentos', [
            'documentos' => Document::with('user')
                ->latest()
                ->get()
                ->map(fn($d) => [
                    'id'      => $d->id,
                    'nombre'  => $d->name,
                    'tipo'    => $d->type,
                    'cliente' => $d->user?->name,
                    'fecha'   => $d->created_at->format('d/m/Y'),
                    'size'    => $d->size,
                    'url'     => $d->path,
                ]),
        ]);
    }

    public function analisis()
    {
        return Inertia::render('Admin/Analisis', [
            'stats' => [
                'clientes_mes'   => User::where('role', 'cliente')
                    ->whereMonth('created_at', now()->month)->count(),
                'citas_mes'      => Appointment::whereMonth('date', now()->month)->count(),
                'docs_mes'       => Document::whereMonth('created_at', now()->month)->count(),
                'mensajes_mes'   => ContactMessage::whereMonth('created_at', now()->month)->count(),
            ],
        ]);
    }

    public function perfil()
    {
        return Inertia::render('Admin/Perfil', [
            'user' => Auth::user(),
        ]);
    }
}