<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class News extends Model
{
    use HasFactory;

    protected $fillable = [
        'title',
        'slug',
        'summary',
        'content',
        'source_url',
        'category',
        'published_at',
        'is_published',
        'created_by_automation',
    ];

    protected function casts(): array
    {
        return [
            'published_at'          => 'datetime',
            'is_published'          => 'boolean',
            'created_by_automation' => 'boolean',
        ];
    }
}