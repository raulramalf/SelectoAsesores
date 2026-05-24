<?php

namespace App\Http\Controllers;

use App\Models\News;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use Inertia\Inertia;
use Carbon\Carbon;

class NewsController extends Controller
{
    public function index()
    {
        return Inertia::render('Public/News', [
            'noticias' => News::where('status', 'published')
                ->whereDate('created_at', Carbon::today())
                ->orderByDesc('created_at')
                ->get()
        ]);
    }

    public function adminIndex()
    {
        return Inertia::render('Admin/Noticias', [
            'noticias' => News::orderByDesc('created_at')->get()
        ]);
    }

   public function storeFromN8n(Request $request)
    {
        // 1. Recogemos los datos desde n8n
        $titulo = $request->input('titulo') ?: 'Sin título';
        $resumen = $request->input('resumen') ?: 'Sin resumen';
        $fuente = $request->input('fuente') ?: 'General';
        $url = $request->input('url') ?: 'https://selectoasesores.com';
        $categoria = $request->input('categoria') ?: 'FISCAL';
        $imagen = $request->input('imagen') ?: null;

        // 2. ESCUDO ANTI-LÍMITES (Evita el error 255 caracteres de Postgres)
        // Cortamos el título a 250 caracteres como máximo
        $tituloLimpio = Str::limit($titulo, 250, '');
        $urlLimpia = Str::limit($url, 250, '');
        
        // Si la URL de la imagen mide más de 255 caracteres, la anulamos porque romperá la BD
        if ($imagen && strlen($imagen) > 255) {
            $imagen = null;
        }

        // 3. Buscamos si la noticia ya existe para no duplicar
        $noticia = News::firstOrNew(['source_url' => $urlLimpia]);

        // 4. Asignación directa
        $noticia->title = $tituloLimpio;
        $noticia->slug = Str::slug(Str::limit($tituloLimpio, 200, ''));
        $noticia->summary = $resumen;
        $noticia->content = $resumen;
        $noticia->source = Str::limit($fuente, 250, ''); // Protegemos la fuente también
        $noticia->category = Str::limit($categoria, 250, '');
        $noticia->image = $imagen;
        $noticia->status = 'pending';

        // 5. Guardamos forzosamente en la base de datos
        $noticia->save();

        return response()->json(['status' => 'success'], 200);
    }

    public function aprobar(News $noticia)
    {
        $noticia->update(['status' => 'published']);
        return back();
    }

    public function destroy(News $noticia)
    {
        $noticia->delete();
        return back();
    }

    public function destroyAll()
    {
        News::truncate();
        return back();
    }
}