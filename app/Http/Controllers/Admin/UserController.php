<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Inertia\Inertia;
use App\Models\User;

class UserController extends Controller
{
    public function index()
    {
        return Inertia::render('Admin/Clientes', [
            'users' => User::where('role', 'cliente')
                ->orderByDesc('created_at')
                ->get()
                ->map(fn($u) => [
                    'id'         => $u->id,
                    'name'       => $u->name,
                    'email'      => $u->email,
                    'phone'      => $u->phone,
                    'avatar'     => $u->avatar,
                    'created_at' => $u->created_at->format('d/m/Y'),
                ]),
        ]);
    }

    public function show(string $id)
    {
        $user = User::where('role', 'cliente')->findOrFail($id);

        return Inertia::render('Admin/ClienteDetalle', [
            'cliente' => [
                'id'         => $user->id,
                'name'       => $user->name,
                'email'      => $user->email,
                'phone'      => $user->phone,
                'avatar'     => $user->avatar,
                'created_at' => $user->created_at->format('d/m/Y'),
                'citas'      => $user->appointmentsAsClient()->orderByDesc('date')->get(),
                'documentos' => $user->documents()->orderByDesc('created_at')->get(),
            ],
        ]);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'name'     => 'required|string|max:255',
            'email'    => 'required|email|max:255|unique:users',
            'phone'    => 'nullable|string|max:20',
            'password' => 'required|string|min:8|confirmed',
        ]);

        User::create([
            'name'     => $validated['name'],
            'email'    => $validated['email'],
            'phone'    => $validated['phone'] ?? null,
            'password' => Hash::make($validated['password']),
            'role'     => 'cliente',
        ]);

        return redirect()->route('admin.clientes')->with('flash', ['status' => 'cliente-creado']);
    }

    public function destroy(string $id)
    {
        $user = User::findOrFail($id);
        $user->delete();

        return redirect()->route('admin.clientes')->with('flash', ['status' => 'cliente-eliminado']);
    }
}