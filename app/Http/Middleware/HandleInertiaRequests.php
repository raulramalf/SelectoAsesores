<?php

namespace App\Http\Middleware;

use App\Models\ContactMessage;
use Illuminate\Http\Request;
use Inertia\Middleware;

class HandleInertiaRequests extends Middleware
{
    protected $rootView = 'app';

    public function version(Request $request): ?string
    {
        return parent::version($request);
    }

    public function share(Request $request): array
    {
        return [
            ...parent::share($request),
            'auth' => [
                'user' => $request->user()?->only([
                    'id', 'name', 'email', 'phone', 'role', 'avatar'
                ]),
            ],
            'flash' => [
                'status'  => $request->session()->get('flash.status')  ?? $request->session()->get('status'),
                'success' => $request->session()->get('flash.success') ?? $request->session()->get('success'),
                'error'   => $request->session()->get('flash.error')   ?? $request->session()->get('error'),
            ],
            // Contador de mensajes no leídos — solo si es asesor/admin
            'mensajes_sin_leer' => $request->user()?->role === 'asesor' || $request->user()?->role === 'admin'
                ? ContactMessage::whereNull('read_at')->count()
                : 0,
        ];
    }
}