<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\ContactMessage;
use App\Models\Notification; 
use App\Models\User;         

class ContactController extends Controller
{
    public function store(Request $request)
    {
        $validated = $request->validate([
            'name'    => 'required|string|max:100',
            'email'   => 'required|email',
            'phone'   => 'nullable|string|max:20',
            'subject' => 'required|string|max:150',
            'message' => 'required|string|max:1000',
        ]);

        $mensaje = ContactMessage::create($validated);

        $admins = User::whereIn('role', ['admin', 'asesor'])->get();

        foreach ($admins as $admin) {
            Notification::create([
                'user_id' => $admin->id,
                'title' => 'Nuevo mensaje de contacto',
                'message' => 'Consulta de ' . $validated['name'] . ' sobre: ' . $validated['subject'],
                'type' => 'sistema', 
                'is_read' => false,  
            ]);
        }

        session()->flash('success', 'Mensaje recibido. Te respondemos en menos de 24 horas.');

        return redirect()->route('contacto');
    }
}