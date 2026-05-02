<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{

    public function up(): void
    {
        Schema::table('news', function (Blueprint $table) {
            if (!Schema::hasColumn('news', 'image')) $table->string('image')->nullable();
            if (!Schema::hasColumn('news', 'category')) $table->string('category')->default('FISCAL');
            if (!Schema::hasColumn('news', 'summary')) $table->text('summary')->nullable();
            if (!Schema::hasColumn('news', 'source')) $table->string('source')->nullable();
            if (!Schema::hasColumn('news', 'source_url')) $table->text('source_url')->nullable();
            if (!Schema::hasColumn('news', 'published_at')) $table->timestamp('published_at')->nullable();
            if (!Schema::hasColumn('news', 'slug')) $table->string('slug')->unique()->nullable();
            if (!Schema::hasColumn('news', 'status')) $table->string('status')->default('pending');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('news', function (Blueprint $table) {
            //
        });
    }
};
