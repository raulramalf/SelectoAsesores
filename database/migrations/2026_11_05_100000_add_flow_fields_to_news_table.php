<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('news', function (Blueprint $table) {
            if (!Schema::hasColumn('news', 'source_date')) {
                $table->date('source_date')->nullable();
            }
            if (!Schema::hasColumn('news', 'affects')) {
                $table->text('affects')->nullable();
            }
            if (!Schema::hasColumn('news', 'impact')) {
                $table->text('impact')->nullable();
            }
        });

        // Las categorías antiguas (FISCAL, LABORAL, AUTÓNOMOS…) pasan a "Actualidad fiscal".
        DB::table('news')
            ->where(fn ($q) => $q->whereNull('category')->orWhereNotIn('category', [
                'actualidad-fiscal', 'guias-practicas', 'ecommerce-internacional', 'subvenciones',
            ]))
            ->update(['category' => 'actualidad-fiscal']);
    }

    public function down(): void
    {
        Schema::table('news', function (Blueprint $table) {
            $table->dropColumn(['source_date', 'affects', 'impact']);
        });
    }
};
