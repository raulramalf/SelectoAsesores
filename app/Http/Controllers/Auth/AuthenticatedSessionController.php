<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Http\Requests\Auth\LoginRequest;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;
use Inertia\Response;

class AuthenticatedSessionController extends Controller
{
    public function create(): Response
    {
        return Inertia::render('Auth/Login', [
            'canResetPassword' => Route::has('password.request'),
            'status' => session('status'),
        ]);
    }

    public function store(LoginRequest $request): RedirectResponse
    {
        $request->authenticate(); 

        $user = $request->user();

        if ($user->two_factor_confirmed_at) {
            Auth::logout(); 
            $request->session()->put('2fa:user:id', $user->id);
            $request->session()->put('2fa:auth:remember', $request->boolean('remember'));
            
            return redirect()->route('2fa.challenge');
        }

        $request->session()->regenerate();

        if ($user->role === 'admin' || $user->role === 'asesor') {
            return redirect()->route('admin.index');
        }
        
        return redirect()->route('client.index');
    }

    public function destroy(Request $request): RedirectResponse
    {
        Auth::guard('web')->logout();

        $request->session()->invalidate();

        $request->session()->regenerateToken();

        return redirect('/');
    }
}