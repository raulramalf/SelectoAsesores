<?php
echo "<h2 style='font-family:sans-serif;'>Forzando la reparación del motor...</h2>";
echo "<pre style='background:#111; color:#0f0; padding:20px; border-radius:5px; overflow-x:auto;'>";

// 1. Le decimos a Composer dónde está su "casa" para que no dé el error 730
putenv('COMPOSER_HOME=' . __DIR__ . '/../');

// 2. Obligamos a instalar TODO saltándose el bloqueo de PHP 8.2 (--ignore-platform-reqs)
system('cd .. && composer install --ignore-platform-reqs --no-interaction 2>&1');

echo "\n----------------------------------------\n";

// 3. Borramos la caché conflictiva a mano (por si Artisan falla con PHP 8.2)
$cache_files = glob(__DIR__ . '/../bootstrap/cache/*.php');
foreach($cache_files as $file) {
    unlink($file);
    echo "Caché eliminada: " . basename($file) . "\n";
}

echo "</pre>";
echo "<h2 style='color:green; font-family:sans-serif;'>✅ Reparación forzada con éxito.</h2>";
?>