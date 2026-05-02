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
        News::updateOrCreate(
            ['slug' => Str::slug(Str::limit($request->titulo, 200, ''))],
            [
                'title'        => $request->titulo,
                'summary'      => $request->resumen,
                'content'      => $request->resumen,
                'source'       => $request->fuente,
                'source_url'   => $request->url,
                'category'     => $request->categoria ?? 'FISCAL',
                'image'        => $request->imagen,
                'status'       => 'pending',
                'published_at' => now(),
            ]
        );
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