<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class News extends Model
{
    protected $table = 'news';

    protected $fillable = [
        'titulo',
        'slug',
        'resumen',
        'content',
        'fuente',
        'source_url',
        'categoria',
        'imagen',
        'status',
        'published_at'
    ];

    protected function image(): \Illuminate\Database\Eloquent\Casts\Attribute
    {
        return \Illuminate\Database\Eloquent\Casts\Attribute::make(
            get: fn ($value) => $value ?? $this->getFallbackImage(),
        );
    }

    private function getFallbackImage()
    {
        $defaults = [
            'FISCAL'    => 'https://images.unsplash.com/photo-1554224155-6726b3ff858f?w=800',
            'LABORAL'   => 'https://images.unsplash.com/photo-1521791136364-758a39f3ef0c?w=800',
            'AUTÓNOMOS' => 'https://images.unsplash.com/photo-1450101499163-c8848c66ca85?w=800',
        ];

        return $defaults[strtoupper($this->category)] ?? 'https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=800';
    }
}