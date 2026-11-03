<?php

namespace Tests\Feature;

use Tests\TestCase;

class CalculatorsTest extends TestCase
{
    public function test_calculator_pages_render(): void
    {
        $this->withoutVite();

        foreach (['', '/irpf', '/autonomos'] as $suffix) {
            $this->get('/noticias/calculadoras' . $suffix)->assertOk();
        }
    }
}
