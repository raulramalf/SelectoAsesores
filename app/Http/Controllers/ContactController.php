<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\ContactMessage;

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

        ContactMessage::create($validated);

        session()->flash('success', 'Mensaje recibido. Te respondemos en menos de 24 horas.');

        return redirect()->route('contacto');
    }
}