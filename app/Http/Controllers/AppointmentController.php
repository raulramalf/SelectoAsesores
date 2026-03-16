<?php

namespace App\Http\Controllers;

use Inertia\Inertia;
use Illuminate\Http\Request;
use App\Models\Appointment;
use App\Models\User;

class AppointmentController extends Controller
{
    // Mapeo de razones del formulario público → valores del ENUM de la BD
    private array $reasonMap = [
        'Declaración de la Renta (IRPF)' => 'declaracion_renta',
        'Asesoría Fiscal Integral'        => 'asesoria_fiscal',
        'Contabilidad de Empresa'         => 'contabilidad',
        'Gestión de Autónomos'            => 'autonomos',
        'Constitución de Sociedades'      => 'sociedades',
        'Consultoría Tributaria'          => 'consultoria',
        'Otra consulta'                   => 'consultoria',
    ];

    public function create()
    {
        return Inertia::render('Public/Appointment');
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'name'        => 'required|string|max:100',
            'email'       => 'required|email|max:150',
            'phone'       => 'required|string|max:20',
            'reason'      => 'required|string|max:200',
            'date'        => 'required|date|after:today',
            'description' => 'nullable|string|max:500',
        ]);

        // Convertir la razón legible al valor del ENUM
        $reasonEnum = $this->reasonMap[$validated['reason']] ?? 'consultoria';

        // Asignar el primer asesor disponible
        $asesor = User::where('role', 'asesor')
            ->orWhere('role', 'admin')
            ->first();

        Appointment::create([
            'client_id'   => null,
            'advisor_id'  => $asesor?->id,
            'guest_name'  => $validated['name'],
            'guest_email' => $validated['email'],
            'guest_phone' => $validated['phone'],
            'reason'      => $reasonEnum,
            'date'        => $validated['date'],
            'time'        => '09:00',
            'status'      => 'pendiente',
            'description' => $validated['description'] ?? null,
        ]);

        return redirect()->route('reserva')->with('flash', [
            'success' => '¡Cita solicitada correctamente! Nos pondremos en contacto en menos de 24 horas.'
        ]);
    }
}