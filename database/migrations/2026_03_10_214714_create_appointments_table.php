<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('appointments', function (Blueprint $table) {
            $table->id();
            $table->foreignId('client_id')->constrained('users')->cascadeOnDelete();
            $table->foreignId('advisor_id')->constrained('users')->cascadeOnDelete();
            $table->date('date');
            $table->time('time');
            $table->enum('reason', [
                'declaracion_renta',
                'asesoria_fiscal',
                'contabilidad',
                'autonomos',
                'sociedades',
                'consultoria'
            ]);
            $table->enum('status', [
                'pendiente',
                'confirmada',
                'cancelada',
                'completada'
            ])->default('pendiente');
            $table->text('description')->nullable();
            $table->text('notes_advisor')->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('appointments');
    }
};