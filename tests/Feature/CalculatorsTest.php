<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class CalculatorsTest extends TestCase
{
    use RefreshDatabase;

    public function test_calculator_pages_render(): void
    {
        $this->withoutVite();

        foreach (['/blog', '/blog?tab=calculadoras', '/blog/calculadoras/irpf', '/blog/calculadoras/autonomos'] as $url) {
            $this->get($url)->assertOk();
        }

        $this->get('/noticias')->assertRedirect('/blog');
        $this->get('/noticias/calculadoras/irpf')->assertRedirect('/blog/calculadoras/irpf');
    }
}
