<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Appointment;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class AppointmentController extends Controller
{
    public function store(Request $request)
    {
        $request->validate([
            'client_id'   => ['required', 'exists:users,id'],
            'reason'      => ['required', 'in:declaracion_renta,asesoria_fiscal,contabilidad,autonomos,sociedades,consultoria'],
            'date'        => ['required', 'date'],
            'time'        => ['required'],
            'description' => ['nullable', 'string', 'max:500'],
        ]);

        Appointment::create([
            'client_id'   => $request->client_id,
            'advisor_id'  => Auth::id(),
            'reason'      => $request->reason,
            'date'        => $request->date,
            'time'        => $request->time,
            'description' => $request->description,
            'status'      => 'pendiente',
        ]);

        return redirect()->back()->with('flash', ['status' => 'cita-creada']);
    }

    public function updateEstado(Request $request, string $id)
    {
        $request->validate([
            'estado' => ['required', 'in:pendiente,confirmada,cancelada,completada'],
        ]);

        $cita = Appointment::findOrFail($id);
        $cita->status = $request->estado;
        $cita->save();

        return redirect()->back();
    }

    public function destroy(string $id)
    {
        Appointment::findOrFail($id)->delete();
        return redirect()->back()->with('flash', ['status' => 'cita-eliminada']);
    }
}