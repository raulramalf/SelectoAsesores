<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('appointments', function (Blueprint $table) {
            // Cambiamos nulidad de forma compatible con Postgres
            $table->unsignedBigInteger('client_id')->nullable()->change();
            $table->unsignedBigInteger('advisor_id')->nullable()->change();
            $table->string('reason')->nullable()->change();
            $table->time('time')->nullable()->change();

            // Añadimos campos de invitado
            $table->string('guest_name')->nullable()->after('advisor_id');
            $table->string('guest_email')->nullable()->after('guest_name');
            $table->string('guest_phone')->nullable()->after('guest_email');
        });
    }

    public function down(): void
    {
        Schema::table('appointments', function (Blueprint $table) {
            $table->dropColumn(['guest_name', 'guest_email', 'guest_phone']);
        });
    }
};