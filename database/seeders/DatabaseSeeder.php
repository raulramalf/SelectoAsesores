<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash; 

class DatabaseSeeder extends Seeder
{
    use WithoutModelEvents;

    
    public function run(): void
    {
        // Crear el Asesor
        User::factory()->create([
            'name' => 'Asesor de Prueba',
            'email' => 'asesor@selecto.com',
            'password' => Hash::make('admin1234'),
            'role' => 'asesor',
        ]);

       User::factory()->create([
            'name' => 'Cliente de Prueba',
            'email' => 'cliente@gmail.com',
            'password' => Hash::make('cliente1234'),
            'role' => 'cliente',
        ]);
    }
}
