<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('appointments', function (Blueprint $table) {
            // Hacer client_id y advisor_id nullables para reservas públicas
            $table->foreignId('client_id')->nullable()->change();
            $table->foreignId('advisor_id')->nullable()->change();

            // Campos para reservas de invitados (sin cuenta)
            $table->string('guest_name')->nullable()->after('advisor_id');
            $table->string('guest_email')->nullable()->after('guest_name');
            $table->string('guest_phone')->nullable()->after('guest_email');

            // Hacer reason y time nullables para reservas públicas
            $table->string('reason')->nullable()->change();
            $table->time('time')->nullable()->change();
        });
    }

    public function down(): void
    {
        Schema::table('appointments', function (Blueprint $table) {
            $table->dropColumn(['guest_name', 'guest_email', 'guest_phone']);
            $table->foreignId('client_id')->nullable(false)->change();
            $table->foreignId('advisor_id')->nullable(false)->change();
        });
    }
};