<?php

namespace Tests\Feature;

use App\Models\News;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Inertia\Testing\AssertableInertia as Assert;
use Tests\TestCase;

class NewsBlogTest extends TestCase
{
    use RefreshDatabase;

    private function noticia(array $extra = []): News
    {
        static $n = 0;
        $n++;

        return News::create(array_merge([
            'title'        => "Noticia {$n}",
            'slug'         => "noticia-{$n}",
            'summary'      => 'Resumen',
            'content'      => "Primer párrafo.\n\nSegundo párrafo.",
            'category'     => 'actualidad-fiscal',
            'status'       => 'published',
            'published_at' => now(),
        ], $extra));
    }

    protected function setUp(): void
    {
        parent::setUp();
        $this->withoutVite();
        config(['services.n8n.token' => 'clave-de-prueba']);
    }

    public function test_el_blog_muestra_noticias_publicadas_de_cualquier_fecha_y_oculta_las_pendientes(): void
    {
        $this->noticia(['title' => 'De hace un mes', 'slug' => 'de-hace-un-mes', 'published_at' => now()->subMonth()]);
        $this->noticia(['title' => 'Pendiente', 'slug' => 'pendiente', 'status' => 'pending']);

        $this->get('/blog')->assertOk()->assertInertia(fn (Assert $page) => $page
            ->component('Public/Blog')
            ->has('noticias.data', 1)
            ->where('noticias.data.0.title', 'De hace un mes'));
    }

    public function test_filtra_por_categoria_y_pagina(): void
    {
        $this->noticia(['category' => 'subvenciones', 'slug' => 'sub-1', 'title' => 'Ayuda']);
        $this->noticia(['category' => 'guias-practicas', 'slug' => 'guia-1', 'title' => 'Guía']);

        $this->get('/blog?categoria=subvenciones')->assertInertia(fn (Assert $page) => $page
            ->has('noticias.data', 1)
            ->where('noticias.data.0.category', 'subvenciones'));

        foreach (range(1, 13) as $i) {
            $this->noticia(['slug' => "extra-{$i}", 'title' => "Extra {$i}"]);
        }
        $this->get('/blog')->assertInertia(fn (Assert $page) => $page
            ->has('noticias.data', 12)
            ->where('noticias.last_page', 2));
    }

    public function test_el_articulo_publicado_se_muestra_y_el_pendiente_da_404(): void
    {
        $publicada = $this->noticia(['affects' => 'Autónomos', 'impact' => 'Alto']);
        $pendiente = $this->noticia(['status' => 'pending']);

        $this->get("/blog/{$publicada->slug}")->assertOk()->assertInertia(fn (Assert $page) => $page
            ->component('Public/BlogPost')
            ->where('noticia.affects', 'Autónomos')
            ->where('noticia.impact', 'Alto'));

        $this->get("/blog/{$pendiente->slug}")->assertNotFound();
        $this->get("/noticias/{$publicada->slug}")->assertRedirect("/blog/{$publicada->slug}");
    }

    public function test_el_webhook_rechaza_peticiones_sin_clave_valida(): void
    {
        $this->postJson('/noticias/n8n', ['titulo' => 'X'])->assertStatus(401);
        $this->postJson('/noticias/n8n', ['titulo' => 'X'], ['Authorization' => 'Bearer otra'])->assertStatus(401);
        $this->assertSame(0, News::count());

        config(['services.n8n.token' => null]);
        $this->postJson('/noticias/n8n', ['titulo' => 'X'], ['Authorization' => 'Bearer ']) ->assertStatus(401);
    }

    public function test_el_webhook_crea_una_noticia_pendiente_con_los_campos_del_flujo(): void
    {
        $this->postJson('/api/webhooks/n8n/noticias', [
            'titulo'    => 'Nueva ayuda para autónomos',
            'resumen'   => 'Resumen breve',
            'contenido' => "Párrafo uno.\n\nPárrafo dos.",
            'fuente'    => 'BOE',
            'url'       => 'https://www.boe.es/ejemplo',
            'fecha'     => '2026-11-03',
            'afecta_a'  => 'Autónomos con ingresos bajos',
            'impacto'   => 'Reduce la cuota durante un año',
            'categoria' => 'AYUDAS',
        ], ['X-Webhook-Token' => 'clave-de-prueba'])->assertStatus(201);

        $n = News::firstOrFail();
        $this->assertSame('pending', $n->status);
        $this->assertSame('subvenciones', $n->category);
        $this->assertSame('Autónomos con ingresos bajos', $n->affects);
        $this->assertSame('2026-11-03', $n->source_date->format('Y-m-d'));
        $this->assertSame("Párrafo uno.\n\nPárrafo dos.", $n->content);
        $this->get('/blog')->assertInertia(fn (Assert $page) => $page->has('noticias.data', 0));
    }

    public function test_reenviar_la_misma_noticia_no_la_modifica_ni_la_despublica(): void
    {
        $n = $this->noticia(['title' => 'Mismo titular', 'slug' => 'mismo-titular']);

        $this->postJson('/noticias/n8n', ['titulo' => 'Mismo titular', 'resumen' => 'Otro'], ['Authorization' => 'Bearer clave-de-prueba'])
            ->assertOk()->assertJson(['status' => 'duplicate']);

        $this->assertSame('published', $n->fresh()->status);
        $this->assertSame('Resumen', $n->fresh()->summary);
    }

    public function test_el_webhook_valida_los_datos(): void
    {
        $this->postJson('/noticias/n8n', ['resumen' => 'sin titulo', 'url' => 'no-es-url'], ['Authorization' => 'Bearer clave-de-prueba'])
            ->assertStatus(422)->assertJsonValidationErrors(['titulo', 'url']);
    }
}
