<?php

namespace App\Http\Controllers;

use Inertia\Inertia;
use Illuminate\Http\Request;
use App\Models\Appointment;

class AppointmentController extends Controller
{
    public function index()
    {
        return Inertia::render('Client/Citas');
    }

    public function create()
    {
        return Inertia::render('Public/Appointment');
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'name'        => 'required|string|max:100',
            'email'       => 'required|email',
            'phone'       => 'required|string|max:20',
            'reason'      => 'required|string',
            'date'        => 'required|date|after:today',
            'description' => 'nullable|string|max:500',
        ]);

        // Por ahora guardamos en sesión y confirmamos
        // Cuando tengamos auth lo asociamos al usuario
        session()->flash('success', '¡Cita solicitada correctamente! Nos pondremos en contacto contigo en menos de 24 horas.');

        return redirect()->route('reserva');
    }

    public function show($id) {}
    public function edit($id) {}
    public function update(Request $request, $id) {}
    public function destroy($id) {}
}