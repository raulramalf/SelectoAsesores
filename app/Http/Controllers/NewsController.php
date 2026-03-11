<?php

namespace App\Http\Controllers;

use Inertia\Inertia;
use App\Models\News;

class NewsController extends Controller
{
    public function index()
    {
        $noticias = News::where('is_published', true)
            ->orderBy('published_at', 'desc')
            ->get();

        return Inertia::render('Public/News', [
            'noticias' => $noticias
        ]);
    }

    public function show($slug)
    {
        $noticia = News::where('slug', $slug)
            ->where('is_published', true)
            ->firstOrFail();

        return Inertia::render('Public/NewsShow', [
            'noticia' => $noticia
        ]);
    }

    public function create() {}
    public function store() {}
    public function edit() {}
    public function update() {}
    public function destroy() {}
}