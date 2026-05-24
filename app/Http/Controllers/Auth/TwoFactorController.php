<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;
use PragmaRX\Google2FA\Google2FA;
use BaconQrCode\Renderer\ImageRenderer;
use BaconQrCode\Renderer\Image\SvgImageBackEnd;
use BaconQrCode\Renderer\RendererStyle\RendererStyle;
use BaconQrCode\Writer;
use App\Models\User;

class TwoFactorController extends Controller
{
    public function enable(Request $request)
    {
        $google2fa = new Google2FA();
        $secret = $google2fa->generateSecretKey();
        
        $request->session()->put('2fa_setup_secret', $secret);

        $qrCodeUrl = $google2fa->getQRCodeUrl(
            config('app.name'),
            $request->user()->email,
            $secret
        );

        $renderer = new ImageRenderer(new RendererStyle(200), new SvgImageBackEnd());
        $writer = new Writer($renderer);
        
        return response()->json([
            'qrCode' => $writer->writeString($qrCodeUrl)
        ]);
    }

    public function confirm(Request $request)
    {
        $request->validate(['code' => 'required|string']);
        $secret = $request->session()->get('2fa_setup_secret');

        if (!$secret) return back()->withErrors(['code' => 'La sesión caducó. Recarga la página.']);

        $google2fa = new Google2FA();
        if ($google2fa->verifyKey($secret, $request->code)) {
            $user = $request->user();
            $user->two_factor_secret = encrypt($secret);
            $user->two_factor_confirmed_at = now();
            $user->save();
            
            $request->session()->forget('2fa_setup_secret');
            return back()->with('flash', ['status' => '2fa-enabled']);
        }

        return back()->withErrors(['code' => 'El código proporcionado es incorrecto.']);
    }

    public function disable(Request $request)
    {
        $user = $request->user();
        $user->two_factor_secret = null;
        $user->two_factor_confirmed_at = null;
        $user->save();

        return back()->with('flash', ['status' => '2fa-disabled']);
    }

    public function challenge()
    {
        if (!session()->has('2fa:user:id')) return redirect()->route('login');
        return Inertia::render('Auth/TwoFactorChallenge');
    }

    public function verify(Request $request)
    {
        $request->validate(['code' => 'required|string']);
        $userId = $request->session()->get('2fa:user:id');

        if (!$userId) return redirect()->route('login');

        $user = User::find($userId);
        $google2fa = new \PragmaRX\Google2FA\Google2FA();
        
        if ($google2fa->verifyKey(decrypt($user->two_factor_secret), $request->code)) {
            Auth::loginUsingId($user->id, $request->session()->get('2fa:auth:remember', false));
            $request->session()->forget(['2fa:user:id', '2fa:auth:remember']);
            $request->session()->regenerate();

            if (in_array($user->role, ['admin', 'asesor'])) {
                return redirect()->route('admin.index');
            }
            
            return redirect()->route('client.index');
        }

        return back()->withErrors(['code' => 'El código de autenticación es inválido.']);
    }
}