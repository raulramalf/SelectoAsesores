<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Appointment extends Model
{
    protected $fillable = [
        'client_id',
        'advisor_id',
        'guest_name',
        'guest_email',
        'guest_phone',
        'reason',
        'date',
        'time',
        'status',
        'description',
    ];

    protected $casts = [
        'date' => 'date',
    ];

    public function client()
    {
        return $this->belongsTo(User::class, 'client_id');
    }

    public function advisor()
    {
        return $this->belongsTo(User::class, 'advisor_id');
    }

    // Nombre a mostrar: cliente registrado o invitado
    public function getNombreDisplayAttribute(): string
    {
        return $this->client?->name ?? $this->guest_name ?? 'Sin nombre';
    }

    // Email a mostrar
    public function getEmailDisplayAttribute(): string
    {
        return $this->client?->email ?? $this->guest_email ?? '—';
    }

    // Teléfono a mostrar
    public function getTelefonoDisplayAttribute(): string
    {
        return $this->client?->phone ?? $this->guest_phone ?? '—';
    }

    // Si la cita es de un invitado (sin cuenta)
    public function getEsInvitadoAttribute(): bool
    {
        return is_null($this->client_id);
    }
}