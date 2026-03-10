<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Appointment extends Model
{
    use HasFactory;

    protected $fillable = [
        'client_id',
        'advisor_id',
        'date',
        'time',
        'reason',
        'status',
        'description',
        'notes_advisor',
    ];

    protected function casts(): array
    {
        return [
            'date' => 'date',
        ];
    }

    public function client()
    {
        return $this->belongsTo(User::class, 'client_id');
    }

    public function advisor()
    {
        return $this->belongsTo(User::class, 'advisor_id');
    }

    public function documents()
    {
        return $this->hasMany(Document::class);
    }
}