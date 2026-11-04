<?php

namespace App\Http\Controllers;

use App\Models\News;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;
use Inertia\Inertia;

class NewsController extends Controller
{
    private const POR_PAGINA = 12;

    public function index(Request $request)
    {
        $categoria = $request->query('categoria');
        $categoria = isset(News::CATEGORIES[$categoria]) ? $categoria : null;
        $busqueda  = trim((string) $request->query('q', ''));

        $query = News::query()->where('status', 'published');

        if ($categoria) {
            $query->where('category', $categoria);
        }

        if ($busqueda !== '') {
            $query->where(fn ($q) => $q
                ->where('title', 'like', "%{$busqueda}%")
                ->orWhere('summary', 'like', "%{$busqueda}%"));
        }

        $noticias = $query
            ->orderByRaw('COALESCE(published_at, created_at) DESC')
            ->orderByDesc('id')
            ->paginate(self::POR_PAGINA)
            ->withQueryString()
            ->through(fn (News $n) => [
                'id'             => $n->id,
                'title'          => $n->title,
                'slug'           => $n->slug,
                'summary'        => $n->summary,
                'category'       => $n->category,
                'category_label' => $n->category_label,
                'image'          => $n->image,
                'source'         => $n->source,
                'date'           => optional($n->published_at ?? $n->created_at)->format('d/m/Y'),
            ]);

        return Inertia::render('Public/Blog', [
            'tab'        => $request->query('tab') === 'calculadoras' ? 'calculadoras' : 'noticias',
            'noticias'   => $noticias,
            'categorias' => collect(News::CATEGORIES)
                ->map(fn ($label, $slug) => ['slug' => $slug, 'label' => $label])
                ->values(),
            'filtros'    => ['categoria' => $categoria, 'q' => $busqueda],
        ]);
    }

    public function show(string $slug)
    {
        $n = News::where('slug', $slug)->where('status', 'published')->firstOrFail();

        return Inertia::render('Public/BlogPost', [
            'noticia' => [
                'title'          => $n->title,
                'summary'        => $n->summary,
                'content'        => $n->content,
                'category'       => $n->category,
                'category_label' => $n->category_label,
                'image'          => $n->image,
                'source'         => $n->source,
                'source_url'     => $n->source_url,
                'source_date'    => optional($n->source_date)->format('d/m/Y'),
                'affects'        => $n->affects,
                'impact'         => $n->impact,
                'date'           => optional($n->published_at ?? $n->created_at)->format('d/m/Y'),
            ],
        ]);
    }

    public function adminIndex()
    {
        return Inertia::render('Admin/Noticias', [
            'noticias' => News::orderByDesc('created_at')->get()
        ]);
    }

    /**
     * Recepción automatizada desde n8n. Exige la clave N8N_WEBHOOK_TOKEN (ver docs/N8N.md).
     * La noticia entra como "pendiente" y solo se publica al aprobarla en el panel.
     */
    public function storeFromN8n(Request $request)
    {
        $esperado = (string) config('services.n8n.token');
        $recibido = (string) ($request->bearerToken() ?: $request->header('X-Webhook-Token', ''));

        if ($esperado === '' || $recibido === '' || !hash_equals($esperado, $recibido)) {
            Log::warning('Webhook de noticias rechazado: clave ausente o incorrecta', ['ip' => $request->ip()]);
            return response()->json(['status' => 'unauthorized'], 401);
        }

        $validator = Validator::make($request->all(), [
            'titulo'    => ['required', 'string', 'max:255'],
            'resumen'   => ['nullable', 'string', 'max:3000'],
            'contenido' => ['nullable', 'string', 'max:60000'],
            'fuente'    => ['nullable', 'string', 'max:255'],
            'url'       => ['nullable', 'url', 'max:2048'],
            'fecha'     => ['nullable', 'date'],
            'afecta_a'  => ['nullable', 'string', 'max:1500'],
            'impacto'   => ['nullable', 'string', 'max:3000'],
            'categoria' => ['nullable', 'string', 'max:100'],
            'imagen'    => ['nullable', 'url', 'max:2048'],
        ]);

        if ($validator->fails()) {
            return response()->json(['status' => 'invalid', 'errors' => $validator->errors()], 422);
        }

        $d = $validator->validated();
        $slug = Str::slug(Str::limit($d['titulo'], 200, ''));

        // Idempotente: reenviar la misma noticia no la modifica ni la despublica.
        if (News::where('slug', $slug)->exists()) {
            return response()->json(['status' => 'duplicate'], 200);
        }

        News::create([
            'slug'                  => $slug,
            'title'                 => $d['titulo'],
            'summary'               => $d['resumen'] ?? null,
            'content'               => $d['contenido'] ?? ($d['resumen'] ?? null),
            'source'                => $d['fuente'] ?? null,
            'source_url'            => $d['url'] ?? null,
            'source_date'           => $d['fecha'] ?? null,
            'affects'               => $d['afecta_a'] ?? null,
            'impact'                => $d['impacto'] ?? null,
            'category'              => News::normalizeCategory($d['categoria'] ?? null),
            'image'                 => $d['imagen'] ?? null,
            'status'                => 'pending',
            'created_by_automation' => true,
        ]);

        return response()->json(['status' => 'success'], 201);
    }

    public function aprobar(News $noticia)
    {
        $noticia->update(['status' => 'published', 'published_at' => now()]);
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
