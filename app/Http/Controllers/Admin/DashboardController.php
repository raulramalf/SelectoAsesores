<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Models\Appointment;
use App\Models\Document;
use App\Models\ContactMessage;
use Illuminate\Http\Request;
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
            'solicitudes' => Appointment::with('client')
                ->latest()
                ->take(5)
                ->get()
                ->map(fn($c) => [
                    'id'        => $c->id,
                    'texto'     => $c->reason,
                    'nombre'    => $c->client?->name ?? $c->guest_name ?? '—',
                    'es_invitado' => is_null($c->client_id),
                    'estado'    => $c->status ?? 'pendiente',
                    'fecha'     => $c->date?->format('d/m/Y'),
                ]),
            'proximas_citas' => Appointment::with('client')
                ->where('date', '>=', now())
                ->where('status', '!=', 'cancelada')
                ->orderBy('date')
                ->take(5)
                ->get()
                ->map(fn($c) => [
                    'id'        => $c->id,
                    'nombre'    => $c->client?->name ?? $c->guest_name ?? '—',
                    'es_invitado' => is_null($c->client_id),
                    'razon'     => $c->reason,
                    'fecha'     => $c->date?->format('d/m/Y'),
                    'time'      => $c->time,
                    'estado'    => $c->status ?? 'pendiente',
                ]),
            'actividad' => collect()
                ->merge(
                    Appointment::with('client')->latest()->take(3)->get()->map(fn($c) => [
                        'texto' => 'Nueva cita: ' . ($c->client?->name ?? $c->guest_name ?? '—'),
                        'fecha' => $c->created_at->diffForHumans(),
                        'tipo'  => 'cita',
                    ])
                )
                ->merge(
                    Document::with('user')->latest()->take(3)->get()->map(fn($d) => [
                        'texto' => 'Documento subido: ' . $d->name,
                        'fecha' => $d->created_at->diffForHumans(),
                        'tipo'  => 'documento',
                    ])
                )
                ->merge(
                    User::where('role', 'cliente')->latest()->take(2)->get()->map(fn($u) => [
                        'texto' => 'Nuevo cliente: ' . $u->name,
                        'fecha' => $u->created_at->diffForHumans(),
                        'tipo'  => 'cliente',
                    ])
                )
                ->sortByDesc('fecha')
                ->take(6)
                ->values(),
        ]);
    }

    public function citas()
    {
        return Inertia::render('Admin/Citas', [
            'citas' => Appointment::with('client')
                ->orderBy('date')
                ->get()
                ->map(fn($c) => [
                    'id'          => $c->id,
                    'client_id'   => $c->client_id,
                    'nombre'      => $c->client?->name ?? $c->guest_name ?? '—',
                    'email'       => $c->client?->email ?? $c->guest_email ?? '—',
                    'phone'       => $c->client?->phone ?? $c->guest_phone ?? '—',
                    'es_invitado' => is_null($c->client_id),
                    'razon'       => $c->reason,
                    'fecha'       => $c->date,
                    'time'        => $c->time,
                    'descripcion' => $c->description,
                    'estado'      => $c->status ?? 'pendiente',
                ]),
            'clientes' => User::where('role', 'cliente')->get(['id', 'name']),
        ]);
    }

    public function documentos()
    {
        return Inertia::render('Admin/Documentos', [
            'documentos' => Document::with('user')->latest()->get()->map(fn($d) => [
                'id'          => $d->id,
                'nombre'      => $d->name,
                'description' => $d->description,
                'tipo'        => $d->type,
                'cliente'     => $d->user?->name,
                'fecha'       => $d->created_at->format('d/m/Y'),
                'size'        => $d->size,
                'url'         => $d->url,
            ]),
            'clientes' => User::where('role', 'cliente')->get(['id', 'name']),
        ]);
    }

    public function analisis(Request $request)
    {
        $anio = $request->get('anio', now()->year);
        $meses = ['Ene','Feb','Mar','Abr','May','Jun','Jul','Ago','Sep','Oct','Nov','Dic'];

        $clientesPorMes = User::where('role', 'cliente')
            ->whereYear('created_at', $anio)
            ->selectRaw('EXTRACT(MONTH FROM created_at) as mes, COUNT(*) as total')
            ->groupBy('mes')->orderBy('mes')->get()->keyBy('mes');

        $clientesData = collect(range(1, 12))->map(fn($m) => $clientesPorMes->get($m)?->total ?? 0);

        $citasCompletadas = Appointment::whereYear('date', $anio)->where('status', 'completada')
            ->selectRaw('EXTRACT(MONTH FROM date) as mes, COUNT(*) as total')
            ->groupBy('mes')->get()->keyBy('mes');

        $citasCanceladas = Appointment::whereYear('date', $anio)->where('status', 'cancelada')
            ->selectRaw('EXTRACT(MONTH FROM date) as mes, COUNT(*) as total')
            ->groupBy('mes')->get()->keyBy('mes');

        $completadasData = collect(range(1, 12))->map(fn($m) => $citasCompletadas->get($m)?->total ?? 0);
        $canceladasData  = collect(range(1, 12))->map(fn($m) => $citasCanceladas->get($m)?->total ?? 0);

        $servicios = Appointment::whereYear('date', $anio)
            ->selectRaw('reason, COUNT(*) as total')
            ->groupBy('reason')->orderByDesc('total')->get();

        $totalClientes       = User::where('role', 'cliente')->count();
        $clientesRecurrentes = Appointment::whereNotNull('client_id')
            ->select('client_id')->groupBy('client_id')
            ->havingRaw('COUNT(*) > 1')->get()->count();
        $tasaRetencion = $totalClientes > 0
            ? round(($clientesRecurrentes / $totalClientes) * 100, 1) : 0;

        return Inertia::render('Admin/Analisis', [
            'anio'             => (int) $anio,
            'anios'            => range(now()->year, now()->year - 3),
            'meses'            => $meses,
            'kpis'             => [
                'clientes_anio'  => User::where('role', 'cliente')->whereYear('created_at', $anio)->count(),
                'citas_anio'     => Appointment::whereYear('date', $anio)->count(),
                'completadas'    => Appointment::whereYear('date', $anio)->where('status', 'completada')->count(),
                'tasa_retencion' => $tasaRetencion,
            ],
            'clientes_data'    => $clientesData->values(),
            'completadas_data' => $completadasData->values(),
            'canceladas_data'  => $canceladasData->values(),
            'servicios'        => $servicios->map(fn($s) => [
                'label' => $s->reason,
                'total' => $s->total,
            ]),
        ]);
    }

    public function perfil()
    {
        return Inertia::render('Admin/Perfil', [
            'user' => Auth::user(),
        ]);
    }
}