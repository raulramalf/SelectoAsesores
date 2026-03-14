<?php

namespace App\Http\Controllers\Client;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;

class DashboardController extends Controller
{
    public function index()
    {
        $user = Auth::user();

        $proximaCita = $user->appointmentsAsClient()
            ->where('date', '>=', now())
            ->where('status', '!=', 'cancelada')
            ->orderBy('date')
            ->first();

        $documentos = $user->documents()
            ->latest()
            ->take(3)
            ->get();

        $actividad = collect()
            ->merge(
                $user->appointmentsAsClient()->latest()->take(3)->get()->map(fn($c) => [
                    'texto' => 'Cita: ' . $c->reason,
                    'fecha' => $c->created_at->diffForHumans(),
                    'tipo'  => 'cita',
                ])
            )
            ->merge(
                $user->documents()->latest()->take(3)->get()->map(fn($d) => [
                    'texto' => 'Documento: ' . $d->name,
                    'fecha' => $d->created_at->diffForHumans(),
                    'tipo'  => 'documento',
                ])
            )
            ->sortByDesc('fecha')
            ->take(5)
            ->values();

        return Inertia::render('Client/Dashboard', [
            'proxima_cita' => $proximaCita ? [
                'id'     => $proximaCita->id,
                'razon'  => $proximaCita->reason,
                'fecha'  => $proximaCita->date->format('d/m/Y'),
                'time'   => $proximaCita->time,
                'estado' => $proximaCita->status,
            ] : null,
            'stats' => [
                'total_citas'  => $user->appointmentsAsClient()->count(),
                'documentos'   => $user->documents()->count(),
            ],
            'documentos_recientes' => $documentos->map(fn($d) => [
                'id'    => $d->id,
                'nombre'=> $d->name,
                'tipo'  => $d->type,
                'fecha' => $d->created_at->format('d/m/Y'),
                'url'   => $d->url,
            ]),
            'actividad' => $actividad,
        ]);
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