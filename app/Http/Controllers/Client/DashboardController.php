<?php

namespace App\Http\Controllers\Client;

use App\Http\Controllers\Controller;
use App\Models\Appointment;
use App\Models\User;
use Illuminate\Http\Request;
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
                'total_citas' => $user->appointmentsAsClient()->count(),
                'documentos'  => $user->documents()->count(),
            ],
            'documentos_recientes' => $user->documents()->latest()->take(3)->get()->map(fn($d) => [
                'id'     => $d->id,
                'nombre' => $d->name,
                'tipo'   => $d->type,
                'fecha'  => $d->created_at->format('d/m/Y'),
                'url'    => $d->url,
            ]),
            'actividad' => $actividad,
        ]);
    }

    public function citas()
    {
        $user = Auth::user();

        return Inertia::render('Client/Appoiments', [
            'citas' => $user->appointmentsAsClient()
                ->orderBy('date', 'desc')
                ->get()
                ->map(fn($c) => [
                    'id'          => $c->id,
                    'reason'      => $c->reason,
                    'date'        => $c->date->format('Y-m-d'),
                    'time'        => $c->time,
                    'status'      => $c->status ?? 'pendiente',
                    'description' => $c->description,
                ]),
        ]);
    }

    public function documentos()
    {
        $user = Auth::user();

        return Inertia::render('Client/Documents', [
            'documentos' => $user->documents()
                ->latest()
                ->get()
                ->map(fn($d) => [
                    'id'          => $d->id,
                    'nombre'      => $d->name,
                    'tipo'        => $d->type,
                    'descripcion' => $d->description,
                    'fecha'       => $d->created_at->format('d/m/Y'),
                    'size'        => $d->size,
                    'url'         => $d->url,
                ]),
        ]);
    }

    public function reserva()
    {
        return Inertia::render('Client/Reserva');
    }

    public function storeReserva(Request $request)
    {
        $request->validate([
            'reason'      => ['required', 'in:declaracion_renta,asesoria_fiscal,contabilidad,autonomos,sociedades,consultoria'],
            'date'        => ['required', 'date', 'after:today'],
            'time'        => ['required'],
            'description' => ['nullable', 'string', 'max:500'],
        ]);

        $user   = Auth::user();
        $asesor = User::where('role', 'asesor')->first();

        Appointment::create([
            'client_id'   => $user->id,
            'advisor_id'  => $asesor->id,
            'reason'      => $request->reason,
            'date'        => $request->date,
            'time'        => $request->time,
            'description' => $request->description,
            'status'      => 'pendiente',
        ]);

        return redirect()->route('client.citas')->with('flash', ['status' => 'cita-solicitada']);
    }

    public function perfil()
    {
        return Inertia::render('Client/Profile');
    }
}