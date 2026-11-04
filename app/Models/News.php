<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Str;

class News extends Model
{
    /** Categorías del blog: clave (se guarda en BD) => etiqueta visible. */
    public const CATEGORIES = [
        'actualidad-fiscal'       => 'Actualidad fiscal',
        'guias-practicas'         => 'Guías prácticas',
        'ecommerce-internacional' => 'Ecommerce e internacional',
        'subvenciones'            => 'Subvenciones',
    ];

    protected $fillable = [
        'title', 'content', 'summary', 'category',
        'image', 'source', 'source_url', 'source_date', 'affects', 'impact',
        'slug', 'status', 'published_at', 'created_by_automation',
    ];

    protected $casts = [
        'published_at' => 'datetime',
        'source_date'  => 'date',
    ];

    /** Convierte lo que envíe n8n ("Subvenciones", "AYUDAS", "FISCAL"…) en una clave válida. */
    public static function normalizeCategory(?string $value): string
    {
        $v = Str::slug((string) $value);

        if (isset(self::CATEGORIES[$v])) {
            return $v;
        }

        return match (true) {
            str_contains($v, 'subvenc'), str_contains($v, 'ayuda') => 'subvenciones',
            str_contains($v, 'guia') => 'guias-practicas',
            str_contains($v, 'ecommerce'), str_contains($v, 'internacional'), str_contains($v, 'comercio') => 'ecommerce-internacional',
            default => 'actualidad-fiscal',
        };
    }

    public function getCategoryLabelAttribute(): string
    {
        return self::CATEGORIES[$this->category] ?? self::CATEGORIES['actualidad-fiscal'];
    }

    protected function image(): Attribute
    {
        return Attribute::make(
            get: fn ($value) => $value ?? $this->getFallbackImage(),
        );
    }

    private function getFallbackImage(): string
    {
        return match ($this->category) {
            'guias-practicas'         => asset('images/blog/noticia-guias.webp'),
            'ecommerce-internacional' => asset('images/blog/noticia-ecommerce.webp'),
            'subvenciones'            => asset('images/blog/noticia-subvenciones.webp'),
            default                   => asset('images/blog/noticia-fiscal.webp'),
        };
    }
}
