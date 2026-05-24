<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;

class User extends Authenticatable
{
    use HasFactory, Notifiable;

    protected $fillable = [
        'name',
        'email',
        'password',
        'role',
        'phone',
        'avatar',
    ];

    protected $hidden = [
        'password',
        'remember_token',
    ];

    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'password' => 'hashed',
        ];
    }

    // Relaciones
    public function company()
    {
        return $this->hasOne(Company::class);
    }

    public function appointmentsAsClient()
    {
        return $this->hasMany(Appointment::class, 'client_id');
    }

    public function appointmentsAsAdvisor()
    {
        return $this->hasMany(Appointment::class, 'advisor_id');
    }

    public function documents()
    {
        return $this->hasMany(Document::class);
    }

    public function notifications()
    {
        return $this->hasMany(Notification::class);
    }

    public function performanceReports()
    {
        return $this->hasMany(PerformanceReport::class, 'advisor_id');
    }

    // Helpers de rol
    public function isAdmin(): bool
    {
        return $this->role === 'admin';
    }

    public function isAdvisor(): bool
    {
        return $this->role === 'asesor';
    }

    public function isClient(): bool
    {
        return $this->role === 'cliente';
    }
}